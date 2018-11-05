class ArticlesController < ApplicationController
    def show
        @article = Article.find(params[:id])
    end
    
    def index
        run_schedule
        @articles = Article.limit(10)
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
