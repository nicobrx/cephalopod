class CreateOptimalBids < ActiveRecord::Migration
  def self.up
    create_table :optimal_bids do |t|
      t.float :bid_lower
      t.float :bid_upper
      t.integer :conversions
      t.integer :clicks
      t.float :cpa
      t.float :confidence_percent

      t.timestamps
    end
  end

  def self.down
    drop_table :optimal_bids
  end
end
