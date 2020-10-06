class Shippervote < ApplicationRecord
    belongs_to :shipper
    belongs_to :user
    belongs_to :order
end
