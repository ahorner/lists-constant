module ListsConstant

  class Lookup

    def initialize base, field
      @base = base
      @field = field
    end

    def lookup value
      I18n.t(value, scope: "#{ListsConstant.namespace}#{@base.name.underscore}.#{@field}")
    end
  end
end
