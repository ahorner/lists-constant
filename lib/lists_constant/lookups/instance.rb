module ListsConstant

  module Lookups

    class Instance < Module

      def initialize field, values
        @field = field
        @values = values

        super()
      end

      def included base
        add_localized_lookups base
        add_query_methods base
      end


      private

      def add_localized_lookups base
        field = @field

        base.send :define_method, "localized_#{field.singularize}" do
          value = send(field.singularize)
          return nil if value.nil? || value.empty?

          ListsConstant::Lookup.new(self.class, field).lookup(value)
        end
      end

      def add_query_methods base
        field = @field

        @values.each do |value|
          base.send :define_method, "#{field.singularize}_#{value}?" do
            send(field.singularize).to_s == value.to_s
          end
        end
      end
    end
  end
end
