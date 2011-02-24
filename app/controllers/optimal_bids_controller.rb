class OptimalBidsController < ApplicationController
  def new
    @optimal_bid = OptimalBid.new
  end
 
  def show
    @optimal_bid = OptimalBid.find(params[:id])
  end
 
  def create
    @title = "Calculating Bids with Confidence Intervals"
    @optimal_bid = OptimalBid.new(params[:optimal_bid])
    if @optimal_bid.save
      render 'show'
    else
      render 'new'
    end
  end
  
  def update
    @title = "Calculating Bids with Confidence Intervals"
    @optimal_bid = OptimalBid.find(params[:id])
    if @optimal_bid.update_attributes(params[:optimal_bid])
      render 'show'
    else
      render 'new'
    end
  end
  
end