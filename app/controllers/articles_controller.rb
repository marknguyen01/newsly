class ArticlesController < ApplicationController
    def show
    end
    
    def index
        @articles = getJSON
    end
    
    def createComment
        
    end
end

private def filterParams
end
