$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "spurs/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "spurs"
  s.version     = Spurs::VERSION
  s.authors     = ["Michael North"]
  s.email       = ["michael.north@truenorthapps.com"]
  s.homepage    = "http://github.com/TrueNorth/spurs"
  s.summary     = "Bells and whistles for Twitter Bootstrap"
  s.description = "Helpers and extensions for the Twitter Bootstrap user interface"

  s.files      = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.markdown"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "railties", ">= 3.1"
  s.add_dependency "actionpack", ">= 3.1"
  s.add_dependency "twitter-bootstrap-rails", "~> 2.0"
  s.add_dependency "haml", ">= 3.1"

  if (RUBY_PLATFORM == "java")
    s.add_dependency "therubyrhino", ">= 1.73.4"
  else
    s.add_dependency "therubyracer", ">= 0.10.1"
  end

  s.add_development_dependency "rails", "~> 3.1"
end
