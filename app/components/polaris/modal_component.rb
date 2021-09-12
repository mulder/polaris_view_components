# frozen_string_literal: true

module Polaris
  class ModalComponent < Polaris::NewComponent
    renders_many :actions, Polaris::ButtonComponent
    renders_many :secondary_actions, Polaris::ButtonComponent

    def initialize(
      title: nil,
      form_options: nil,
      **system_arguments
    )

      @title = title
      @form_options = form_options

      @system_arguments = system_arguments
      @system_arguments[:tag] = "div"
      @system_arguments[:role] = "dialog"
      @system_arguments[:classes] = class_names(
        @system_arguments[:classes],
        "Polaris-Modal-Dialog",
      )
    end

    def form?
      @form_options.present?
    end

    def render_footer?
      actions.present? || secondary_actions.present?
    end
  end
end
