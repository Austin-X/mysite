# frozen_string_literal: true

module Types
  class AuthorType < Types::BaseObject
    def self.model
      ::Author
    end
    
    field :id, ID, null: false
    field :name, String
    field :published, Integer
    field :books, [Types::BookType]
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
  end
end
