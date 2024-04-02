# frozen_string_literal: true

module Types
  class BaseObject < GraphQL::Schema::Object
    edge_type_class(Types::BaseEdge)
    connection_type_class(Types::BaseConnection)
    field_class Types::BaseField

    class << self
      def object_is_or_belongs_to_first_author(object)
        return true if !object.respond_to?(:model_name)

        model = object.model_name.to_s.constantize
        belongs_to_author_model = model.reflect_on_all_associations(:belongs_to).map { |x| x.name }.include?(:author)
        
        return (model != Author && !belongs_to_author_model) || (model == Author && object.id == 1) || (belongs_to_author_model && object.author.id == 1)
      end

      def authorized?(object, context)
        super && object_is_or_belongs_to_first_author(object)
      end

      def filter_items_by_first_author(items)
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

      def scope_items(items, context)
        super && filter_items_by_first_author(items)
      end
    end
  end
end
