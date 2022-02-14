require 'uri'
require 'net/http'

class GamesController < ApplicationController
  def new
    @letters = (0..10).map { ('a'..'z').to_a[rand(26)] }.join('  ')
  end

  def score
    url = URI("https://wagon-dictionary.herokuapp.com/#{params[:score]}")

    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE

    request = Net::HTTP::Get.new(url)
    request['x-api-key'] = ENV['SYGIC_API_KEY']
    request['cache-control'] = 'no-cache'

    @response = http.request(request)
    @hash = JSON.parse @response.body.gsub('=>', ':')
    @answer = if @hash['found'] == true
                'correct! you win'
              else
                "nice try! #{@hash['word']} wasn't a word!"
              end
  end
end
