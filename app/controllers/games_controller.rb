require "open-uri"
require 'json'
require 'time'

class GamesController < ApplicationController
  # command i type
  # rails generate controller games new score
  def new
    @start_time = Time.now
    @letters = (('A'..'Z').to_a).sample(10)
  end

  def score
    # raise
    # binding.pry
    @score = 0
    @end_time = Time.now
    @result = false
    @letters = params[:letters].upcase.chars
    # @word = params[:word].upcase.chars
    @word = params[:word].upcase
    @included = included?(@word, @letters)
    @english = english?(@word)
    @score = - @word.length.to_i * 100_000 - @end_time.to_i + @start_time.to_i
    if @included && @english
      @result = true
    end
    @result = false
  end

  def included?(word, letters)
    if word.blank?
      @included = false
    else
      word.upcase.chars.each do |x|
        if letters.include?('x') == false || word.count(x) > letters.count(x)
          @included = false
        end
      end
    end
    @included = true
  end

  def english?(word)
    response = open("https://wagon-dictionary.herokuapp.com/#{word}")
    # raise
    # tough parttttt
    json = JSON.parse(response.read)
    json['found']
  end
end
