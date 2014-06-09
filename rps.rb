#!/usr/bin/env ruby

class RPS
  # Rock, Paper, Scissors
  # Make a 2-player game of rock paper scissors. It should have the following:
  #
  # It is initialized with two strings (player names).
  # It has a `play` method that takes two strings:
  #   - Each string reperesents a player's move (rock, paper, or scissors)
  #   - The method returns the winner (player one or player two)
  #   - If the game is over, it returns a string stating that the game is already over
  # It ends after a player wins 2 of 3 games
  #
  # You will be using this class in the following class, which will let players play
  # RPS through the terminal.

  attr_reader :players

  def initialize(name1, name2)
    @players = [name1, name2]
  end

  def play(play1, play2)
    case play1
      when 'rock'
        return 'tie' if play2 == 'rock'
        return players.last if play2 == 'paper'
        return players.first if play2 == 'scissors'
      when 'paper'
        return players.first if play2 == 'rock'
        return 'tie' if play2 == 'paper'
        return players.last if play2 == 'scissors'
      when 'scissors'
        return players.last if play2 == 'rock'
        return players.first if play2 == 'paper'
        return 'tie' if play2 == 'scissors'
      else
        raise 'invalid move'
    end
  end
end


require 'io/console'
class RPSPlayer
  # (No specs are required for RPSPlayer)
  #
  # Complete the `start` method so that it uses your RPS class to present
  # and play a game through the terminal.
  #
  # The first step is to read (gets) the two player names. Feed these into
  # a new instance of your RPS class. Then `puts` and `gets` in a loop that
  # lets both players play the game.
  #
  # When the game ends, ask if the player wants to play again.
  def self.start

    puts "Enter First Player's Name"
    player1 = gets.chomp

    puts "Enter Second Player's Name"
    player2 = gets.chomp

    game = RPS.new(player1, player2)

    score = {player1 => 0, player2 => 0}

    while score[player1] < 2 && score[player2] < 2
      puts "Enter Player One's Move: ('rock', 'paper', 'scissors')"
      move1 = gets.chomp
      puts "Enter Player Two's Move: ('rock', 'paper', 'scissors')"
      move2 = gets.chomp
      winner = game.play(move1, move2)
      score[winner] += 1
      puts "#{winner} won that round!"
    end

    winner = score[player1] > score[player2] ? player1 : player2

    puts "#{winner} won the game!"
    puts "Do you want to play again? ('yes' or 'no')"
    play_again = gets.chomp

    self.start if play_again == 'yes'

    puts 'Thanks for playing'
    # TODO

    # PRO TIP: Instead of using plain `gets` for grabbing a player's
    #          move, this line does the same thing but does NOT show
    #          what the player is typing! :D
    # This is also why we needed to require 'io/console'
    # move = STDIN.noecho(&:gets)
  end
end

RPSPlayer.start
