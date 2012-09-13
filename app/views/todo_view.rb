require 'vendor/view'

class TodoView < View

  attr_reader :element

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
    puts "toggling"
    @todo.update_attribute :completed, !@todo.completed
    puts @todo.completed
  end

  def initialize(todo)
    super
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
    value.empty? ? clear : @todo.update_attribute(:title, value)
  end

  def remove
    @element.remove
  end

  def render
    @element.html = <<-HTML
      <div class="view">
        <input class="toggle" type="checkbox" #{@todo.completed && 'checked'}>
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