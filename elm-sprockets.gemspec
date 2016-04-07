$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "elm_sprockets/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "elm-sprockets"
  s.version     = SprocketsElm::VERSION
  s.authors     = ["Richard Feldman", "Joshua Leven", "Marica Odagaki"]
  s.email       = ["richard@noredink.com"]
  s.homepage    = "https://github.com/noredink/elm-sprockets"
  s.summary     = "Compiles Elm Modules"
  s.description = "Compiles Elm Modules to Sprockets-friendly JavaScript"

  s.files = Dir["{app,config,db,lib}/**/*"] + ["LICENSE", "Rakefile", "README.md"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 3.2.22.2"

  s.add_development_dependency "sqlite3"
end
