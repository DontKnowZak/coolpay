require_relative 'coolpay/client'
require 'forwardable'
module Coolpay
  class << self
    extend Forwardable

    def_delegators :client, :login, :add_recipient, :make_payment, :payment_status

    def client
      @client ||= Coolpay::Client.new
    end
  end
end
