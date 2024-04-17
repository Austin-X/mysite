# frozen_string_literal: true

module Types
  class AuthorInputType < Types::BaseInputObject
    argument :id, ID, loads: Types::AuthorType, as: :author
    argument :name, String
    argument :published, Integer, required: false
    argument :created_at, GraphQL::Types::ISO8601DateTime, required: false
    argument :updated_at, GraphQL::Types::ISO8601DateTime, required: false
  end
end
