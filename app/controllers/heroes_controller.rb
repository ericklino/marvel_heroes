class HeroesController < ApplicationController

  def index
    @ts = Time.now.strftime("%Y-%m-%d %H:%M")
    @url = "http://gateway.marvel.com/v1/public/characters?&ts=#{URI.encode(@ts)}&apikey=#{ENV['PUBLIC_KEY']}&hash=#{md5(@ts)}"

    @heroes = request_heroes(@url)
  end

  def show
  end

  private
    def request_heroes(url)
      request = Typhoeus::Request.new(url)
      resp = request.run
      if resp.code == 200
        data = resp.body
        result = JSON.parse(data)
        result
      end
    end

    def md5(ts)
      @md5 = Digest::MD5.hexdigest(ts + ENV['PRIVATE_KEY'] + ENV['PUBLIC_KEY'])
      @md5
    end
end
