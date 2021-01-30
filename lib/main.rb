# frozen_string_literal: true
#require 'pry'; binding.pry #rubocop:disable all

require_relative 'game'

include Hangman

if File.exist?('.savegame')
  game = Game.load_game
else
  game = Game.new
end

puts "\nEnter \"save\" as your guess to save and exit. Play will\
      \nresume from where you left off when you return."

game.play
