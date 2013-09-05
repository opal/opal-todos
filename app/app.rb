require 'opal'
require 'jquery'
require 'opal-jquery'
require 'erb'
require 'vienna'

require 'views/app_view'
require 'views/todo_view'

require 'templates/footer'
require 'templates/todo'

require 'models/todo'

module Vienna
  class << self
    attr_accessor :application
  end

  class Application
    class << self
      def inherited(base)
        Vienna.application ||= base.instance
      end

      def method_missing(sym, *args)
        instance.__send__(sym, *args)
      end

      def instance
        @instance ||= self.new
      end
    end
  end
end

class Application < Vienna::Application
  def run
    @app_view = AppView.new
  end
end

# when document is ready, lets go!
Document.ready? do
  Application.run
end
