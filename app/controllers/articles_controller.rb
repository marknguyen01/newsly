class ArticlesController < ApplicationController
    def show
    end
    
    def index
        @articles = []
        
        getJSON['articles'].each do |child|
            @articles << {
                "url" => child['url'],
                "imgURL" => child['urlToImage'],
                "author" => child['source']['name'],
                "title" => child['title']
            }
        end
        
        return @articles
        
    end
    
    def createComment
        
    end
end

private def filterParams
end
