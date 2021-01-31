# frozen_string_literal: true
#require 'pry'; binding.pry #rubocop:disable all

require_relative 'answer'
require 'yaml'

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
      new_turn while @incorrect_guesses.length < GAME_LENGTH && @answer.solved? == false
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
      guess = fetch_guess
      save_game if guess == 'SAVE'
      guess = guess[0]
      unless @answer.check(guess)
        @incorrect_guesses.push(guess)
        @incorrect_guesses = @incorrect_guesses.sort
      end
    end

    def fetch_guess
      guess = ' '
      until guess[0] &&
            guess.upcase[0].between?('A', 'Z') &&
            !@incorrect_guesses.include?(guess.upcase[0]) ||
            guess.upcase == 'SAVE'
        print 'Enter guess: '
        guess = gets.chomp.upcase
      end
      guess
    end

    def display
      puts "\n#{@answer.display}\n\nIncorrect guesses: #{@incorrect_guesses.join(', ')}\n\n"
    end

    def save_game
      dump = YAML.dump(self)
      File.open('.savegame', 'w') { |file| file.write(dump) }
      puts 'Game saved.'
      exit
    end

    def self.load_game
      saved_game = File.open('.savegame', 'r')
      object = YAML.load(saved_game)
      saved_game.close
      object
    end
  end
end
