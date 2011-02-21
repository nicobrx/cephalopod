class AddConversionBoundsToOptimalBids < ActiveRecord::Migration
  def self.up
    add_column :optimal_bids, :conversion_rate_upper, :float
    add_column :optimal_bids, :conversion_rate_lower, :float
  end

  def self.down
    remove_column :optimal_bids, :conversion_rate_lower
    remove_column :optimal_bids, :conversion_rate_upper
  end
end
