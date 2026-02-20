class GoldPrice < ApplicationRecord
    scope :latest_set, -> {
      
    where(id: select("DISTINCT ON (purity) id").order("purity, timestamp DESC"))
      .order(purity: :desc)
  }
end
