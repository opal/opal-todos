require 'vendor/model'

class Todo < Model
  attribute :title
  attribute :completed

  def self.active
    select { |todo| !todo.completed }
  end

  def self.completed
    select { |todo| todo.completed }
  end
end