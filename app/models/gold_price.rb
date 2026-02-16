class GoldPrice < ApplicationRecord

    scope :latest_set, -> { 
    where(timestamp: maximum(:timestamp))
    .order(purity: :desc) 
     } 

end
