require 'net/http'
require 'digest'
class ApplicationController < ActionController::Base
    before_action :new_user_session
    helper_method :current_user_session, :current_user
    private
    def current_user_session
      return @current_user_session if defined?(@current_user_session)
      @current_user_session = UserSession.find
    end

    def current_user
      return @current_user if defined?(@current_user)
      @current_user = current_user_session && current_user_session.user
    end
    
    def new_user_session
        @user_session = UserSession.new
    end
    
    def run_schedule
        if !Schedule.last.nil?
            dateNow = DateTime.now
            dateBefore = DateTime.parse(Schedule.last.created_at.to_s)
            # fetch api if over 15 mins
            if (dateNow.to_time - dateBefore.to_time) / 60 > 15
                create_schedule
            end
        else
            create_schedule
        end
    end
    def create_schedule
        article_arr = get_articles
        Schedule.create(
            article_id: article_arr
        )
    end
    def get_articles
        # fetch api
        uri = URI.parse('https://newsapi.org/v2/top-headlines?country=us&apiKey=abe8542ae4914be884967744f2c79348')
        http = Net::HTTP.new(uri.host, uri.port)
        http.use_ssl = true
        http.verify_mode = OpenSSL::SSL::VERIFY_NONE # You should use VERIFY_PEER in production
        request = Net::HTTP::Get.new(uri.request_uri)
        # fetch result
        res = http.request(request)
                        
        # md5 encoder                
        md5 = Digest::MD5.new
                
        # array of article ids
        article_arr = []
        
        json = JSON.parse(res.body)
        json['articles'].each do |child|
            md5 << child['url']
            child['article_slug'] = md5.hexdigest
            if !Article.limit(96).exists?(slug: child['article_slug'])
                article_arr.push(create_article(child))
            end
            md5.reset
        end
        return article_arr
    end
    
    def create_article(article)
        return Article.create(
            slug: article['article_slug'],
            url: article['url'],
            imgURL: article['urlToImage'],
            author: article['source']['name'],
            title: article['title'],
            date: article['publishedAt']
        ).id
    end
end
