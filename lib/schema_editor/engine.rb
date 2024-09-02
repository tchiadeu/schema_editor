module SchemaEditor
  class Engine < ::Rails::Engine
    isolate_namespace SchemaEditor

    config.generators do |g|
      g.test_framework :rspec
    end
  end
end
