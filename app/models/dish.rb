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

    has_many :votes
    has_many :line_items
    before_destroy :check_if_has_line_item

    scope :find_dishes_name, -> (search){ where("name LIKE ?", "%#{search}%")}
    # Ex:- scope :active, -> {where(:active => true)}

    def dish_vote
        sprintf "%.2f" % ((self.votes.pluck(:rate).sum).fdiv(self.votes.pluck(:rate).size))
    end

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
