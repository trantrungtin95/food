class Comment < ApplicationRecord
    before_create :set_level

    belongs_to :user
    belongs_to :restaurant
    belongs_to :comment, optional: true

    def children_comments
        Comment.where(comment_id: self.id)
    end

    private
    def set_level
        if comment_id.present?
          self.level = comment.level + 1
        end
    end
end
