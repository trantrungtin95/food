class CouponCode < ApplicationRecord
    belongs_to :restaurant
    validates :coupon_code, presence: true
    validates :discount, presence: true, numericality: {only_float: true}
    validate :end_date_is_date?

    private

    def end_date_is_date?
        if !end_date.is_a?(ActiveSupport::TimeWithZone)
        errors.add(:end_date, 'must be a valid date') 
        end
    end
end
