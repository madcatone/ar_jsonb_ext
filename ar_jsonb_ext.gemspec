$:.push File.expand_path("lib", __dir__)

# Maintain your gem's version:
require "ar_jsonb_ext/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "ar_jsonb_ext"
  s.version     = ArJsonbExt::VERSION
  s.authors     = ["Jos3p4Hong"]
  s.email       = ["madcatone1@gmail.com"]
  s.homepage    = 'https://github.com/dealglobe/ar_jsonb_ext'
  s.summary     = 'ActiveRecord Jsonb Extension'
  s.description = 'An ActiveRecord Jsonb Extension gem'
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_runtime_dependency 'rails', '~> 5.2', '>= 5.2.0'

  s.add_development_dependency 'pg', '~> 0'
end
