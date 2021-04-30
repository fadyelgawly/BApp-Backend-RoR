class PostSerializer < ActiveModel::Serializer
  attributes :id, :title, :body

  belongs_to :user
  has_many :comments
  has_many :tags

end
