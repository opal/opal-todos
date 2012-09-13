class TodoView
  ENTER_KEY = 13

  attr_reader :element

  def initialize(todo)
    @todo = todo
    @todo.on(:change) { puts 'todoview change' }
    @todo.on(:destroy) { remove }
    @todo.on(:visible) { puts 'todoview visible' }

    @element = Element.new :li
    @element.on(:dblclick, 'label') { edit }
    @element.on(:keypress, '.edit') { |e| update_on_enter e }
    @element.on(:click, '.destroy') { clear }
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

  def edit
    @element.add_class 'editing'
    @input.focus
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

  def update_on_enter(e)
    close if e.which == ENTER_KEY
  end
end