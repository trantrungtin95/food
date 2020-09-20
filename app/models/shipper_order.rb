class ShipperOrder < ApplicationRecord
    belongs_to :shipper
    belongs_to :order
end
