module Mutations
  class UpdateBook < BaseMutation
    argument :id, ID, required: true
    argument :title, String, required: false
    argument :description, String, required: false
    argument :publication_year, Integer, required: false
    argument :author_id, ID, required: false

    field :book, Types::BookType, null: true

    def resolve(id:, **args)
      check_authentication!

      book = Book.find(id)
      book.update(args) ? { book: book } : validation_errors!(book)
    rescue ActiveRecord::RecordNotFound => e
      raise GraphQL::ExecutionError, e.message
    end
  end
end