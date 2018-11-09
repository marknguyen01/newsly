class ArticlesController < ApplicationController
    helper_method :convertDate, :isCommentOwner?
    def show
        @article = Article.find_by(slug: params[:slug])
    end
    
    def index
        run_schedule
        @articles = Article.order("created_at DESC").page(params[:page]).per(20)
    end
    def isCommentOwner?(comment)
        current_user.id == comment.user.id
    end
    def convertDate(date)
        dateNow = DateTime.now
        dateBefore = DateTime.parse(date)
        
        secDiff = dateNow.to_time - dateBefore.to_time
        minDiff = (secDiff / 60).floor
        hourDiff = (minDiff / 60).floor
        dayDiff = (hourDiff / 24).floor
        # less than a minute
        if secDiff >= 0 and secDiff <= 60
            return secDiff.to_s;
        # less than an hour
        elsif minDiff > 0 and minDiff <= 60
            return minDiff.to_s + " minutes ago"
        elsif hourDiff > 0 and hourDiff <= 24
            return hourDiff.to_s + " hours ago"
        elsif dayDiff > 0 and dayDiff <= 30
            return dayDiff.to_s + " days ago"
        end
    end
    def createComment
        
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
