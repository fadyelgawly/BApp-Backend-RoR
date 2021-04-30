module Api
    module V1
        class CommentsController < ApplicationController 
            before_action :set_post

            def index
                @comments = Comment.order('created_at ASC');
                render json: @comments 
            end

            def show
                comment = Comment.find(params[:id])
                render json: {status: 'SUCCESS', message: 'Loaded comment', data:comment}, status: :ok
            end

            def create
                comment = Comment.new(comment_params)
                comment.user_id = @user.id
                if comment.save
                    render json: {status: 'SUCCESS', message: 'Saved comment', data:comment}, status: :ok
                else
                    render json: {status: 'ERROR', message: 'Comment not saved', data:comment.errors}, status: :unprocessable_entity
                end
            end

            def destroy
                comment = Comment.find(params[:id])
                comment.destroy
                render json: {status: 'SUCCESS', message: 'Comment deleted', data:comment}, status: :ok
            end

            def update
                comment = Comment.find(params[:id])
                if comment.user_id == @user.id     
                    if comment.update(:body=> params[:body])
                        render json: {status: 'SUCCESS', message: 'Comment updated', data:comment}, status: :ok
                    else
                        render json: {status: 'ERROR', message: 'Comment not updated', data:comment.errors}, status: :unprocessable_entry
                    end
                else
                    render json: {status: 'ERROR', message: 'Only comments author can update comment', data:comment.errors}, status: :forbidden
                end
            end

            private
            def comment_params
                params.permit(:body, :post_id, :user_id)
            end
            def set_post
                @post = Post.find(params[:post_id])
            end
        end
    end    
end