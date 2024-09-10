require "schema_editor"

module SchemaEditor
  class PositionsController < ApplicationController
    def create
      bypassed_params = params.to_unsafe_h
      ConfigWritter.update_config(
        "custom_positions" => bypassed_params[:custom_positions],
        "positions" => bypassed_params[:positions]
      )
    end
  end
end
