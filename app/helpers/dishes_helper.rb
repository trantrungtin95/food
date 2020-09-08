module DishesHelper
    def rating_title(rating)
        {
            '5' => "Awesome - 5 stars",
            '4.5' => "Pretty good - 4.5 stars",
            '4' => "Pretty good - 4 stars",
            '3.5' => "Meh - 3.5 stars",
            '3' => "Meh - 3 stars",
            '2.5' => "Kinda bad - 2.5 stars",
            '2' => "Kinda bad - 2 stars",
            '1.5' => "Meh - 1.5 stars",
            '1' => "Sucks big time - 1 star",
            '0.5' => "Sucks big time - 0.5 stars"
        
        }[rating]
    end
end
