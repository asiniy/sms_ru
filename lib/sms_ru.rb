require 'active_support/core_ext/module/attribute_accessors'
require 'active_support/core_ext/hash/deep_merge'
require 'net/http'

require 'sms_ru/version'
require 'sms_ru/config'

module SmsRu
  # Setup configuration
  mattr_accessor :api_id

  mattr_reader :methods
  @@methods = SmsRu::Config

  def self.setup
    yield self
  end

  # Sms.ru api settings

  # all possible queries is exactly 2 level deep
  @@stack_method ||= nil

  # we need to undefine method send because of we use it at the api
  class <<self
    undef_method :send
  end

  def self.method_missing(m, options = {})
    if @@stack_method
      query_options = methods.configuration.to_h[@@stack_method].to_h[m].to_h
      query_options.deep_merge!(api_id: api_id)
      query_options.deep_merge! options

      uri = URI.parse("http://sms.ru/#{@@stack_method.to_s}/#{m.to_s}")
      @@stack_method = nil

      response = Net::HTTP.post_form(uri, query_options)

      raise 'you have troubles with internet connection or API query is missing' unless response.header == '200'
      raise "something going wrong: #{query_options}, #{response.body}" unless response.body.match(/^100/)
      response.body
    else
      @@stack_method = m
      return self
    end
  end
end
