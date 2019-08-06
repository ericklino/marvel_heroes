class HeroesController < ApplicationController
  before_action :set_key, only: [:index, :show, :comics]

  def index
    options = {}
    options[:limit] = 24
    options[:offset] = (params[:page].to_i - 1) * 24   if params[:page].to_i > 1


    @heroes = @heroes_json.request_heroes("characters", options)
  end

  def show
    @heroe = @heroes_json.request_heroes("characters/#{params[:id]}")["data"]["results"].first
    @series = @heroes_json.request_heroes("characters/#{params[:id]}/series") if @heroe["series"]["available"] > 0
    @comics = @heroes_json.request_heroes("characters/#{params[:id]}/comics") if @heroe["comics"]["available"] > 0
    # @stories = @heroes_json.request_heroes("characters/#{params[:id]}/stories") if @heroe["stories"]["available"] > 0
    # @events = @heroes_json.request_heroes("characters/#{params[:id]}/events") if @heroe["events"]["available"] > 0
  end

  def comics
    options = {}
    options = params.slice(:limit, :offset)

    @comics = @heroes_json.request_heroes("characters/#{params[:id]}/comics", options)

    respond_to do |format|
      #format.html # show.html.erb
      format.json { render json: @comics }
    end
  end

  private

  def set_key
    @heroes_json = Heroe.new(ENV['PRIVATE_KEY'], ENV['PUBLIC_KEY'])
  end

end
