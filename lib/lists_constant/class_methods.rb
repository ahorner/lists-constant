require 'lists_constant/constant'
require 'lists_constant/lookup'

module ListsConstant

  module ClassMethods

    def lists_constant *values
      options = values.extract_options!
      field = options[:as].to_s
      raise ArgumentError.new('A constant name must be provided using the :as option') if field.empty?

      ListsConstant::Constant.new(self, field, values)
      ListsConstant::Lookup.new(self, field, values)
    end
  end
end
