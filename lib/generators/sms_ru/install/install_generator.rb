module SmsRu
  module Generators
    class InstallGenerator < Rails::Generators::Base
       source_root File.expand_path("../templates", __FILE__)

       def copy_initializer
         template 'sms_ru.rb', 'config/initializers/sms_ru.rb'
       end
    end
  end
end
