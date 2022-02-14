class GamesController < ApplicationController
  def new
    @letters = (0..10).map { ('a'..'z').to_a[rand(26)] }.join('  ')
  end

  def score
    raise
  end
end
