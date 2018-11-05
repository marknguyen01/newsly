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
        if !Schedule.first.nil?
            dateNow = DateTime.now
            dateBefore = DateTime.parse(Schedule.first.created_at.to_s)
            if (dateNow.to_time - dateBefore.to_time) / 60 > 15
                article_arr = get_articles
                Schedule.create(
                    article_id: article_arr
                )
            end
        else
            article_arr = get_articles
            Schedule.create(
                article_id: article_arr
            )
        end
    end
    def get_articles
        uri = URI.parse('https://newsapi.org/v2/top-headlines?country=us&apiKey=abe8542ae4914be884967744f2c79348')
        http = Net::HTTP.new(uri.host, uri.port)
        http.use_ssl = true
        http.verify_mode = OpenSSL::SSL::VERIFY_NONE # You should use VERIFY_PEER in production
        request = Net::HTTP::Get.new(uri.request_uri)
        res = http.request(request)
        
        article_arr = []
    
        json = JSON.parse(res.body)
        md5 = Digest::MD5.new
        json['articles'].each do |child|
            md5 << child['url']
            article_id = md5.hexdigest
            # check if schedule has not already been run
            if Schedule.first.nil?
                if !Article.exists?(id: article_id)
                    Article.create(
                        id: article_id,
                        url: child['url'],
                        imgURL: child['urlToImage'],
                        author: child['source']['name'],
                        title: child['title'],
                        date: child['publishedAt']
                    )
                    article_arr.push(article_id)
                end
            else
                if !Schedule.first.article_id.include?(article_id)
                    Article.create(
                        id: article_id,
                        url: child['url'],
                        imgURL: child['urlToImage'],
                        author: child['source']['name'],
                        title: child['title'],
                        date: child['publishedAt']
                    )
                    article_arr.push(article_id)
                end
            end    
            md5.reset
        end
        return article_arr
    end
end
