# SmsRu

[![Gem Version](https://badge.fury.io/rb/smsru.png)](http://badge.fury.io/rb/smsru)
[![Code Climate](https://codeclimate.com/github/asiniy/sms_ru/badges/gpa.svg)](https://codeclimate.com/github/asiniy/sms_ru)

This gem is API for sending sms through [sms.ru](http://sms.ru) service. SmsRu allows you to connect to sms.ru api without Net::HTTP syntax sugar. Check [API](http://sms.ru/?panel=api) to list of all available queries.

## Installation

**WARNING** There is outdated ruby gem `sms_ru`, so name of this gem is `**smsru**`

Add this line to your application's Gemfile:

```ruby
gem 'smsru', require: 'sms_ru'
```

And then execute:

    $ bundle

## Usage

Firstly, add `sms_ru.rb` to initializers. Here you can set api_id.

``` ruby
  SmsRu.setup do |config|
    config.api_id = Rails.application.secrets.sms_ru_key
    ### you can setup default settings for every sms.ru API query you want
    config.queries.sms.send.from = 'fasteria.ru'
  end
```

``` ruby
  SmsRu.sms.send(api_id: 'abcdef', to: '79112223344', text: 'Sample message') # => '100\n000-00000'
  SmsRu.my.balance # => '100\n87.79'
  # et.c.
```

You can specify `delivery_method` for SmsRu gateway. For example, if you don't want to send a messages, but don't want to make queries to the API:

``` ruby
  # config/environments/development.rb
  config.sms_ru.delivery_method = :launchy # every query to sms.ru api will open new tab in the browser
```

``` ruby
  # config/environments/test.rb
  config.sms_ru.delivery_method = :webmock # you'll get mocked success answer
```

Default `delivery_method` is `:direct`


## Contributing

1. Fork it ( https://github.com/asiniy/sms_ru/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
