class CreateAnswerLikeMutator < ApplicationQuery
  include AuthorizeCommunityUser

  property :answer_id, validates: { presence: { message: 'BlankAnswerId' } }

  def create_answer_like
    AnswerLike.where(
      user: current_user,
      answer: answer
    ).first_or_create!.id
  end

  private

  alias authorized? authorized_create?

  def community
    @community ||= answer&.community
  end

  def answer
    @answer ||= Answer.find_by(id: answer_id)
  end
end
