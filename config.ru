require 'bundler'
Bundler.require

require 'opal-sprockets'

run Opal::Server.new { |s|
  s.append_path 'app'

  s.index_path = 'index.html'
  s.public_dir = File.dirname(__FILE__)
  s.debug = false
  s.main = 'app'
}
