$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "knowledge-camp/api/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "knowledge-camp-api"
  s.version     = KnowledgeCampApi::VERSION
  s.authors     = ["Kaid"]
  s.email       = ["info@kaid.me"]
  s.homepage    = "http://github/mindpin/knowledge-camp-api"
  s.summary     = "API module for KnowledgeCamp project."
  s.description = "API module for KnowledgeCamp project."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", ">= 4.0.0"
end
