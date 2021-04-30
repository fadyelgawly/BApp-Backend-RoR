class User < ApplicationRecord
    validates :username, :email, uniqueness: true
    has_secure_password
    has_many :posts
    has_many :tags , through: :posts
    has_many :comments, through: :posts
end