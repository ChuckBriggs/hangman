# frozen_string_literal: true
#require 'pry'; binding.pry #rubocop:disable all

require_relative 'game'

include Hangman

game = Game.new
game.play
