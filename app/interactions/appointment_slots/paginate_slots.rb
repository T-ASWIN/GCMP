require 'pagy'

class AppointmentSlots::PaginateSlots < ActiveInteraction::Base
  include Pagy::Backend

 object :slots, class: ActiveRecord::Relation
  integer :page, default: 1
  integer :per_page, default: 8

  def execute
    pagy, paginated_items = pagy(slots, page: page, items: per_page)
    
    { metadata: pagy, items: paginated_items }
  end

  private

  def params
    {}
  end
end