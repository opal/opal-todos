require 'vendor/view'

class AppView < View

  element '#todoapp'

  on :keypress, '#new-todo' do |e|
    value = @input.value.strip
    if e.which == 13 and !value.empty?
      Todo.create title: value, completed: false
      @input.value = ''
    end
  end

  on :click, '#toggle-all' do
    Todo.each { |t| t.update_attribute(:completed, !t.completed) }
  end

  on :click, '#clear-completed' do
    Todo.completed.each { |t| t.destroy }
  end

  def initialize
    super
    @input = Document['#new-todo']
    @footer = Document['#footer']

    Todo.on(:create) { |todo| add_todo(todo); render }
    Todo.on(:update) { render }
    Todo.on(:destroy) { render }
  end

  def add_todo(todo)
    view = TodoView.new todo
    view.render
    Document['#todo-list'] << view.element
  end

  def render
    completed = Todo.completed.size
    active = Todo.active.size

    @footer.html = <<-HTML
      <span id="todo-count">
        <strong>#{active}</strong> #{active == 1 ? 'item' : 'items'} left
      </span>
  		<ul id="filters">
  			<li><a class="selected" href="#/">All</a></li>
  			<li><a href="#/active">Active</a></li>
  			<li><a href="#/completed">Completed</a></li>
  		</ul>
      #{completed == 0 ? '' : "<button id=\"clear-completed\">Clear completed (#{completed})</button>"}
    HTML
  end
end