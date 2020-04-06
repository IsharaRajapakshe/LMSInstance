module Mutations
  class UpdateAnswer < GraphQL::Schema::Mutation
    argument :id, ID, required: true
    argument :description, String, required: true

    description "Update community answer"

    field :success, Boolean, null: true
    field :errors, [Types::UpdateAnswerErrors], null: true

    def resolve(params)
      mutator = UpdateAnswerMutator.new(context, params)

      if mutator.valid?
        { success: mutator.update_answer, errors: nil }
      else
        { success: nil, errors: mutator.error_messages }
      end
    end
  end
end
