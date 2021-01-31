# frozen_string_literal: true
#require 'pry'; binding.pry #rubocop:disable all

require_relative 'game'

include Hangman

puts "\nEnter \"save\" as your guess to save and exit. Play will\
      \nresume from where you left off when you return."

game = if File.exist?('.savegame')
         Game.load_game
       else
         Game.new
       end

game.play
