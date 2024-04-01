# frozen_string_literal: true

module Types
  class BookType < Types::BaseObject
    def self.authorized?(object, context)
      object.id < 10
    end

    def self.scope_items(items, context)
      items.each { |x| puts "ID: #{x.id}" }
      items.where('id < 10')
    end

    field :id, ID, null: false
    field :published_at, GraphQL::Types::ISO8601DateTime, null: false
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
    field :author_id, Integer, null: false
  end
end
