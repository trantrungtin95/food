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

    has_many :votes, :dependent => :destroy
    has_many :line_items, :dependent => :destroy
    before_destroy :check_if_has_line_item

    scope :find_dishes_name, -> (search){ where("name LIKE ?", "%#{search}%")}
    # Ex:- scope :active, -> {where(:active => true)}

    def dish_vote
        # TODO: self.votes.pluck(:rate) run 2 times --> assign variables
        # Consider to account in db
        # sprintf "%.2f" % ((self.votes.pluck(:rate).sum).fdiv(self.votes.pluck(:rate).size))
        self.votes.average(:rate)
    end

    def rounding(x)
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

    def rating(user)
        self.votes.where(user_id: user.id).first
    end

    private
  
    def check_if_has_line_item
        if line_items.empty?
            # return true
            true
        else
            errors.add(:base, 'This dish has a LineItem')
            # return false
            false
        end
    end
end
