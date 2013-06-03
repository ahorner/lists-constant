require 'active_support/inflector'

module ListsConstant

  class Constant

    def initialize base, field, values
      @base = base
      @base.const_set field.upcase, values.freeze

      add_localized_hash_method(field)
      add_inverted_hash_method(field)
    end


    private

    def add_localized_hash_method field
      @base.define_singleton_method field do
        const_get(field.upcase).inject({}) do |hash, value|
          hash[value] = I18n.t(value, scope: "#{ListsConstant.namespace}#{name.underscore}.#{field}")
          hash
        end
      end
    end

    def add_inverted_hash_method field
      @base.define_singleton_method "#{field.singularize}_options" do
        send(field).invert
      end
    end
  end
end
