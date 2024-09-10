module SchemaEditor
  module ConfigParser
    module_function

    def extract
      YAML.load_file(find_config)
    end

    def find_config
      Rails.root.join("config", "schema_editor.yml")
    end
  end
end
