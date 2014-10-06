require "rails/generators"
require "generators/scenic/view/view_generator"

module Scenic
  module Generators
    class ModelGenerator < Rails::Generators::NamedBase
      source_root File.expand_path("../templates", __FILE__)

      class_option :materialized,
        type: :boolean,
        required: false,
        desc: "Makes the view materialized"

      check_class_collision

      def create_model_file
        template("model.erb", "app/models/#{file_name}.rb")
      end

      def invoke_view_generator
        invoke "scenic:view", [singular_name]
      end

      private

      def materialized
        options.key? :materialized
      end
    end
  end
end
