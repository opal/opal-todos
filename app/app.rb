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

# when document is ready, lets go!
Document.ready? do
  App = AppView.new
end
