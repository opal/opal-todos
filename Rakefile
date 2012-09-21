require 'bundler/setup'
require 'opal/rake_task'
require 'opal-erb'

Opal::RakeTask.new do |t|
  t.name = 'todos'
  t.files = 'app'
  t.dependencies = %w[opal-jquery vienna]
end

desc "Build templates"
task :templates do
  puts " * build/templates.js"
  File.open("build/templates.js", "w+") do |o|
    o.puts build_erb('footer')
    o.puts build_erb('todo')
  end
end

def build_erb(name)
  path = "app/templates/#{name}.erb"
  Opal::ERB.parse File.read(path), name
end

task :default => [:opal, :templates]