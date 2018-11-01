class ArticlesController < ApplicationController
    def show
        @article = Article.find(params[:id])
        @comments = Comment.where("article_id='#{params[:id]}'")
    end
    
    def index
        generateArticles
        @articles = Article.all
    end
    def createComment
        
    end
end
