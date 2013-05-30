require_relative './lists_constant/version'
require 'active_support/inflector'
require 'active_support/concern'

module ListsConstant
  extend ActiveSupport::Concern

  def self.namespace
    "#{@namespace}." if @namespace
  end

  def self.namespace=(namespace)
    @namespace = namespace
  end

  module ClassMethods

    def lists_constant(*values)
      options = values.extract_options!

      field = options[:as].to_s
      raise ArgumentError.new('A constant name must be provided using the :as option') if field.empty?

      const_set(field.upcase, values.freeze)
      add_constant_list_getters(field)
      add_localized_lookups(field)
      add_query_methods(field, values)
    end


    private

    def add_constant_list_getters(field)
      define_singleton_method field do
        const_get(field.upcase).inject({}) do |hash, value|
          hash[value] = I18n.t(value, scope: "#{ListsConstant.namespace}#{name.underscore}.#{field}")
          hash
        end
      end

      define_singleton_method "#{field.singularize}_options" do
        send(field).invert
      end
    end

    def add_localized_lookups(field)
      define_method "localized_#{field.singularize}" do
        value = send(field.singularize)
        return nil if value.nil? || value.empty?

        I18n.t(value, scope: "#{ListsConstant.namespace}#{self.class.name.underscore}.#{field}")
      end
    end

    def add_query_methods(field, values)
      values.each do |value|
        define_method "#{field.singularize}_#{value}?" do
          send(field.singularize).to_s == value.to_s
        end
      end
    end
  end
end
