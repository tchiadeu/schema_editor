module SchemaEditor
  module Parser
    module_function

    def extract(schema)
      data = parse_tables(schema)
      foreign_keys = parse_foreign_keys(schema)
      sorted_data = data.sort_by do |key, _value|
        -(foreign_keys[key] || 0)
      end.to_h
      { tables: sorted_data, foreign_keys: foreign_keys.keys }
    end

    def parse_foreign_keys(schema)
      references = {}
      filtered_content = schema.scan(/add_foreign_key "(\w+)", "(\w+)"/)
      filtered_content.each do |table|
        next if table[0].match?("active_storage")

        references.has_key?(table[1]) ? references[table[1]] += 1 : references[table[1]] = 1
      end
      references
    end

    def parse_tables(schema)
      tables = {}
      regex = /create_table\s+"(\w+)",\s+force:\s*:cascade\s+do\s+\|t\|\s+([\s\S]*?)\bend\b/m
      filtered_content = schema.scan(regex)
      filtered_content.each do |table_name, table_body|
        next if table_name.match?("active_storage")

        columns = {}
        table_body.scan(/t\.(\w+) "(\w+)"/).each do |type, name|
          columns[name] = type
        end
        tables[table_name] = columns
      end
      tables
    end

    private_class_method(:parse_tables, :parse_foreign_keys)
  end
end
