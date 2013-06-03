require_relative './lists_constant/version'
require_relative './lists_constant/class_methods'

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
