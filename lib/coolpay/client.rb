require 'rest-client'
module Coolpay
  class Client
    def initialize
      @url = 'https://coolpay.herokuapp.com/api/'
    end

    def login(credentials)
      @username, @api_key = credentials.values_at(:username, :api_key)
      RestClient.post @url + 'login', {"username": @username, "apikey": @api_key}
    end
  end
end
