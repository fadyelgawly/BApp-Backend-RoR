class TagSerializer < ActiveModel::Serializer
  attributes :id, :body

  belongs_to :user
  belongs_to :post_id
end
