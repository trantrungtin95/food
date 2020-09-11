module CommentsHelper
    def generate_comment_content(comment)
        restaurant = comment.restaurant
        padding_left = 20 * comment.level
        content = content_tag(:p, style: "padding-left: #{padding_left}px", class: 'comment', id: "comment-#{comment.id}") do
            
            tag = content_tag(:span)
            tag += content_tag(:strong) do
                t = link_to comment.user.name, user_path(comment.user)
            end
            tag += content_tag(:strong, " said: ")
            tag += comment.content
            tag +=" - "
            tag += content_tag(:i,"created " + time_ago_in_words(comment.created_at) + " ago")
            tag += "|"
            tag += link_to ' Reply', Rails.application.routes.url_helpers.new_restaurant_comment_path(restaurant, comment_id: comment.id), remote: true
            
        end
    
        children = ""
        comment.children_comments.each do |children_comment|
            children += generate_comment_content(children_comment)
        end
        

        content += content_tag(:div, id: "children-comment-#{comment.id}") do
            raw children
        end
    end 
end
