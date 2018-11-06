class ArticlesController < ApplicationController
    def show
        @article = Article.find_by(slug: params[:slug])
    end
    
    def index
        run_schedule
        @articles = Article.order("created_at DESC").page(params[:page]).per(20)
    end
    def createComment
        
    end
    def upvote 
      @article = Article.find_by(slug: params[:article_slug])
      @article.upvote_by current_user
      redirect_back(fallback_location: root_path)
    end  
    def downvote 
      @article = Article.find_by(slug: params[:article_slug])
      @article.downvote_by current_user
      redirect_back(fallback_location: root_path)
    end  
end
