class Restaurant < ApplicationRecord
    belongs_to :user
    has_many :dishes, :dependent => :destroy

    scope :find_restaurants_name, -> (search){ where("name LIKE ?", "%#{search}%")}
    
    reverse_geocoded_by :latitude, :longitude
end
