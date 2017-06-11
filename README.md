# Goldenpay

Unoffical Ruby interface to GoldenPay online payment processing system.

WARNING: This code is in no way affiliated with, authorised, maintained,
sponsored or endorsed by GoldenPay LLC or any of its affiliates or subsidiaries.
This is an independent and unofficial. Use at your own risk.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'goldenpay'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install goldenpay

## Configuration

```ruby
Goldenpay.configure do |config|
  config.merchant_name = "your_merchant_name"
  config.auth_key = "your_auth_key"
end
```

## Usage

```ruby
# Payment authorization
options = {
  card_type: "v", # v for visa, or m for mastercard
  lang: "en",
  amount: "100",
  description: "testing payment"
}

request_options = Goldenpay::Request.generate_options(options)

begin
  payment_key = Goldenpay::Request.get_payment_key request_options
  return redirect_to Goldenpay.payment_page_url + payment_key
rescue Goldenpay::Error => e
  puts e.message
end

# Check transaction results
begin
  results = Goldenpay::Request.get_results("payment_key")
rescue Goldenpay::Error => e
  puts e.message
end
```

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

## Copyright

Copyright (c) 1918-∞ Orkhan Maharramli
