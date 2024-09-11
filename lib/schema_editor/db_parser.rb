module SchemaEditor
  module DBParser
    module_function

    def extract
      foreign_keys = parse_foreign_keys
      sorted_data = parse_tables.sort_by do |key, _value|
        -(foreign_keys[key] || 0)
      end.to_h
      { tables: sorted_data, foreign_keys: foreign_keys.keys }
    end

    def parse_foreign_keys
      references = {}
      filtered_content = set_schema.scan(/add_foreign_key "(\w+)", "(\w+)"/)
      filtered_content.each do |table|
        next if table[0].match?("active_storage")

        references.has_key?(table[1]) ? references[table[1]] += 1 : references[table[1]] = 1
      end
      references
    end

    def parse_tables
      tables = {}
      regex = /create_table\s+"(\w+)",\s+force:\s*:cascade\s+do\s+\|t\|\s+([\s\S]*?)\bend\b/m
      filtered_content = set_schema.scan(regex)
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

    def set_schema
      File.read(
        # Rails.root.join("spec", "fixtures", "schema.rb")
        Rails.root.join("db", "schema.rb")
      )
    end

    private_class_method(:parse_tables, :parse_foreign_keys, :set_schema)
  end
end
