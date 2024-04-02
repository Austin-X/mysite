# frozen_string_literal: true

module Types
  class BaseObject < GraphQL::Schema::Object
    edge_type_class(Types::BaseEdge)
    connection_type_class(Types::BaseConnection)
    field_class Types::BaseField

    def self.authorized?(object, context)
      return true if !object.respond_to?(:model_name)

      model = object.model_name.to_s.constantize
      belongs_to_author_model = model.reflect_on_all_associations(:belongs_to).map { |x| x.name }.include?(:author)

      if model == Author
        return object.id == 1
      elsif belongs_to_author_model
        return object.author.id == 1
      else
        return true
      end
    end

    def self.scope_items(items, context)
      return items if !items.respond_to?(:model)
      
      model = items.model
      belongs_to_author_model = model.reflect_on_all_associations(:belongs_to).map { |x| x.name }.include?(:author)

      if model == Author
        return items.where(id: 1)
      elsif belongs_to_author_model
        return items.where(author_id: 1)
      else
        return items
      end
    end
  end
end
