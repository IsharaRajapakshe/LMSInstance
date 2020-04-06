module Answers
  class VersionsPresenter < ApplicationPresenter
    def initialize(view_context, answer)
      super(view_context)

      @answer = answer
    end

    def page_title
      "Versions | Answer"
    end

    def versions
      @versions ||= @answer.text_versions
    end

    def version_number_for_answer
      versions_count + 1
    end

    def markdown_prop(markdown)
      {
        markdown: markdown,
        profile: "questionAndAnswer"
      }.to_json
    end

    def version_number(index)
      versions_count - index
    end

    def editor_name_for_answer
      if @answer.editor.present?
        @answer.editor.name
      else
        @answer.creator.name
      end
    end

    def updated_at(object)
      object.updated_at.to_formatted_s(:long)
    end

    private

    def versions_count
      @versions_count ||= versions.count
    end
  end
end
