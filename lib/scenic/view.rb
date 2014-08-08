module Scenic
  class View
    attr_reader :name, :definition, :materialized
    delegate :<=>, to: :name

    def initialize(view_row)
      @name = view_row["viewname"]
      @definition = view_row["definition"].strip
      @materialized = view_row["materialized"] == "t"
    end

    def ==(other)
      name == other.name &&
        definition == other.definition &&
        materialized == other.materialized
    end

    def to_schema
      <<-DEFINITION.strip_heredoc
        create_view :#{name}, #{ "materialized: true, " if materialized }sql_definition:<<-\SQL
          #{definition}
        SQL
      DEFINITION
    end
  end
end
