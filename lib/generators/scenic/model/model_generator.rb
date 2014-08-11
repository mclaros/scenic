require "rails/generators"
require "generators/scenic/view/view_generator"

module Scenic
  module Generators
    class ModelGenerator < Rails::Generators::NamedBase
      source_root File.expand_path("../templates", __FILE__)

      def split_name_and_arguments
        args = name.split(":")
        @name_with_arguments = name
        self.name = args.shift
        assign_names!(self.name)
        args.each do |arg|
          setter = "#{arg}="
          if respond_to?(setter)
            send(setter, true)
          end
        end
      end

      check_class_collision

      def create_model_file
        template("model.erb", "app/models/#{file_name}.rb")
      end

      def invoke_view_generator
        invoke "scenic:view", [@name_with_arguments]
      end

      private

      attr_accessor :materialized
    end
  end
end
