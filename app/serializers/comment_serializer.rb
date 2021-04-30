class CommentSerializer < ActiveModel::Serializer
  attributes :id, :body, :post_id

  belongs_to :user
end
