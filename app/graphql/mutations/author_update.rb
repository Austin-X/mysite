# frozen_string_literal: true

module Mutations
  class AuthorUpdate < BaseMutation
    description "Updates a author by id"

    field :author, Types::AuthorType, null: false

    argument :id, ID, required: true
    argument :name, String, required: false

    def resolve(id:, name:)
      author = ::Author.find(id)
      raise GraphQL::ExecutionError.new "Error updating author", extensions: author.errors.to_hash unless author.update(name: name)
      
      { author: author }
    end
  end
end
