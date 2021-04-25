module Api
    module V1
        class ArticlesController < ApplicationController 
            def index
                articles = Article.order('created_at ASC');
                render json: {status: 'SUCCESS', message: 'Loaded articles', data:articles}, status: :ok
            end

            def show
                article = Article.find(params[:id])
                render json: {status: 'SUCCESS', message: 'Loaded article', data:article}, status: :ok
            end

            def create
                article = Article.new(article_params)

                if article.save
                    render json: {status: 'SUCCESS', message: 'Saved article', data:article}, status: :ok
                else
                    render json: {status: 'ERROR', message: 'Article not saved', data:article.errors}, status: :unprocessable_entry
                end
            end

            def destroy
                article = Article.find(params[:id])
                article.destroy
                render json: {status: 'SUCCESS', message: 'Article deleted', data:article}, status: :ok
            end

            def update
                article = Article.find(params[:id])
                if article.update(:title => params[:title], :body=> params[:body])
                    render json: {status: 'SUCCESS', message: 'Article updated', data:article}, status: :ok
                else
                    render json: {status: 'ERROR', message: 'Article not updated', data:article.errors}, status: :unprocessable_entry
                end
            end

            private
            def article_params
                params.permit(:title, :body)
            end
        end
    end    
end