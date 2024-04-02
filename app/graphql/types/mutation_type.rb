# frozen_string_literal: true

module Types
  class MutationType < Types::BaseObject
    field :book_update, mutation: Mutations::BookUpdate
    field :author_update, mutation: Mutations::AuthorUpdate
    field :user_create, mutation: Mutations::UserCreate
    field :book_create, mutation: Mutations::BookCreate
  end
end
