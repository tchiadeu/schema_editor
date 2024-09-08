require "schema_editor"

module SchemaEditor
  class SchemasController < ApplicationController
    before_action :raise_error?
    
    def index
      data = Parser.extract(set_file)
      @schema = data[:tables]
      foreign_keys = data[:foreign_keys]
      @references = ReferencesFinder.filter(@schema, foreign_keys)
    end

    def replace_id(column)
      Formatter.transform(column)
    end
    helper_method :replace_id

    private

    def set_file
      # schema_path = Rails.root.join("spec", "fixtures", "schema.rb")
      schema_path = Rails.root.join("db", "schema.rb")
      File.read(schema_path)
    end

    def raise_error?
      raise "Schema Editor must run in dev env" if Rails.env.production?
    end
  end
end
