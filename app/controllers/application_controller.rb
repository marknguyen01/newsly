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
    def generateArticles
        uri = URI.parse('https://newsapi.org/v2/top-headlines?country=us&apiKey=abe8542ae4914be884967744f2c79348')
        http = Net::HTTP.new(uri.host, uri.port)
        http.use_ssl = true
        http.verify_mode = OpenSSL::SSL::VERIFY_NONE # You should use VERIFY_PEER in production
        request = Net::HTTP::Get.new(uri.request_uri)
        res = http.request(request)
    
        json = JSON.parse(res.body)
        md5 = Digest::MD5.new
        json['articles'].each do |child|
            md5 << child['url']
            if !Article.exists?(id: md5.hexdigest)
                Article.create(
                    id: md5.hexdigest,
                    url: child['url'],
                    imgURL: child['urlToImage'],
                    author: child['source']['name'],
                    title: child['title'],
                    date: child['publishedAt']
                )
            end
            md5.reset
        end
    end
end
