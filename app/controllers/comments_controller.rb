class CommentsController < ApplicationController
    before_action :find_article!
    def create
        @comment = Comment.new(comments_params)
        @comment.user = current_user
        @comment.article = @article
        if @comment.save
            @comment.upvote_by current_user
            respond_to do |format|
                format.html do
                    flash[:success] = t('comment.create.success')
                    redirect_to @article
                end
                format.json { render :json => @comment, success: t('comment.create.success')}
            end
        else
            respond_to do |format|
                format.html do
                    flash[:danger] = t('comment.error')
                    redirect_to @article
                end
                format.json { render :json => @comment, success: t('comment.error')}
            end
        end

    end

    def edit
        @comment = Comment.find(params["id"]);
        if !@comment.nil?
            respond_to do |format|
                format.json { render :json => @comment, success: true }
            end
        end
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