module SmsRu
  class APIError < StandardError
  end

  class ConnectionError < StandardError
  end

  class DeliveryMethodError < StandardError
  end
end
