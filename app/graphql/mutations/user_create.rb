# frozen_string_literal: true

module Mutations
  class UserCreate < BaseMutation
    description "Creates a new user"

    field :user, Types::UserType, null: false

    argument :name, String, required: false

    def resolve(name:)
      user = ::User.new(name: name)
      raise GraphQL::ExecutionError.new "Error creating user", extensions: user.errors.to_hash unless user.save

      { user: user }
    end
  end
end
