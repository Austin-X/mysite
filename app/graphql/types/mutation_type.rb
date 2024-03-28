# frozen_string_literal: true

module Types
  class MutationType < Types::BaseObject
    field :book_create, mutation: Mutations::BookCreate
  end
end
