class Restaurant < ApplicationRecord
    belongs_to :user
    has_many :orders, :dependent => :destroy
    has_many :carts, :dependent => :destroy
    has_many :coupon_codes, :dependent => :destroy
    has_many :comments, :dependent => :destroy
    has_many :resvotes
    has_many :line_items
    has_many :dishes, :dependent => :destroy

    scope :find_restaurants_name, -> (search){ where("name LIKE ?", "%#{search}%")}
    
    reverse_geocoded_by :latitude, :longitude

    def restaurant_vote
        self.resvotes.average(:rating)
    end

    def resvote_rounding(x)
        a = x - x.floor
        if a < 0.25
            x = x.floor
        elsif 0.25 <= a && a < 0.75
            a = 0.5
            x = x.floor + a
        else
            x = x.floor + 1
        end
        x
    end

    def resvoted(user)
        self.resvotes.where(user_id: user.id).first
    end

    def root_comments
        comments.where(comment_id: nil)
    end


    def self.json_near_by(latitude, longitude)
      restaurants = Restaurant.near([latitude,longitude], 200)
      restaurants.to_json(only: [:name, :latitude, :longitude])
    end


end
