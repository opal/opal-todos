require 'lib/local_storage'

class Todo < Vienna::Model
  include Vienna::LocalStorage

  attribute :title
  attribute :completed

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

  def to_json
    { title: @title, completed: @completed }.to_json
  end
end
