class PagesController < ApplicationController
  def home
    @title = "SEM Bid Optimization Tools"
  end

  def calculator
    @title = "Calculating Bids with Confidence Intervals"
    @optimal_bid = OptimalBid.new
  end

end
