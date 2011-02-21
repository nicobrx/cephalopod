class OptimalBidsController < ApplicationController
  def new
    @optimal_bid = OptimalBid.new
  end
 
  def show
    @title = "Calculating Bids with Confidence Intervals"
    @optimal_bid = OptimalBid.find(params[:id])
  end
 
  def create
    @optimal_bid = OptimalBid.new(params[:optimal_bid])
    if @optimal_bid.save
      redirect_to @optimal_bid
    else
      render 'new'
    end
  end
  
  def update
    @optimal_bid = OptimalBid.find(params[:id])
    if @optimal_bid.update_attributes(params[:optimal_bid])
      redirect_to @optimal_bid
    else
      render 'new'
    end
  end
  
end