require_relative "lib/schema_editor/version"

Gem::Specification.new do |spec|
  spec.name        = "schema_editor"
  spec.version     = SchemaEditor::VERSION
  spec.authors     = [ "tchiadeu" ]
  spec.email       = [ "contact@kevintchiadeu.com" ]
  spec.homepage    = "https://github.com/tchiadeu/schema_editor"
  spec.summary     = "Editor to manage your DB schema"
  spec.description = "SchemaEditor is a Rails gem that help you to visually manager your DB. You can find all the tables and you have snippet to edit the schema."
  spec.license     = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the "allowed_push_host"
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  # spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"

  spec.metadata["homepage_uri"] = spec.homepage
  # spec.metadata["source_code_uri"] = "TODO: Put your gem's public repo URL here."
  # spec.metadata["changelog_uri"] = "TODO: Put your gem's CHANGELOG.md URL here."

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]
  end

  spec.add_dependency "rails", ">= 7.2.1"
  spec.add_dependency "turbo-rails"
  # spec.add_dependency "turbo-rails"
end
