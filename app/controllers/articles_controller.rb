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
    def upvote 
      @article = Article.find(params[:article_id])
      @article.upvote_by current_user
      redirect_back(fallback_location: root_path)
    end  
    def downvote 
      @article = Article.find(params[:article_id])
      @article.downvote_by current_user
      redirect_back(fallback_location: root_path)
    end  
end
