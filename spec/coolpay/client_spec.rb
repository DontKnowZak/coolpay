require 'coolpay/client'

describe Coolpay::Client do
  describe '#login' do
    before do
      @client = Coolpay::Client.new
      stub_request(:any, 'https://coolpay.herokuapp.com/api/login').
        to_return(body: "{\"token\":\"madeuptoken\"}")
    end

    it 'stores the token from the response in @token' do
      expect(@client.login({username: 'test', api_key: '1234'})).to eq @client
      expect(@client.token).to eq 'madeuptoken'
    end
  end

  describe '#add_recipient' do
    before do
      @client = Coolpay::Client.new
      @name = "Test Testerson"
      stub_request(:any, 'https://coolpay.herokuapp.com/api/recipients').
        to_return(body: "{\"recipient\":{\"name\":\"Test Testerson\",\"id\":\"madeupid\"}}")
    end

    it 'stores the token from the response in @token' do
      recipient = @client.add_recipient(@name, token: 'madeuptoken')
      expect(recipient['id']).to eq 'madeupid'
      expect(recipient['name']).to eq @name
    end
  end

  describe '#make_payment' do
    before do
      @client = Coolpay::Client.new
      @id = "recipient_id"
      stub_request(:any, 'https://coolpay.herokuapp.com/api/payments').
        to_return(body: "{\"payment\":{\"status\":\"processing\",\"recipient_id\":\"recipient_id\",\"id\":\"payment_id\",\"currency\":\"GBP\",\"amount\":\"5\"}}")
    end

    it 'stores the token from the response in @token' do
      amount = 5
      payment = @client.make_payment(amount, @id, token: 'madeuptoken')
      expect(payment['id']).to eq 'payment_id'
      expect(payment['amount']).to eq amount.to_s
    end
  end
end
