namespace :schema_editor do
  desc "Generate schema_editor.yml inside config"
  task generate_config: :environment do
    config_path = Rails.root.join("config", "schema_editor.yml")

    if File.exist?(config_path)
      puts "File config/schema_editor.yml already exists"
    else
      File.open(config_path, "w") do |file|
        file.write({ custom_positions: false }.to_yaml.sub(/^---\s*/, ""))
      end
      puts "File config/schema_editor.yml has been generate"
    end
  end
end
