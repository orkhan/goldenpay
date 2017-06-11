require 'digest'
require 'net/http'
require 'net/https'
require 'json'

module Goldenpay
  module Request

    def self.get_payment_key(options)

      uri = URI(Goldenpay.payment_key_url)

      # Create client
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true
      http.verify_mode = OpenSSL::SSL::VERIFY_PEER
      dict = {
        "merchantName": options.merchant_name,
        "cardType": options.card_type,
        "hashCode": options.hash_code,
        "lang": options.lang,
        "amount": options.amount,
        "description": options.description
      }
      body = JSON.dump(dict)

      # Create Request
      req = Net::HTTP::Post.new(uri)
      req.add_field "Content-Type", "application/json"
      req.add_field "Accept", "application/json"
      req.body = body

      # Fetch Request
      res = http.request(req)

      parsed_res = JSON.parse(res.body)

      if parsed_res["status"]["code"] == 1
        parsed_res["paymentKey"]
      else
        raise GoldenpayResponseError, "Goldenpay responded with: #{parsed_res["status"]["code"]} | #{parsed_res["status"]["message"]}"
      end
    rescue StandardError => e
      raise HTTPResponseError, "Goldenpay request failed: #{res.code}"
    end

    def self.generate_options(options = {})
      auth_key = Goldenpay.auth_key
      merchant_name = Goldenpay.merchant_name
      card_type = options.fetch :card_type
      lang = options.fetch :lang
      amount = options.fetch :amount
      description = options.fetch :description
      hash_code = Digest::MD5.hexdigest(auth_key + merchant_name + card_type + amount + description)

      GoldenpayOptions.new(merchant_name, card_type, hash_code, lang, amount, description)
    rescue KeyError => e
      e.message
    end
  end
end
