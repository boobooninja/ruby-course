require './rps.rb'

describe 'RPS' do
  describe '.initialize' do
    it 'sets player names' do
      name1 = 'Loren'
      name2 = 'Mark'
      game = RPS.new(name1, name2)
      expect(game.players).to eq([name1, name2])
    end
  end

  describe '.play' do
    it 'accepts player moves and returns winner' do
      name1 = 'Loren'
      name2 = 'Mark'
      game = RPS.new(name1, name2)
      expect(game.play('rock', 'paper')).to eq(name2)
      expect(game.play('paper', 'rock')).to eq(name1)
      expect(game.play('scissors', 'scissors')).to eq('tie')
      expect { game.play('blah', 'scissors')}.to raise_error
    end
  end
end
