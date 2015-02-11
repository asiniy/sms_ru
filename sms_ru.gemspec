# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'sms_ru/version'

Gem::Specification.new do |spec|
  spec.name          = 'smsru'
  spec.version       = SmsRu::VERSION
  spec.authors       = ['Alex Antonov']
  spec.email         = ['alex@fasteria.ru']
  spec.summary       = %q{http://sms.ru api integration for ruby}
  spec.homepage      = 'https://github.com/asiniy/sms_ru'
  spec.license       = 'MIT'

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_dependency 'activesupport', '>= 4.0.0'

  spec.add_development_dependency 'bundler', '~> 1.7'
  spec.add_development_dependency 'rake', '~> 10.0'
end
