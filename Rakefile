require 'bundler/setup'
require 'opal/rake_task'

Opal::RakeTask.new do |t|
  t.name = 'todos'
  t.files = 'app'
  t.dependencies = %w[opal-jquery vienna]
end

desc "Build templates"
task :templates do
  puts " * build/templates.js"
  File.open("build/templates.js", "w+") do |o|
    o.puts parse_erb('footer')
    o.puts parse_erb('todo')
  end
end

def parse_erb(name)
  Opal.parse_erb File.read("app/templates/#{name}.erb"), name
end

task :default => [:opal, :templates]