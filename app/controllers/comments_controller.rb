class CommentsController < ApplicationController
    before_action :find_article!
    def create
        @comment = Comment.new(comments_params)
        @comment.user = current_user
        @comment.article = @article
        if !@comment.save
            flash[:danger] = @comment.errors.full_messages.to_sentence
        end
        redirect_back(fallback_location: root_path)
    end
    
    def update
    end
    
    def destroy
        @comment = Comment.find(params["id"]);
        if @comment.destroy
            flash[:success] = t('comment.destroy.success')
        else
            flash[:danger] = t('comment.error')
        end
        redirect_back(fallback_location: root_path)
    end

    def upvote
        flash.discard
        if current_user.nil?
            flash[:danger] = t('comment.vote.not_authorized')
        else
          @comment = Comment.find(params[:comment_id])
          @comment.upvote_by current_user
        end
        redirect_back(fallback_location: root_path)
    end  
    def downvote 
        flash.discard
        if current_user.nil?
            flash[:danger] = t('comment.vote.not_authorized')
        else
          @comment = Comment.find(params[:comment_id])
          @comment.downvote current_user
        end
        redirect_back(fallback_location: root_path)
    end  
    private
    def comments_params
        params.require(:comment).permit(:text)
    end
    def find_article!
        @article = Article.find_by(slug: params[:article_slug])
    end
end