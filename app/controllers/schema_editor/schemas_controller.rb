require "schema_editor/parser"

module SchemaEditor
  class SchemasController < ApplicationController
    def index
      schema_path = Rails.root.join("spec", "fixtures", "schema.rb")
      schema_content = File.read(schema_path)
      @schema = Parser.extract(schema_content)
    end
  end
end
