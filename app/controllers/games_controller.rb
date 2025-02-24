require 'net/http'
require 'json'
class GamesController < ApplicationController

  def new
    @letters = (0...10).map { ('A'..'Z').to_a[rand(26)] }
  end

  def score
    @attempt = params['word']
    letters = params["letters"]
    url = "https://dictionary.lewagon.com/#{@attempt}"
    @condition = @attempt.upcase.chars.map { |letter| letters.include?(letter) && letters.delete!(letter)}

    uri = URI(url)
    response = Net::HTTP.get(uri)
    data = JSON.parse(response)

    @attempt = @attempt.upcase

    if @condition.include?(false)
      @result = "Sorry but #{@attempt}  can't be built out of: #{letters}"
    elsif data['found'] == true
      @result = "Congratulations! #{@attempt} is a valid English word"
    else
      @result = "Sorry but #{@attempt}  does not seem to be a valid English word..."
    end
  end
end
