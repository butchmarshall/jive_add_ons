$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "jive_add_ons/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
	s.name        = "jive_add_ons"
	s.version     = JiveAddOns::VERSION
	s.authors     = ["Butch Marshall"]
	s.email       = ["butch.a.marshall@gmail.com"]
	s.homepage    = "https://github.com/butchmarshall/jive_add_ons"
	s.summary     = "Rails Engine for handling Jive add-ons."
	s.description = "Api endpoints for making your platform Jive ready."
	s.license     = "MIT"

	s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
	s.test_files = Dir["test/**/*"]

	s.add_dependency "rails", "~> 4.2.5"
	s.add_dependency "jive_os_apps", "~> 0.0.1"
	s.add_dependency "jive-signed_request"
	
	if RUBY_PLATFORM == 'java'
		s.add_development_dependency "jdbc-sqlite3", "> 0"
		s.add_development_dependency "activerecord-jdbcsqlite3-adapter", "> 0"
	else
		s.add_development_dependency "sqlite3", "> 0"
	end
	
	s.add_development_dependency "rspec-rails"
	s.add_development_dependency "factory_girl_rails"
	s.add_development_dependency "capybara"
	s.add_development_dependency "database_cleaner"
	s.add_development_dependency "rack-cors"
	s.add_development_dependency "angular-ui-bootstrap-rails"
end
