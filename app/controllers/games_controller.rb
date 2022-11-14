require 'open-uri'

class GamesController < ApplicationController

  def new
    alphabet = 'abcdefghijklmnopqrstuvwxyz'
    @letters = alphabet.split('').sample(10).shuffle!
  end

  def score
    @word = params[:word]
    if letter_in_grid? && check_dict?
      @result = "Parabens"
    else
      @result = "Errou"
    end
  end

  def check_dict?
    url = "https://wagon-dictionary.herokuapp.com/#{@word}"
    dictionary = URI.open(url)
    uri = JSON.parse(dictionary.read)
    return uri["found"]
  end

  def letter_in_grid?
    array = @word.split('')
    booleans = []
    array.each do |letter|
      booleans << params[:letters].include?(letter)
    end
    booleans.select { |boolean| boolean == true }.size == booleans.size
  end
end
