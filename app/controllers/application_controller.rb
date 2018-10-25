require 'net/http'
require 'digest'
class ApplicationController < ActionController::Base
    def getJSON
        uri = URI.parse('https://newsapi.org/v2/top-headlines?country=us&apiKey=abe8542ae4914be884967744f2c79348')
        http = Net::HTTP.new(uri.host, uri.port)
        http.use_ssl = true
        http.verify_mode = OpenSSL::SSL::VERIFY_NONE # You should use VERIFY_PEER in production
        request = Net::HTTP::Get.new(uri.request_uri)
        res = http.request(request)
    
        articles = []
        md5 = Digest::MD5.new
        json = JSON.parse(res.body)
        json['articles'].each do |child|
            md5 << child['url']
            articles << {
                "id" => md5.hexdigest,
                "url" => child['url'],
                "imgURL" => child['urlToImage'],
                "author" => child['source']['name'],
                "title" => child['title']
            }
            md5.reset
        end
        return articles
    end
end
