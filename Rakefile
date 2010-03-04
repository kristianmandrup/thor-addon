require 'rubygems'
require 'rake' 

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "thor-addon"
    gem.summary = %Q{Extends Thor::Actions with some extra functions and patches the gem function}
    gem.description = %Q{Improves Thor::Actions by adding some extra functionality and fixes a few 'bugs'}
    gem.email = "kmandrup@gmail.com"
    gem.homepage = "http://github.com/kristianmandrup/thor-ext"
    gem.authors = ["Kristian Mandrup"]
    gem.add_development_dependency "rspec", ">= 2.0.0"
    gem.files = FileList['lib/**/*.rb']
    
    # gem is a Gem::Specification... see http://www.rubygems.org/read/chapter/20 for additional settings
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: gem install jeweler"
end

