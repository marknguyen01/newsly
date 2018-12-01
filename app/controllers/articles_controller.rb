class ArticlesController < ApplicationController
    helper_method :isCommentOwner?
    def show
        @article = Article.find_by(slug: params[:slug])
    end
    
    def index
        run_schedule
        @articles = Article.order("created_at DESC").page(params[:page]).per(20)
    end
    def upvote 
        if current_user.nil?
            flash[:danger] = t('vote.not_authorized')
        else
            @article = Article.find_by(slug: params[:article_slug])
            @article.upvote_by current_user
        end
        redirect_back(fallback_location: root_path)
    end  
    def downvote 
        if current_user.nil?
            flash[:danger] = t('vote.not_authorized')
        else
            @article = Article.find_by(slug: params[:article_slug])
            @article.downvote_by current_user
        end
        redirect_back(fallback_location: root_path)
    end
end
