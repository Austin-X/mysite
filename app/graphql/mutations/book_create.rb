# frozen_string_literal: true

module Mutations
  class BookCreate < BaseMutation
    description 'Creates a new book'

    field :book, Types::BookType, null: false

    argument :published_at, GraphQL::Types::ISO8601DateTime, required: true
    argument :author_id, Int, required: true

    def resolve(published_at:, author_id:)
      book = ::Book.new(published_at:, author_id:)
      raise GraphQL::ExecutionError.new 'Error creating book', extensions: book.errors.to_hash unless book.save

      { book: }
    end
  end
end
