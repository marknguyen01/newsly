class CommentsController < ApplicationController
    before_action :find_article!
    def create
        @comment = Comment.new(comments_params)
        @comment.user = current_user
        @comment.article = @article
        if @comment.save
            redirect_back(fallback_location: root_path)
        end
    end
    def upvote 
      @comment = Comment.find(params[:comment_id])
      @comment.upvote_by current_user
      redirect_back(fallback_location: root_path)
    end  
    def downvote 
      @comment = Comment.find(params[:comment_id])
      @comment.downvote_by current_user
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