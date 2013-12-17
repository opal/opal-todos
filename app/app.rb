require 'opal'
require 'jquery'
require 'opal-jquery'
require 'opal-haml'
require 'vienna'

require 'views/app_view'
require 'views/todo_view'

require 'templates/footer'
require 'templates/todo'

require 'models/todo'

class Application
  def run
    @app_view = AppView.new
    router.update
  end

  def router
    @router ||= Vienna::Router.new.tap do |router|
      router.route('/:filter') do |params|
        apply_filter params[:filter]
      end
    end
  end

  def apply_filter(filter)
    Todo.all.each { |t| t.trigger :filter, filter }
    @app_view.show_filter filter
  end
end

# when document is ready, lets go!
Document.ready? do
  Application.new.run
end
