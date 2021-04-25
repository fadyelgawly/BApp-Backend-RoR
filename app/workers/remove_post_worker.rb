class RemovePostWorker
  include Sidekiq::Worker

  def perform(id)
    puts 'Will remove post and all subs'
    #Find post
    post = Post.find(id)
    #Remove all comments on post
    comments = Comment.where(post_id: post.id)
    comments.each do |comment|
      comment.destroy
    end
    #Remove all tags on post
    tags = Tag.where(post_id: post.id)
    tags.each do |tag|
      tag.destroy
    end
    #Remove post itself
    post.destroy
  end
end
