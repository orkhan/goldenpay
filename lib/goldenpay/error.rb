module Goldenpay
  class Error < StandardError; end
  class HTTPResponseError < Error; end
  class GoldenpayResponseError < Error; end
end
