require 'vienna/template_view'

class TodoView < Vienna::TemplateView
  template :todo

  on :dblclick, 'label' do
    @element.add_class 'editing'
    @input.focus
  end

  on :keypress, '.edit' do |e|
    finish_editing if e.which == 13
  end

  on :blur, '.edit' do
    finish_editing
  end

  on :click, '.destroy' do
    @todo.destroy
  end

  on :click, '.toggle' do
    @todo.update :completed => !@todo.completed
  end

  def initialize(todo)
    @todo = todo
    @todo.on(:update) { render }
    @todo.on(:destroy) { remove }
  end

  def clear
    @todo.destroy
  end

  def finish_editing
    value = @input.value.strip
    @element.remove_class 'editing'
    value.empty? ? clear : @todo.update(:title => value)
  end

  def remove
    element.remove
  end

  def render
    super
    @input = element.find '.edit'
  end

  def tag_name
    :li
  end
end
