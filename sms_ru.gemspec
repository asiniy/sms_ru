# coding: utf-8
$:.push File.expand_path('../lib', __FILE__)
require 'sms_ru/version'

Gem::Specification.new do |spec|
  spec.name          = 'smsru'
  spec.version       = SmsRu::VERSION
  spec.authors       = ['Alex Antonov']
  spec.email         = ['alex@fasteria.ru']
  spec.summary       = %q{http://sms.ru api integration for ruby}
  spec.homepage      = 'https://github.com/asiniy/sms_ru'
  spec.license       = 'MIT'

  spec.files         = `git ls-files`.split("\n")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = `git ls-files -- spec/*`.split("\n").map{ |f| File.basename(f) }
  spec.require_paths = ['lib']
  spec.required_ruby_version = '>= 2.0.0'

  spec.add_dependency 'launchy', '~> 2.4'
  spec.add_dependency 'webmock', '~> 2.3'

  spec.add_development_dependency 'bundler', '~> 1.7'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3'
end
