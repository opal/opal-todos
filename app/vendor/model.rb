require 'vendor/eventable'

class Model
  include Eventable

  def self.attribute(name)
    define_method(name) { @attributes[name] }
    define_method("#{name}=") { |val| @attributes[name] = val }
  end
  
  def initialize(attributes={})
    @attributes = {}

    attributes.each do |name, val|
      __send__ "#{name}=", val if respond_to? "#{name}="
    end
  end

  def [](name)
    @attributes[name]
  end

  def []=(name, value)
    @attributes[name] = value
  end
end