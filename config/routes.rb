SchemaEditor::Engine.routes.draw do
  resources :schema, only: :index
  root to: "schemas#index"
end
