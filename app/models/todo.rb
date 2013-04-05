require 'lib/local_storage'

class Todo < Vienna::Model
  include Vienna::LocalStorage

  attributes :title, :completed

  # All active (not completed) todos
  # @return [Array<Todo>]
  def self.active
    select { |todo| !todo.completed }
  end

  # All completed todos
  # @return [Array<Todo>]
  def self.completed
    select { |todo| todo.completed }
  end
end
