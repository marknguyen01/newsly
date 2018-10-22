require 'net/http'
class ApplicationController < ActionController::Base
    @apiKey = abe8542ae4914be884967744f2c79348
    def getJSON
        url = URI.parse('https://newsapi.org/v2/top-headlines?country=us&apiKey=#{@apiKey}')
        req = Net::HTTP::Get.new(url.to_s)
        res = Net::HTTP.start(url.host, url.port) {|http|
          http.request(req)
        }
        return JSON.parse(res.body)
    end
end
