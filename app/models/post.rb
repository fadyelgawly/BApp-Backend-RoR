class Post < ApplicationRecord
    validates :title, presence: true
    validates :body, presence: true

    belongs_to :user
    
    has_many :tags
    has_many :comments
end
