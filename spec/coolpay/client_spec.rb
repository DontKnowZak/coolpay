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

    it 'returns the added recipient' do
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

    it 'returns the new payment' do
      amount = 5
      payment = @client.make_payment(amount, @id, token: 'madeuptoken')
      expect(payment['id']).to eq 'payment_id'
      expect(payment['amount']).to eq amount.to_s
    end
  end

  describe '#payment_status' do
    before do
      @client = Coolpay::Client.new
      @payments = [
        {
          "status"=>"failed",
          "recipient_id"=>"cd5955fc-3bf8-4224-9252-bd64cfcdb0a2",
          "id"=>"2ef4bc60-6689-4575-bbe8-e895ad5d7f03",
          "currency"=>"GBP",
          "amount"=>"10.5"
        },
        {
          "status"=>"paid",
          "recipient_id"=>"b3f95daf-a59c-4f14-bb70-8e6a2eb0c550",
          "id"=>"88a31e37-1032-4601-a8c5-0f23a91d8ada",
          "currency"=>"GBP",
          "amount"=>"10.5"
        }
      ]
      allow(@client).to receive(:retrieve_payments) { @payments}
    end

    it 'returns the status of the given payment' do
      expect(@client.payment_status("88a31e37-1032-4601-a8c5-0f23a91d8ada")).to eq 'paid'
      expect(@client.payment_status("2ef4bc60-6689-4575-bbe8-e895ad5d7f03")).to eq 'failed'
    end
  end
end
