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
      @token = 'madeuptoken'
      stub_request(:any, 'https://coolpay.herokuapp.com/api/recipients').
        to_return(body: "{\"recipient\":{\"name\":\"Test Testerson\",\"id\":\"madeuptoken\"}}")
    end

    it 'stores the token from the response in @token' do
      recipient = @client.add_recipient(@name, 'madeuptoken')
      expect(recipient['recipient']['id']).to eq 'madeuptoken'
      expect(recipient['recipient']['name']).to eq @name
    end
  end
end
