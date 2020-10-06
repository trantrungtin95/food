class Shipper < ApplicationRecord
    belongs_to :user
    has_many :shipper_orders
    has_many :shippervotes
    has_many :uservotes
end
