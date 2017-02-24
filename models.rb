ActiveRecord::Base.establish_connection("sqlite3:db/development.db")

class User < ActiveRecord::Base
    has_secure_password
    has_many :reviews
end

class Review < ActiveRecord::Base
    belongs_to :user
    has_many  :review_tags
    has_many :tags, through: :review_tags
end

class ReviewTag < ActiveRecord::Base
    belongs_to :review
    belongs_to :tag
end

class Tag < ActiveRecord::Base
    has_many :review_tags
    has_many :reviews, through: :review_tags
end