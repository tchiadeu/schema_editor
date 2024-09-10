SchemaEditor::Engine.routes.draw do
  resources :schema, only: :index
  root to: "schemas#index"

  resources "positions", only: :create
  # post "schema_editor/positions", to: "positions#update_positions"
end
