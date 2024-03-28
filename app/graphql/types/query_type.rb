# frozen_string_literal: true

module Types
  class QueryType < Types::BaseObject
    description 'The query root of this schema'

    field :node, Types::NodeType, null: true, description: 'Fetches an object given its ID.' do
      argument :id, ID, required: true, description: 'ID of the object.'
    end

    def node(id:)
      context.schema.object_from_id(id, context)
    end

    field :nodes, [Types::NodeType, { null: true }], null: true,
                                                     description: 'Fetches a list of objects given a list of IDs.' do
      argument :ids, [ID], required: true, description: 'IDs of the objects.'
    end

    def nodes(ids:)
      ids.map { |id| context.schema.object_from_id(id, context) }
    end

    # Add root-level fields here.
    # They will be entry points for queries on your schema.

    field :all_authors, [Types::AuthorType], null: false
    def all_authors
      Author.all
    end

    field :author, Types::AuthorType, null: false do
      argument :id, ID, required: true
    end
    def author(id:)
      Author.find(id)
    end

    field :all_books, [Types::BookType], null: false
    def all_books
      Book.all
    end

    field :book, Types::BookType, null: false do
      argument :id, ID, required: true
    end
    def book(id:)
      Book.find(id)
    end
  end
end
