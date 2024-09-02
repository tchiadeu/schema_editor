Rails.application.routes.draw do
  mount SchemaEditor::Engine => "/schema_editor"
end
