class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception



  def request_heroes(url)

    request = Typhoeus::Request.new(url)
    resp = request.run
    if resp.code == 200
      data = resp.body
      result = JSON.parse(data)
      result
    end
  end


end
