module Api
    module V1
        class PostsController < ApplicationController 

            def index
                posts = Post.order('created_at ASC');
                render json: {status: 'SUCCESS', message: 'Loaded Posts', data:posts}, status: :ok
            end

            def show
                @post = Post.find(params[:id])
                render json: @post #{status: 'SUCCESS', message: 'Loaded Post', data:post}, status: :ok
            end

            def create
                post = Post.new(post_params)
                post.user_id = @user.id
                
                if post.save
                    #RemovePostJob.perform_later(post.id)
                    RemovePostWorker.perform_in(24.seconds, post.id)
                    render json: {status: 'SUCCESS', message: 'Post Saved', data:post}, status: :ok
                else
                    render json: {status: 'ERROR', message: 'Post not saved', data:post.errors}, status: :unprocessable_entity
                end
            end

            def destroy
                @post = Post.find(params[:id])
                if @post.user_id == @user.id
                    @comments = Comment.where(post_id: @post.id)
                    @comments.each do |comment|
                        comment.destroy
                    end
                    @post.destroy
                    render json: {status: 'SUCCESS', message: 'Post deleted', data:@post}, status: :ok                   
                else
                    render json: {status: 'ERROR', message: 'Only post\'s author can delete', data:post}, status: :forbidden                                       
                end
            end

            def update
                post = Post.find(params[:id])
                if post.user_id == @user.id
                    if Post.update(:title => params[:title], :body=> params[:body])
                        render json: {status: 'SUCCESS', message: 'Post updated', data:post}, status: :ok
                    else
                        render json: {status: 'ERROR', message: 'Post not updated', data:post.errors}, status: :unprocessable_entity
                    end
                else
                    render json: {status: 'ERROR', message: 'Only post\'s author can edit', data:post}, status: :forbidden  
                end
            end

            private
            def post_params
                params.require(:post).permit(:title, :body)
            end

            
        end
    end    
end
