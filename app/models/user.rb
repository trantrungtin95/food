class User < ApplicationRecord
    validates :name, :presence => true
    validates :name, :uniqueness => true
    STATUS = [:costomer, :owner, :shipper]
end
