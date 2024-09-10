require "schema_editor"

module SchemaEditor
  class SchemasController < ApplicationController
    before_action :raise_error?

    def index
      data = DBParser.extract
      @schema = data[:tables]
      foreign_keys = data[:foreign_keys]
      @references = ReferencesFinder.filter(@schema, foreign_keys)
    end

    def replace_id(column)
      Formatter.transform(column)
    end
    helper_method :replace_id

    def style_table(table)
      positions = ConfigParser.extract["positions"]
      return nil unless positions

      table_positions = positions[table.to_s]
      "top: #{table_positions["top"]}px; left: #{table_positions["left"]}px"
    end
    helper_method :style_table

    def custom_position?
      ConfigParser.extract["custom_positions"]
    end
    helper_method :custom_position?

    private

    def raise_error?
      raise "Schema Editor must run in dev env" if Rails.env.production?
    end
  end
end
