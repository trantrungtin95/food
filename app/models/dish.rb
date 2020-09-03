class Dish < ApplicationRecord
    belongs_to :user
    belongs_to :restaurant
    validates :name, :image_url, :presence => true
    validates :price, :numericality =>{:greater_than_or_equal_to => 1.0}
    validates :name, :uniqueness => true
    validates :image_url, :format =>{
              :with => %r{\.(gif|jpg|png|jpeg)\Z}i,
              :message => 'Chi nhan file GIF, JPG, PNG, JPEG'
    }

    has_many :line_items
    before_destroy :check_if_has_line_item

    private
  
    def check_if_has_line_item
        if line_items.empty?
            return true
        else
            errors.add(:base, 'This dish has a LineItem')
            return false
        end
    end
end
