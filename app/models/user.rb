require 'digest/sha2'

class User < ApplicationRecord
    has_many :line_items
    has_many :orders
    has_many :restaurants
    has_many :dishes
    has_many :votes
    has_many :resvotes
    has_many :comments
    has_many :roomchats
    has_many :shippervotes
    has_many :uservotes
    has_many :cart
    belongs_to :shipper, optional: true, :dependent => :destroy
    validates :name, :email, :presence => true, :uniqueness => true
    validates :password, :confirmation => true
    attr_accessor :password_confirmation
    attr_reader :password
  
    validate :password_must_be_present
    STATUS = [:costomer, :owner, :shipper]

    def User.encrypt_password(password, salt) 
        Digest::SHA2.hexdigest(password + salt)
    end
  
    def password=(password) 
        @password = password
  
        if password.present?
            generate_salt
            self.hashed_password = self.class.encrypt_password(password, salt)
        end
    end
  
    def User.authenticate(name, password) 
        if user = find_by_name(name)
            if user.hashed_password == encrypt_password(password, user.salt)
               user
            end
        end
    end

    after_destroy :check_user_empty
  
    def check_user_empty
        if User.count.zero?
            raise "Can't delete last user"
        end
    end

    def shipper_by(user)
        Shipper.where(user_id: user.id).present?
    end

    def received(user, order)
        shipper = Shipper.where(user_id: user.id).first
        ShipperOrder.where(shipper_id: shipper.id, order_id: order.id).present?
    end 

    def orders_received
        if Shipper.where(user_id: id).present? 
            shipper_id = Shipper.where(user_id: id).first.id
            orders_received = ShipperOrder.where(shipper_id: shipper_id).present?
        end
    end

    def uncompleted_order
        if Shipper.where(user_id: id).present? 
            shipper_id = Shipper.where(user_id: id).first.id
            ShipperOrder.where(shipper_id: shipper_id, status: "Processing").present?
        end
    end

    private
    def password_must_be_present 
        if hashed_password.present? == false
            errors.add(:password, "Missing password")
        end
    end
  
    def generate_salt  
        self.salt = self.object_id.to_s + rand.to_s
    end

end
