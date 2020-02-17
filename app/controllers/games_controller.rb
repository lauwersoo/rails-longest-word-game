require "open-uri"

class GamesController < ApplicationController

  def new
    letters_a = ('A'...'Z').to_a
    letters_b = %w(A E I O U Y)
    letters = letters_a - letters_b
    rand_a = letters.sample(7)
    rand_b = letters_b.sample(4)
    @letters = (rand_a + rand_b).shuffle
  end

  def score
    @answer = params[:word]
    @letters = params[:letters]
    @api = api(@answer)
    # @answer.each do |letter|
    #   count_answer_letter = @answer.count(letter)
    #   count_letters_letter = @letters.count(letter)
    #   if count_answer_letter <= count_letters_letter
    #     return true
    #   else
    #     return false
    #   end
    # end
  end

  private

  def api(word)
    response = open("https://wagon-dictionary.herokuapp.com/#{word}")
    json = JSON.parse(response.read)
    json['found']
  end
end
