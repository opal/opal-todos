require 'bundler/setup'
require 'fileutils'
require 'opal'
require 'opal-erb'

desc "Build opal runtime, dependencies and todos app"
task :opal do
  build_to 'opal',        Opal.runtime
  build_to 'opal-jquery', Opal.build_gem('opal-jquery')
  build_to 'vienna',      Opal.build_gem('vienna')
  build_to 'todos',       Opal.build_files('app')

  build_to 'templates',   build_erb('footer')+ build_erb('todo')
end

def build_to(name, code)
  FileUtils.mkdir_p 'build'
  puts " * build/#{name}.js"
  File.open("build/#{name}.js", 'w+') { |o| o.puts code }
end

# Building an erb template will give something like:
#
#     proc do
#       # ... template code that returns a string
#     end
#
# So this method returns:
#
#     TEMPLATES['name'] = proc do
#       # ...
#     end
#
# ... parsed into javascript of course
def build_erb(name)
  path = "app/templates/#{name}.erb"
  src = Opal::ERB.compile(File.read(path))
  boot = "TEMPLATES['#{name}'] = #{src}"

  "// #{ path }\n#{ Opal.parse boot }\n"
end