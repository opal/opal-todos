require 'vienna/local_storage'

class Todo < Vienna::Model
  include Vienna::LocalStorage

  def self.create attrs = {}
    model = self.new attrs
    model.save
    model
  end

  def self.plural_name
    @plural_name ||= "#{name.downcase}s"
  end

  def update attrs
    self.attributes = attrs
    save
  end

  attributes :title, :completed

  # All active (not completed) todos
  # @return [Array<Todo>]
  def self.active
    all.select { |todo| !todo.completed }
  end

  # All completed todos
  # @return [Array<Todo>]
  def self.completed
    all.select { |todo| todo.completed }
  end
end
