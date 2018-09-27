require 'rest-client'
require 'json'
module Coolpay
  class Client
    attr_reader :token

    def initialize
      @url = 'https://coolpay.herokuapp.com/api/'
    end

    def login(credentials)
      @username, @api_key = credentials.values_at(:username, :api_key)
      response = RestClient.post @url + 'login', {'username': @username, 'apikey': @api_key}
      parsed_response = JSON.parse response
      @token = parsed_response['token']
      self
    end

    def add_recipient(name, token = @token)
      response = RestClient.post @url + 'recipients', {'recipient': {'name': name}}, {'Authorization': 'Bearer '+ token}
      recipient = JSON.parse(response)['recipient']
    end
  end
end
