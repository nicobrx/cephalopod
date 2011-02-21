class OptimalBid < ActiveRecord::Base
  
  attr_accessible :bid_lower, :bid_upper, :bid, :conversions, :clicks, :cpa, :confidence_percent, :conversion_rate,
    :conversion_rate_lower, :conversion_rate_upper, :p_prime
    
  validates :clicks, :presence => true, :numericality => {:greater_than => :conversions}
  validates :conversions, :presence => true, :numericality => true
  validates :cpa, :presence => true, :numericality =>  {:greater_than => 0}
  validates :confidence_percent, :presence => true, :numericality => true
  
  before_save :calculated_values
  
  
  def clicks=(num)
    num = num.gsub(/,/,'') if num.is_a?(String)
    write_attribute(:clicks, num.to_i)
  end
  
  def conversions=(num)
    num = num.gsub(/,/,'') if num.is_a?(String)
    write_attribute(:conversions, num.to_i)
  end
  
  def cpa=(num)
    num = num.gsub('$','') if num.is_a?(String)
    write_attribute(:cpa, num.to_i)
  end
  
  private
    
    def calculated_values
      calculate_interval
      calculate_conversion_rate
      calculate_bid_lower
      calculate_bid_upper
      calculate_bid
    end
    
    def calculate_interval
      if (clicks > 0)
        case self.confidence_percent
        when 0.8
          z = 1.2816
        when 0.9
          z = 1.6449
        when 0.95
          z = 1.96
        when 0.99
          z = 2.5758
        else 
          self.confidence_percent = 0.9
          z = 1.6449
        end
        #begin adj wald, move to class later
        p_prime = (self.conversions.to_f + (z*z/2))/(self.clicks.to_f + z*z)
        self.conversion_rate_lower = p_prime-z*Math.sqrt((p_prime*(1-p_prime))/(self.conversions.to_f + z*z))
        self.conversion_rate_lower = 0 if self.conversion_rate_lower < 0
        self.conversion_rate_upper = p_prime+z*Math.sqrt((p_prime*(1-p_prime))/(self.conversions.to_f + z*z))
        #end adj wald
      end 
    end
    
    def calculate_conversion_rate
         self.conversion_rate = self.conversions.to_f/self.clicks.to_f
    end
    
    def calculate_bid_lower
      if self.conversion_rate_lower
        self.bid_lower = self.cpa * self.conversion_rate_lower
        self.bid_lower = self.bid_lower.round(2)
      end
    end
    
    def calculate_bid_upper
      if self.conversion_rate_upper
        self.bid_upper = self.cpa * self.conversion_rate_upper
        self.bid_upper = self.bid_upper.round(2)
      end
    end
    
    def calculate_bid
      if self.conversion_rate
        self.bid = self.cpa * self.conversion_rate
        self.bid = self.bid.round(2)
      end
    end
    
end
