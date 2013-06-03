require 'active_support/inflector'

require 'lists_constant/version'
require 'lists_constant/lookups'
require 'lists_constant/class_methods'

module ListsConstant

  def self.namespace
    "#{@namespace}." if @namespace
  end

  def self.namespace= namespace
    @namespace = namespace
  end

  def self.included base
    base.extend ClassMethods
  end
end
