# frozen_string_literal: true

module RackMiddleware
  class GqlRequestBookRestriction
    def initialize(app)
      @app = app
    end

    def call(env)
      puts "\n\nENV: #{env}"
      request = Rack::Request.new(env)

      if env['REQUEST_METHOD'] == 'POST' && env['PATH_INFO'].starts_with?('/graphql')
        # Intercept the incoming GraphQL query or mutation
        query_string = request.body.read
        MysiteSchema.execute(query_string)

        status, headers, response = @app.call(env)

        # You can log, modify, or analyze the query string here
        puts "\n\nREQUEST METHODS: #{request.methods}"
        puts "\n\nIntercepted query: #{query_string}"
        puts "\n\nSTATUS: #{status}"
        puts "\n\nHEADERS: #{headers}"

        payload = JSON.parse(request.body.read)
        query = payload['query'] || payload['mutation']
        puts "\n\nQuery: #{query}"

        if query
          types = extract_types(query)
          puts "GraphQL Types involved: #{types}"
        end

        [status, headers, response]
      else
        @app.call(env)
      end
    end

    def extract_types(query_string)
      document = GraphQL.parse(query_string)
      types = []

      # Traverse the AST to extract types
      document.definitions.each do |definition|
        if definition.is_a?(GraphQL::Language::Nodes::OperationDefinition)
          extract_types_from_node(definition.selections, types)
        end
      end

      types.uniq
    end

    def extract_types_from_node(node, types)
      node.each do |selection|
        case selection
        when GraphQL::Language::Nodes::Field
          puts "\n\nSELECTION METHODS: #{selection.methods}"
          puts "\n\nSELECTION ARGUMENTS: #{selection.arguments}"
          puts "\n\nSELECTION name: #{selection.name}"
          puts "\n\nSELECTION children: #{selection.children}"
          puts "\n\nSELECTION visit method: #{selection.visit_method}"
          puts "\n\nSELECTION directives: #{selection.directives}"
          puts "\n\nSELECTION scalars: #{selection.scalars}"
          puts "\n\nSELECTION children_method_name: #{selection.children_method_name}"

          puts "\n\nSELECTION children_method_name: #{selection.children_method_name}"

          # types << selection.type.name if selection.type.is_a?(GraphQL::Language::Nodes::TypeName)
          # extract_types_from_node(selection.selections, types) if selection.selections.any?
        when GraphQL::Language::Nodes::FragmentSpread
          # Handle fragment spreads
          # You may want to resolve the fragment and extract types from it
        end
      end
    end
  end
end
