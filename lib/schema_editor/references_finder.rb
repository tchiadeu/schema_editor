module SchemaEditor
  module ReferencesFinder
    module_function

    def filter(tables, foreign_keys)
      references = []
      tables.each do |_table, value|
        value.keys.each do |key|
          next unless key.match?(/_id/) && foreign_keys.include?(Formatter.transform(key))

          references << key if key.match?(/_id/)
        end
      end
      references
    end
  end
end
