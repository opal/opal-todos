require 'vendor/view'

class TodoView < View

  attr_reader :element

  on :dblclick, 'label' do
    @element.add_class 'editing'
    @input.focus
  end

  on :keypress, '.edit' do |e|
    self.close if e.which == 13
  end

  on :click, '.destroy' do
    @todo.destroy
  end

  def initialize(todo)
    super
    @todo = todo
    @todo.on(:change) { puts 'todoview change' }
    @todo.on(:destroy) { remove }
    @todo.on(:visible) { puts 'todoview visible' }
  end

  def clear
    @todo.destroy
  end

  def close
    value = @input.value.strip

    if value.empty?
      clear
    else
      @todo.title = value
      save
    end

    @element.remove_class 'editing'
  end

  def remove
    @element.remove
  end

  def render
    @element.html = <<-HTML
      <div class="view">
        <input class="toggle" type="checkbox" #{@todo.completed && '"checked"'}>
        <label>#{@todo.title}</label>
        <button class="destroy"></button>
      </div>
      <input class="edit" value="#{@todo.title}">
    HTML

    @input = @element.find '.edit'
  end

  def tag_name
    :li
  end
end