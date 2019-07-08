class GamesController < ApplicationController
  def new
    @letters = Array.new(10) { ('A'..'Z').to_a.sample }
  end

  def score
    @answer = params[:answer].upcase
    @letters = params[:letters]
    if included?(@answer, @letters)
      english_word?(@answer) ? @message = 'Congratulations!' : @message = "#{@answer} is not a valid English word."
    else
      @message = "#{@answer} is not in the grid."
    end
  end

  def included?(answer, grid)
    answer.chars.all? { |letter| answer.count(letter) <= grid.count(letter) }
  end

  def english_word?(word)
    response = URI("https://wagon-dictionary.herokuapp.com/#{word}")
    json = JSON(response.read)
    json['found']
  end
end
