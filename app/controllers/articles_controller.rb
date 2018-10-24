class ArticlesController < ApplicationController
    def show
        @comments = Comment.find(params[:id])
        @likes = Like.find(params[:id])
        @data = getJson
    end
end
