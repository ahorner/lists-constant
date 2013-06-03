module ListsConstant

  module ClassMethods

    def lists_constant *values
      options = values.extract_options!
      field = options[:as].to_s
      raise ArgumentError.new('A constant name must be provided using the :as option') if field.empty?

      const_set field.upcase, values.freeze
      extend ListsConstant::Lookups::Class.new(field, values)
      include ListsConstant::Lookups::Instance.new(field, values)
    end
  end
end
