module SmsRu
  class Railtie < Rails::Railtie
    config.sms_ru = ActiveSupport::OrderedOptions.new

    # change this in config/environments/*
    config.sms_ru.delivery_method = :direct
    config.sms_ru.location = 'tmp/sms_ru'

    initializer 'sms_ru.setup_delivery_method' do |app|
      case app.config.sms_ru.delivery_method
      when :webmock
        require 'webmock'
        WebMock.stub_request(:any, /http:\/\/sms.ru/).
          to_return(status: 200, body: "100\n21115\nbalance=162.11")
      when :launchy
        require 'webmock'
        require 'launchy'
        require 'sms_ru/message'
        WebMock.stub_request(:any, /http:\/\/sms.ru/)
          .to_return(status: 200, body: "100\n21115\nbalance=162.11")
        WebMock.after_request do |request, response|
          if request.uri.to_s.match /http:\/\/sms.ru/
            SmsRu::Message.new(request, Rails.root.join(app.config.sms_ru.location)).render
          end
        end
      when :direct then nil
      else raise 'undefined sms_ru delivery_method'
      end
    end
  end
end
