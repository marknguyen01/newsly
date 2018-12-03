class ArticlesController < ApplicationController
    helper_method :isCommentOwner?
    def show
        if !Article.exists?(slug: params[:slug])
            redirect_to root_path
        else
            @article = Article.find_by(slug: params[:slug])
            @article.increment!(:views_count)
        end
    end
    
    def index
        run_schedule
        case params[:sort]
        when "controversial"
            @articles = Article.order("views_count DESC")
        when "comments"
            @articles = Article.order("comments_count DESC")
        when "likes"
            @articles = Article.order("votes_count DESC")
        else
            @articles = Article.order("created_at DESC")
        end    
        @articles = @articles.page(params[:page]).per(10)
    end
    def upvote 
        if current_user.nil?
            flash[:danger] = t('vote.not_authorized')
        else
            @article = Article.find_by(slug: params[:article_slug])
            @article.upvote_by current_user
            @article.increment!("votes_count")
        end
        redirect_back(fallback_location: root_path)
    end  
    def downvote 
        if current_user.nil?
            flash[:danger] = t('vote.not_authorized')
        else
            @article = Article.find_by(slug: params[:article_slug])
            @article.downvote_by current_user
            @article.decrement!("votes_count")
        end
        redirect_back(fallback_location: root_path)
    end
end
