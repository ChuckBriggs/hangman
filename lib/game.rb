# frozen_string_literal: true
#require 'pry'; binding.pry #rubocop:disable all

require_relative 'answer'

DICTIONARY = '5desk.txt'
GAME_LENGTH = 6

# asdf class init comment
module Hangman
  class Game
    def initialize
      @answer = Answer.new(DICTIONARY)
      @incorrect_guesses = []
    end

    def play
      while @incorrect_guesses.length < GAME_LENGTH && @answer.solved? == false
        new_turn
      end
      if @incorrect_guesses.length >= GAME_LENGTH
        @answer.loser
      elsif @answer.solved? == true
        @answer.winner
      else
        @answer.loser
      end
    end

    def new_turn
      display
      print "Enter guess: "
      guess = gets.chomp.upcase
      if guess == 'SAVE'
        save_game
      end
      guess = guess[0]
      unless @answer.check(guess)
        @incorrect_guesses.push(guess)
      end
    end

    def display
      puts "\n#{@answer.display}\n\nIncorrect guesses: #{@incorrect_guesses.join(', ')}\n\n"
    end

    def save_game
      puts "Game saved. (Not really.)"
      exit
    end
  end
end
