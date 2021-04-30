class UserSerializer < ActiveModel::Serializer
  attributes :username

  has_many :posts
  has_many :comments
  has_many :tags 
end
