require 'vendor/view'

class AppView < View

  element '#todoapp'

  on :keypress, '#new-todo' do |e|
    if e.which == 13 and !@input.value.strip.empty?
      App.create_todo title: @input.value.strip, completed: false
      @input.value = ''
    end
  end

  def initialize
    super
    @input = Document['#new-todo']
  end

  def add_todo(todo)
    view = TodoView.new todo
    view.render
    Document['#todo-list'] << view.element
  end
end