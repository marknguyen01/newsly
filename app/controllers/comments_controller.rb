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
    private
    def comments_params
        params.require(:comment).permit(:text)
    end
    def find_article!
        @article = Article.find_by(slug: params[:article_slug])
    end
end