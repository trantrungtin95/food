class Restaurant < ApplicationRecord
    belongs_to :user
    has_many :dishes
    scope :find_restaurants_name, -> (search){ where("name LIKE ?", "%#{search}%")}
end
