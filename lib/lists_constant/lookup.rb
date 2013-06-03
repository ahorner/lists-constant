require 'active_support/inflector'

module ListsConstant

  class Lookup

    def initialize base, field, values
      @base = base
      @values = values

      add_localized_lookups field
      add_query_methods field
    end


    private

    def add_localized_lookups field
      @base.send :define_method, "localized_#{field.singularize}" do
        value = send(field.singularize)
        return nil if value.nil? || value.empty?

        I18n.t(value, scope: "#{ListsConstant.namespace}#{self.class.name.underscore}.#{field}")
      end
    end

    def add_query_methods field
      @values.each do |value|
        @base.send :define_method, "#{field.singularize}_#{value}?" do
          send(field.singularize).to_s == value.to_s
        end
      end
    end
  end
end
