# frozen_string_literal: true

module Mutations
  class BookUpdate < BaseMutation
    description "Updates a book by id"

    field :book, Types::BookType, null: false

    argument :id, ID, required: true
    argument :author_id, ID, required: true

    def resolve(id:, author_id:)
      book = ::Book.find(id)
      raise GraphQL::ExecutionError.new "Error updating book", extensions: book.errors.to_hash unless book.update(author: Author.find(author_id))

      { book: book }
    end
  end
end
