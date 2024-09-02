module SchemaEditor
  module Parser
    module_function
    def parse_tables(schema)
      tables = {}
      filtered_content = schema.scan(/create_table "(\w+)", .*? do \|t\|([\s\S]*?)end/m)
      filtered_content.each do |table_name, table_body|
        columns = {}
        table_body.scan(/t\.(\w+) "(\w+)"/).each do |type, name|
          columns[name] = type
        end
        tables[table_name] = columns
      end
      tables
    end

    def parse_foreign_keys(schema)
      foreign_keys = {}
      filtered_content = schema.scan(/add_foreign_key "(\w+)", "(\w+)"/)
      filtered_content.each do |table_name, reference_table|
        foreign_keys[table_name] ||= []
        foreign_keys[table_name] << reference_table
      end
      foreign_keys
    end
  end
end
