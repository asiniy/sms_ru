# SmsRu

[![Gem Version](https://badge.fury.io/rb/smsru.png)](http://badge.fury.io/rb/smsru)

This gem is API for sending sms through [sms.ru](http://sms.ru) service. SmsRu allows you to connect to sms.ru api without Net::HTTP syntax sugar. Check [API](http://sms.ru/?panel=api) to list of all available queries.

## Installation

**WARNING** There is obsolete ruby gem `sms_ru`, so name of this gem is '**smsru**'

Add this line to your application's Gemfile:

```ruby
gem 'smsru'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install smsru

## Usage

Firstly, add `sms_ru.rb` to initializers. Here you can set api_id.

``` ruby
  SmsRu.setup do |config|
    config.api_id = Rails.application.secrets.sms_ru_key
    ### you can setup default settings for every sms.ru API method you want
    config.methods.sms.send.from = 'fasteria.ru'
  end
```

``` ruby
  SmsRu.sms.send(api_id: 'abcdef', to: '79112223344', text: 'Sample message') # => '100\n000-00000'
  SmsRu.my.balance # => '100\n87.79'
  # et.c.
```

## Contributing

1. Fork it ( https://github.com/asiniy/sms_ru/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
