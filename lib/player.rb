# frozen_string_literal: true

# Players
class Player
  attr_reader :token

  def initialize(token = 'X')
    @token = token
  end

  def take_turn
    puts "\nPlayer #{@token}, what is your move?"
    @move = gets.to_i
    until @move >= 1 && @move <= 9
      puts 'Pick a space between 1-9!'
      @move = gets.to_i
    end
    @move
  end
end
