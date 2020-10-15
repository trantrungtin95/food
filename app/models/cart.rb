class Cart < ApplicationRecord
    has_many :line_items, dependent: :destroy
    belongs_to :restaurant

    def add_dish(dish_id, restaurant_id)
        current_item = line_items.find_by_dish_id(dish_id)
        if current_item 
            current_item.quantity += 1
        else
            current_item = line_items.build(:dish_id => dish_id, 
                                                :restaurant_id => restaurant_id, 
                                                quantity: 1)
        end
        current_item
    end

    def total_price
        line_items.sum { |item| item.total_price }
    end

end
