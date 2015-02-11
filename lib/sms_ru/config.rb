module SmsRu
  module Config
    mattr_accessor :configuration
    @@configuration = {}

    # Scope is used for dynamic params assignment
    @@current_scope = []

    def self.current_scope_to_config(args)
      @@current_scope.reverse.inject(args) { |a, n| { n => a } }
    end

    def self.method_missing(m, *args)
      @@current_scope.push m
      if m.match(/=/)
        @@configuration.deep_merge! current_scope_to_config(*args)
        @@current_scope = []
      else
        return self
      end
    end
  end
end
