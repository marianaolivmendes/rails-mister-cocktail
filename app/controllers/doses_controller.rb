class DosesController < ApplicationController
  before_action :set_cocktail, only: [:new, :create]

  def new
    # @cocktail = Cocktail.find(params[:id])
    @dose = Dose.new
  end

  def create
    @dose = Dose.new(@dose_params)
    # @cocktail = Cocktail.find(params[:id])
    @dose.cocktail = @cocktail
    @dose.save
    redirect_to cocktail_path(@cocktail)
  end

  def destroy
    @dose = Dose.find(params[:id])
    @dose.destroy
    redirect_to cocktail_path(@dose.cocktail)
  end

  private

  def set_cocktail
    @cocktail = Cocktail.find(params[:id])
  end

  def dose_params
    params.require(:dose).permit(:description, :ingredient)
  end
end
