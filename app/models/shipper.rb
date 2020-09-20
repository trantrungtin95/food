class Shipper < ApplicationRecord
    belongs_to :user
    has_many :shipper_orders
end
