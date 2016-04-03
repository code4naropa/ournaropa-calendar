$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "ournaropa_calendar/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "ournaropa_calendar"
  s.version     = OurnaropaCalendar::VERSION
  s.authors     = ["Finn Woelm"]
  s.email       = ["finn.woelm@gmail.com"]
  s.homepage    = "http://www.ournaropa.org"
  s.summary     = "One calendar for all of Naropa."
  s.description = "Description of OurnaropaCalendar."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 4.2.4"
  s.add_dependency "materialize-sass"
  s.add_dependency "material_icons"
  s.add_dependency "chronic"
  
  
  s.add_development_dependency "pg"
end
