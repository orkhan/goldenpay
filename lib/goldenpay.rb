require "goldenpay/version"
require "goldenpay/configuration"
require "goldenpay/error"
require "goldenpay/request"

module Goldenpay
  extend Configuration

  GoldenpayOptions = Struct.new(
    :merchant_name, :card_type,
    :hash_code, :lang, :amount, :description
  ).freeze
end
