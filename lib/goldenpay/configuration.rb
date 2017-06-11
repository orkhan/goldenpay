module Goldenpay
  module Configuration

    VALID_OPTIONS_KEYS = [
      :merchant_name, :auth_key, :callback_success_url, :callback_fail_url,
      :redirect_route, :delete_unused, :payment_key_url, :payment_result_url, :payment_page_url
    ].freeze

    attr_accessor *VALID_OPTIONS_KEYS

    def self.extended(base)
      base.defaults
    end

    def configure
      yield self
    end

    def defaults
      self.merchant_name = "test"
      self.auth_key = nil
      self.callback_success_url = "http://localhost:3000/payment/success"
      self.callback_fail_url = "http://localhost:3000/payment/error"
      self.redirect_route = nil
      self.delete_unused = nil
      self.payment_key_url = "https://rest.goldenpay.az/web/service/merchant/getPaymentKey"
      self.payment_result_url = "https://rest.goldenpay.az/web/service/merchant/getPaymentResult"
      self.payment_page_url = "https://rest.goldenpay.az/web/paypage?payment_key="
    end
  end
end
