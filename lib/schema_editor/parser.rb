module SchemaEditor
  module Parser
    module_function

    def extract(schema)
      data = parse_tables(schema)
      sorted_data = data.sort_by do |key, _value|
        -(parse_foreign_keys(schema)[key] || 0)
      end.to_h
      sorted_data
    end

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
      references = {}
      filtered_content = schema.scan(/add_foreign_key "(\w+)", "(\w+)"/)
      filtered_content.each do |table|
        if references.has_key?(table[1])
          references[table[1]] += 1
        else
          references[table[1]] = 1
        end
      end
      references
    end

    private_class_method(:parse_tables, :parse_foreign_keys)
  end
end
