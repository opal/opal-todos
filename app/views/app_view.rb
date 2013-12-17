class AppView < Vienna::View
  element '#todoapp'

  on :keypress, '#new-todo' do |e|
    value = @input.value.strip
    if e.which == 13 and !value.empty?
      Todo.create title: value, completed: false
      @input.value = ''
    end
  end

  on :click, '#toggle-all' do
    Todo.all.each { |t| t.update(:completed => !t.completed) }
  end

  on :click, '#clear-completed' do
    Todo.completed.each { |t| t.destroy }
  end

  def initialize
    @input = Element.find '#new-todo'
    @footer = Element.find '#footer'

    Todo.on(:create) { |todo| add_todo(todo); render }
    Todo.on(:update) { render }
    Todo.on(:destroy) { render }

    Todo.adapter.find_all(Todo) do |models|
      models.each { |m| add_todo m }
    end

    self.element
    self.render
  end

  def add_todo(todo)
    view = TodoView.new todo
    view.render
    Element.find('#todo-list') << view.element
  end

  def render
    @completed = Todo.completed.size
    @active = Todo.active.size

    @footer.html = template.render(self)
  end

  def show_filter(filter)
    links = @footer.find 'li a'
    links.remove_class 'selected'
    links.filter("a[href=\"#/#{filter}\"]").add_class 'selected'
  end

  def template
    Template['footer']
  end

  def todo_count
    prefix = @active == 1 ? 'item' : 'items'
    prefix + " left"
  end

  def show_completed?
    @completed > 0
  end
end
