# frozen_string_literal: true

module Types
  class BaseInputObject < GraphQL::Schema::InputObject
    argument_class Types::BaseArgument

    def self.object_from_id(type, id, context)
      model = type.model.to_s.constantize
      model.find(id)
    end
  end
end
