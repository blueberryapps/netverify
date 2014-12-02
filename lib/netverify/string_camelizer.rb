module Netverify
  class StringCamelizer
    def initialize(irregular = {})
      @irregular = irregular
    end

    def camelize(key)
      @irregular[key] || key.to_s.camelize(:lower)
    end
  end
end
