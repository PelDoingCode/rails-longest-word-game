require "open-uri"

class GamesController < ApplicationController
  # command i type
  # rails generate controller games new score
  def new
    @letters = (('A'..'Z').to_a).sample(10)
  end

  def score
    # raise
    # binding.pry
    @result = false
    @letters = params[:letters].upcase.chars
    @letters = params[:word].upcase.chars
    @included = included?(@word, @letters)
    @english = english?(@word)
    if @included && @english
      @result = true
    end
    @result = false
  end

  def included?(word, letters)
    if word.blank?
      return false
    end
    word.each do |x|
      if letters.include('x') == false || word.count(x) > letters.count(x)
        return false
      end
    end
    true
  end

  def english?(word)
    response = open("https://wagon-dictionary.herokuapp.com/#{word}")
    # raise
    # tough parttttt
    json = JSON.parse(response.read)
    json['found']
  end
end

