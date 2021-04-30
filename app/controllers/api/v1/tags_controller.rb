module Api
    module V1
        class TagsController < ApplicationController 
            before_action :set_post

            def index
                @tags = Tag.order('created_at ASC');
                render json: @tags 
            end

            def show
                tag = Tag.find(params[:id])
                render json: {status: 'SUCCESS', message: 'Loaded tag', data:tag}, status: :ok
            end

            def create
                tag = Tag.new(tag_params)
                tag.user_id = @user.id
                if tag.save
                    render json: {status: 'SUCCESS', message: 'Saved tag', data:tag}, status: :ok
                else
                    render json: {status: 'ERROR', message: 'Tag not saved', data:tag.errors}, status: :unprocessable_entity
                end
            end

            def destroy
                tag = Tag.find(params[:id])
                tag.destroy
                render json: {status: 'SUCCESS', message: 'Tag deleted', data:tag}, status: :ok
            end

            def update
                tag = Tag.find(params[:id])
                if tag.update(:body=> params[:body])
                    render json: {status: 'SUCCESS', message: 'Tag updated', data:tag}, status: :ok
                else
                    render json: {status: 'ERROR', message: 'Tag not updated', data:tag.errors}, status: :unprocessable_entry
                end
            end

            private
            def tag_params
                params.permit(:body, :post_id, :user_id)
            end
            def set_post
                @post = Post.find(params[:post_id])
            end
        end
    end    
end