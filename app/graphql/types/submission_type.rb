module Types
  class SubmissionType < Types::BaseObject
    field :id, ID, null: false
    field :created_at, String, null: false
    field :passed_at, String, null: true
    field :evaluator_name, String, null: true
    field :feedback, [Types::SubmissionFeedbackType], null: false
    field :grades, [Types::GradeType], null: false
    field :files, [Types::SubmissionFileType], null: false
    field :evaluated_at, String, null: true
    field :checklist, GraphQL::Types::JSON, null: false

    def evaluator_name
      object.evaluator&.name
    end

    def grades
      object.timeline_event_grades.map do |submission_grading|
        {
          evaluation_criterion_id: submission_grading.evaluation_criterion_id,
          grade: submission_grading.grade
        }
      end
    end

    def feedback
      object.startup_feedback
    end

    def files
      object.timeline_event_files.with_attached_file.map do |file|
        {
          id: file.id,
          title: file.file.filename,
          url: Rails.application.routes.url_helpers.download_timeline_event_file_path(file)
        }
      end
    end
  end
end
