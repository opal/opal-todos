class TodosApp
  include Enumerable

  def initialize
    @todos    = []
    @app_view = AppView.new
  end

  def each(&block)
    @todos.each { |t| yield t }
  end

  def create_todo(attrs)
    todo = Todo.new(attrs)
    @app_view.add_todo todo
    @todos << todo
  end

  def completed
    select { |t| t.completed }
  end

  def remaining
    select { |t| !t.completed }
  end
end

Document.ready? do
  App = TodosApp.new
end