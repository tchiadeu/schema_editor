module SchemaEditor
  module ConfigWritter
    module_function

    def update_config(data)
      file = ConfigParser.find_config
      config = ConfigParser.extract
      new_config = config.merge(data)
      cleaned_config = clean_obj(new_config)
      File.open(file, "w") do |file|
        file.write(cleaned_config.to_yaml.sub(/^---\s*/, ""))
      end
    end

    def clean_obj(obj)
      if obj.is_a?(Hash)
        obj.to_h.map do |key, value|
          [ key, clean_obj(value) ]
        end.to_h
      elsif obj.is_a?(Array)
        obj.map { |item| clea_obj(item) }
      else
        obj
      end
    end
  end
end
