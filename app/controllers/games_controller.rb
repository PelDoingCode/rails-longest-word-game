class GamesController < ApplicationController
  # command i type
  # rails generate controller games new score
  def new
    @letters = (('A'..'Z').to_a).sample(10)
  end

  def score
  end
end
