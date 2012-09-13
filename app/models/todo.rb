require 'vendor/eventable'

class Todo
  include Eventable

  attr_accessor :title, :completed

  def initialize(attributes={})
    attributes.each { |name, val| __send__ "#{name}=", val }
  end

  def destroy
    trigger :destroy
  end

  def toggle
    @completed = !@completed
    # save
  end
end