require 'opal'
require 'opal-jquery'
require 'opal-erb'
require 'vienna'

require 'views/app_view'
require 'views/todo_view'

require 'templates/footer'
require 'templates/todo'

require 'lib/local_storage'
require 'lib/model'

require 'models/todo'

# when document is ready, lets go!
Document.ready? do
  App = AppView.new
end
