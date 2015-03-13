require 'active_support/core_ext/module/attribute_accessors'
require 'active_support/core_ext/hash/deep_merge'
require 'net/http'

require 'sms_ru/version'
require 'sms_ru/config'
require 'sms_ru/error'
require 'sms_ru/railtie' if defined?(Rails)

module SmsRu
  # Setup configuration
  mattr_accessor :api_id

  mattr_reader :queries
  @@queries = SmsRu::Config

  def self.setup
    yield self
  end

  # Sms.ru api settings

  # all possible queries is exactly 2 level deep
  @@stack_method ||= nil

  # we need to undefine method send because of we use it in the api
  class <<self
    undef_method :send
  end

  def self.method_missing(m, options = {})
    if @@stack_method
      query_options = queries.configuration.to_h[@@stack_method].to_h[m].to_h
      query_options.deep_merge!(api_id: api_id)
      query_options.deep_merge! options

      uri = URI.parse("http://sms.ru/#{@@stack_method.to_s}/#{m.to_s}")
      @@stack_method = nil

      response = Net::HTTP.post_form(uri, query_options)

      raise SmsRu::ConnectionError, 'you have troubles with internet connection or API query is missing' unless response.kind_of? Net::HTTPSuccess
      raise SmsRu::APIError, "something going wrong: query_options => #{query_options}, uri => #{uri}, response => #{response.body}" unless response.body.match(/^100/)
      response.body.split("\n")
    else
      @@stack_method = m
      return self
    end
  end
end
