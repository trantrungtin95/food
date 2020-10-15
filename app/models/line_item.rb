class LineItem < ApplicationRecord
    belongs_to :dish
    belongs_to :cart
    belongs_to :order, optional: true
    belongs_to :restaurant, optional: true

    def total_price
        dish.price * quantity
    end
end
