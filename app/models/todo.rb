require 'local_storage'

class Todo < LocalStorage::Model
  @storage_name = 'todos'

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
end