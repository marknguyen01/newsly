require 'net/http'
require 'digest'
class ApplicationController < ActionController::Base
    before_action :new_user_session
    helper_method :current_user_session, :current_user, :convertDate
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
        slug_arr = get_articles
        Schedule.create(
            article_slug: slug_arr
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
        slug_arr = []
        
        json = JSON.parse(res.body)
        json['articles'].each do |child|
            md5 << child['url']
            child['article_slug'] = md5.hexdigest
            # check if schedule has not already been run
            if Schedule.last.nil?
                if !Article.exists?(slug: child['article_slug'])
                    slug_arr.push(create_article(child))
                end
            else
                if !Schedule.limit(96).pluck(:article_slug).flatten.include?(child['article_slug'])
                    slug_arr.push(create_article(child))
                end
            end    
            md5.reset
        end
        return slug_arr
    end
    
    def create_article(article)
        return Article.create(
            slug: article['article_slug'],
            url: article['url'],
            imgURL: article['urlToImage'],
            author: article['source']['name'],
            title: article['title'],
            date: article['publishedAt']
        ).slug
    end
    
    def convertDate(date)
        dateNow = DateTime.now
        dateBefore = DateTime.parse(date)
        
        secDiff = dateNow.to_time - dateBefore.to_time
        minDiff = (secDiff / 60).floor
        hourDiff = (minDiff / 60).floor
        dayDiff = (hourDiff / 24).floor
        # less than a minute
        if secDiff >= 0 and secDiff <= 60
            return secDiff.to_s;
        # less than an hour
        elsif minDiff > 0 and minDiff <= 60
            return minDiff.to_s + " minutes ago"
        elsif hourDiff > 0 and hourDiff <= 24
            return hourDiff.to_s + " hours ago"
        elsif dayDiff > 0 and dayDiff <= 30
            return dayDiff.to_s + " days ago"
        end
    end
end
