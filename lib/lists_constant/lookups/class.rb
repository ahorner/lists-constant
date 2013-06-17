module ListsConstant

  module Lookups

    class Class < Module

      def initialize field, values
        @field = field
        @values = values

        super()
      end

      def extended base
        add_lookup_query_method base
        add_localized_hash_method base
        add_localization_method base
        add_inverted_hash_method base
      end


      private

      def add_lookup_query_method base
        field = @field

        base.define_singleton_method "includes_#{field.singularize}?" do |value|
          const_get(field.upcase).any? { |item| item.to_s == value.to_s }
        end
      end

      def add_localized_hash_method base
        field = @field

        base.define_singleton_method field do
          const_get(field.upcase).inject({}) do |hash, value|
            hash[value.to_sym] = ListsConstant::Lookup.new(self, field).lookup(value)
            hash
          end
        end
      end

      def add_localization_method base
        field = @field

        base.define_singleton_method "localized_#{field.singularize}" do |value|
          send(field)[value.to_sym] unless value.nil?
        end
      end

      def add_inverted_hash_method base
        field = @field

        base.define_singleton_method "#{field.singularize}_options" do
          send(field).invert
        end
      end
    end
  end
end
