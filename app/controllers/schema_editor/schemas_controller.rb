require "schema_editor"

module SchemaEditor
  class SchemasController < ApplicationController
    def index
      @schema = Parser.extract(set_file)
      @references = ReferencesFinder.filter(@schema).map { |column| replace_id(column) }
    end

    def replace_id(column)
      column.gsub("_id", "s")
    end
    helper_method :replace_id

    private

    def set_file
      # schema_path = Rails.root.join("spec", "fixtures", "schema.rb")
      schema_path = Rails.root.join("db", "schema.rb")
      File.read(schema_path)
    end
  end
end
