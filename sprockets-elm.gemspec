Gem::Specification.new do |s|
  s.name               = "sprockets-elm"
  s.version            = "0.0.1"
  s.default_executable = "sprockets-elm"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Richard Feldman", "Joshua Leven", "Marica Odagaki"]
  s.date = %q{2010-04-03}
  s.description = %q{Compiles Elm Modules to Sprockets-friendly JavaScript}
  s.email = %q{richard@noredink.com}
  s.files = ["lib/elm_sprockets.rb", "lib/elm_compiler.rb"]
  s.licenses = ["Apache-2.0"]
  s.test_files = ["Rakefile, ""test/test_elm_compiler.rb"]
  s.homepage = %q{http://rubygems.org/gems/sprockets-elm}
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.6.2}
  s.summary = %q{Compiles Elm modules}

  s.add_runtime_dependency "sprockets", "~> 2.2"

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
