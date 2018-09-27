require 'rest-client'
require 'json'
module Coolpay
  class Client
    attr_reader :token

    def initialize
      @url = 'https://coolpay.herokuapp.com/api/'
      @currency = "GBP"
    end

    def login(credentials)
      @username, @api_key = credentials.values_at(:username, :api_key)
      response = RestClient.post @url + 'login', {'username': @username, 'apikey': @api_key}
      parsed_response = JSON.parse response
      @token = parsed_response['token']
      self
    end

    def add_recipient(name, token: @token)
      response = RestClient.post @url + 'recipients', {'recipient': {'name': name}}, {'Authorization': 'Bearer '+ token}
      recipient = JSON.parse(response)['recipient']
    end

    def make_payment(amount, recipient_id, currency: @currency, token: @token)

      response = RestClient.post @url + 'payments', {"payment": {
        "amount": amount,
        "currency": currency,
        "recipient_id": recipient_id
        }}, {'Authorization': 'Bearer '+ token}
      payment = JSON.parse(response)['payment']
    end

    def payment_status(payment_id, token: @token)
      payments = retrieve_payments(token)
      payment = payments.select { |payment| payment['id'] == payment_id } [0]
      payment['status']
    end

    private
    def retrieve_payments(token = @token)
      response = RestClient.get @url + 'payments', {'Authorization': 'Bearer '+ token}
      JSON.parse(response)['payments']
    end
  end
end
