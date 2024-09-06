module SchemaEditor
  module ReferencesFinder
    module_function

    def filter(tables)
      references = []
      tables.each do |_table, value|
        value.keys.each do |key|
          references << key if key.match?(/_id/)
        end
      end
      references
    end
  end
end
