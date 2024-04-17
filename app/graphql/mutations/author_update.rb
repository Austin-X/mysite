# frozen_string_literal: true

module Mutations
  class AuthorUpdate < BaseMutation
    description "Updates an author by id"

    input_type Types::AuthorInputType

    field :author, Types::AuthorType

    def resolve(author:, **extr)
      author_record = Author.find(author.id)

      if author_record.update(extr)
       { author: author_record }
      end
    end
  end
end
