class UpvotesController < ApplicationController
  def create
    @upvote = Upvote.new(secure_params)
    @upvote.post = Post.find(params[:article_id])
    if @upvote.save
      respond_to do |format|
        format.html { redirect_to @upvote.post }
        format.js # we'll use this later for AJAX!
      end
    end
  end
  private
    def secure_params
      params.require(:upvote).permit(:user)
    end
end