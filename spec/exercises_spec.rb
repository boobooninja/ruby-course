require './exercises.rb'

describe 'Exercise 0' do
  it "triples the length of a string" do
    result = Exercises.ex0("ha")
    expect(result).to eq("hahaha")
  end

  it "returns 'nope' if the string is 'wishes'" do
    result = Exercises.ex0("wishes")
    expect(result).to eq("nope")
  end
end

describe 'Exercise 1' do
  it "returns the number of elements in an array" do
    result = Exercises.ex1([1,2,3])
    expect(result).to eq(3)
  end
end

describe 'Exercise 2' do
  it "returns second element in an array" do
    array = [1,2,3]
    value = 2
    result = Exercises.ex2(array)
    expect(result).to eq(value)
  end
end

describe 'Exercise 3' do
  it "returns sum of given array of numbers" do
    array = [1,2,3]
    value = 6
    result = Exercises.ex3(array)
    expect(result).to eq(value)
  end
end

describe 'Exercise 4' do
  it "returns max value in array" do
    array = [1,2,3]
    value = 3
    result = Exercises.ex4(array)
    expect(result).to eq(value)
  end
end

describe 'Exercise 5' do
  it "puts each element in an array" do
    array = [1,2,3]
    STDOUT.should_receive(:puts).and_return(1, 2, 3)
    Exercises.ex5(array)
  end
end

describe 'Exercise 6' do
  context 'when last element == panda' do
    it "updates last to 'GODZILLA'" do
      array = ['hand', 'foot', 'panda']
      value = "GODZILLA"
      result = Exercises.ex6(array)
      expect(result).to eq(value)
    end
  end
  context 'when last element != panda' do
    it "updates last to 'panda'" do
      array = ['hand', 'foot', 'mouth']
      value = "panda"
      result = Exercises.ex6(array)
      expect(result).to eq(value)
    end
  end
end

describe 'Exercise 7' do
  context 'when given string exists' do
    it "adds string to end of array" do
      array = ['hand', 'GODZILLA', 'foot', 'panda']
      value = "GODZILLA"
      result = Exercises.ex7(array, value)
      expect(result[-1]).to eq(value)
    end
  end
  context 'when given string does not exist' do
    it "does not add string to end of array" do
      array = ['hand', 'foot', 'mouth']
      value = "panda"
      result = Exercises.ex7(array, value)
      expect(result[-1]).to eq("mouth")
    end
  end
end

describe 'Exercise 8' do
  it "puts each element in an array" do
    hash1 = { :name => 'Bob', :occupation => 'Builder' }
    hash2 = { :name => 'George', :occupation => 'Gymnast' }
    hash3 = { :name => 'Al', :occupation => 'Attorney' }
    array = [hash1, hash2, hash3]
    STDOUT.should_receive(:puts).and_return("Bob: Builder", "George: Gymnast", "Al: Attorney")
    Exercises.ex8(array)
  end
end

describe 'Exercise 9' do
  context 'when given time is a leap year' do
    it "returns true" do
      time = Time.new
      Date.should_receive(:leap?).with(time.year).and_return(true)
      result = Exercises.ex9(time)
    end
  end
  context 'when given time is not a leap year' do
    it "returns false" do
      time = Time.new
      Date.should_receive(:leap?).with(time.year).and_return(false)
      result = Exercises.ex9(time)
    end
  end
end



