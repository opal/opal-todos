class AppView
  ENTER_KEY = 13

  def initialize
    @element = Document['#todoapp']
    @input = Document['#new-todo']

    @element.on(:keypress, '#new-todo') { |e| create_on_enter e }
    # @element.on(:click, '#clear-completed') { create_on_enter }
    # @element.on(:click, '#toggle-all') { create_on_enter }
  end

  def create_on_enter(evt)
    if evt.which == ENTER_KEY and !@input.value.strip.empty?
      App.create_todo title: @input.value.strip, completed: false
      @input.value = ''
    end
  end

  def add_todo(todo)
    view = TodoView.new todo
    view.render
    Document['#todo-list'] << view.element
  end
end