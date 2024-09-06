module SchemaEditor
  class Engine < ::Rails::Engine
    isolate_namespace SchemaEditor

    initializer "schema_editor.assets.precompile" do |app|
      app.config.assets.precompile += %w(schema_editor/application.css schema_editor/table.js schema_editor/references.js)
    end
  end
end
