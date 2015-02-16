require 'erb'
require 'rack'

module SmsRu
  class Message
    def initialize(request, dir_location)
      @request = parse_request(request)
      @dir_location = dir_location
      FileUtils.mkdir_p @dir_location
      @file_location = "#{Time.now.to_i}_#{Digest::SHA1.hexdigest(@request.to_s + rand(1_000_000).to_s)[0..6]}"
    end

    def render
      File.open(filepath, 'w') do |f|
        f.write ERB.new(template).result(binding)
      end
      
      Launchy.open("file:///#{filepath}")
    end

  private

    def parse_request(request)
      {
        method: request.method.to_s,
        uri: request.uri.to_s,
      }.merge Rack::Utils.parse_nested_query(request.body)
    end

    def template
      File.read(File.expand_path('../message.html.erb', __FILE__))
    end

    def filepath
      File.join(@dir_location, @file_location + '.html')
    end
  end
end
