class Api::HeroesController < ApplicationController
  #adicionando o concern
  include Authenticable

  before_action :authenticate_with_token
  before_action :set_hero, only: %i[ show update destroy ]

  # GET /heroes
  def index
    #trazendo por ordem alfabética de nome do jeito nao adequado
    #@heroes = Hero.all.order(:name)
    @heroes = Hero.by_token(@token).search_by_name(params[:term]).sorted_by_name

    render json: @heroes
  end

  # GET /heroes/1
  def show
    render json: @hero
  end

  # POST /heroes
  def create
    #inclui o token ao hero params
    @hero = Hero.new(hero_params.to_h.merge!({token: @token}))

    if @hero.save
      #esse api_hero_url é para nao dar erro no create devido ao namespace
      render json: @hero, status: :created, location: api_hero_url(@hero)
    else
      render json: @hero.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /heroes/1
  def update
    if @hero.update(hero_params)
      render json: @hero
    else
      render json: @hero.errors, status: :unprocessable_entity
    end
  end

  # DELETE /heroes/1
  def destroy
    @hero.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_hero
      @hero = Hero.by_token(@token).find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def hero_params
      params.require(:hero).permit(:name)
    end
end
