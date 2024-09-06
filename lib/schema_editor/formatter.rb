module SchemaEditor
  module Formatter
    module_function

    def transform(column)
      column.gsub("_id", "").pluralize
    end
  end
end
