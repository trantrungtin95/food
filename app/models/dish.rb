class Dish < ApplicationRecord
    validates :name, :image_url, :presence => true
    validates :price, :numericality =>{:greater_than_or_equal_to => 1.0}
    validates :name, :uniqueness => true
    validates :image_url, :format =>{
              :with => %r{\.(gif|jpg|png|jpeg)\Z}i,
              :message => 'Chi nhan file GIF, JPG, PNG, JPEG'
    }
end