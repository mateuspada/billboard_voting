class BillboardsController < ApplicationController
  require "csv"

  before_action :set_billboard, only: %i[show votes]

  # List all billboards ordered by votes
  def index
    @billboards = Billboard.order(votes: :desc)
  end

  # Show a single billboard
  def show
  end

  # Ingest a CSV file to add billboards
  def create
    if params[:file].present?
      CSV.foreach(params[:file].path, headers: false) do |row|
        address, image = row
        Billboard.create(address: address, image: image, votes: 0)
      end
      redirect_to billboards_path, notice: "CSV successfully imported!"
    else
      redirect_to billboards_path, alert: "Please upload a valid CSV file."
    end
  end

  # Vote up or down for a billboard
  def votes
    if params[:vote] == "up"
      @billboard.increment!(:votes)
    elsif params[:vote] == "down"
      @billboard.decrement!(:votes)
    end

    respond_to do |format|
      format.html { redirect_to billboards_path }
      format.turbo_stream
    end
  end

  private

  def set_billboard
    @billboard = Billboard.find(params[:id])
  end


end
