class Order < ApplicationRecord
    has_many :line_items, :dependent => :destroy
    has_many :roomchats, :dependent => :destroy
    belongs_to :restaurant
    belongs_to :shippervote, optional: true
    belongs_to :uservote, optional: true
    belongs_to :shipper_order, optional: true, :dependent => :destroy
    belongs_to :user
    PAYMENT_TYPES = [ "Cash on delivery", "Ngân lượng", "Bảo Kim", "Bank Card" ]
    
    validates :name, :address, :email, :pay_type, :presence => true
    validates :pay_type, :inclusion => PAYMENT_TYPES

    def add_line_items_from_cart(cart) 
        cart.line_items.each do |item|
            item.cart_id = nil
            line_items << item
        end
    end

    def location_order(address)
        results = Geocoder.search(address).first.coordinates
    end

    def chat_room
        roomchats
    end
    
end
