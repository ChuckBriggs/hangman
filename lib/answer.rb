# frozen_string_literal: true
#require 'pry'; binding.pry #rubocop:disable all

module Hangman
  class Answer
    def initialize(dictionary)
      @answer = ''
      until @answer.length.between?(5,12) && @answer[0].between?('a','z')
        @answer = File.readlines(dictionary).sample.chomp.split('')
      end
      @answer = @answer.map { |x| x = x.upcase }
      @visible_answer = []
      while @visible_answer.length < @answer.length
        @visible_answer.push('_')
      end
    end

    def display
      @visible_answer.join(' ')
    end

    def solved?
      @visible_answer == @answer
    end

    def check(char)
      match = false
      @answer.each_with_index do | x, i |
        if char == x
          @visible_answer[i] = char
          match = true
        end
      end
      match
    end

    def winner
      puts "\n#{@answer.join(' ')}\n\n"
      puts "You win.\n\n"
      if File.exist?('.savegame')
        File.delete('.savegame')
      end
      exit
    end

    def loser
      puts "\nYou lose. The answer was \"#{answer.join.downcase}\".\n\n"
      if File.exist?('.savegame')
        File.delete('.savegame')
      end
      exit
    end

    private

    attr_reader :answer
  end
end
