class AddFieldsToOptimalBids < ActiveRecord::Migration
  def self.up
    add_column :optimal_bids, :bid, :float
    add_column :optimal_bids, :conversion_rate, :float
  end

  def self.down
    remove_column :optimal_bids, :conversion_rate
    remove_column :optimal_bids, :bid
  end
end
