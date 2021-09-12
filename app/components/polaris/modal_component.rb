# frozen_string_literal: true

module Polaris
  class ModalComponent < Polaris::NewComponent
    renders_many :actions, Polaris::ButtonComponent
    renders_many :secondary_actions, Polaris::ButtonComponent

    renders_one :close_button, 'Polaris::ModalComponent::CloseButtonComponent'

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

    class CloseButtonComponent < Polaris::NewComponent
      def initialize(**system_arguments)
        @system_arguments = system_arguments
        @system_arguments[:tag] = "button"
        @system_arguments['aria-label'] = "Close"
        @system_arguments[:classes] = class_names(
          @system_arguments[:classes],
          "Polaris-Modal-CloseButton",
        )
      end

      def call
        render(Polaris::BaseComponent.new(**@system_arguments)) { polaris_icon(name: 'MobileCancelMajor', color: :base) }
      end
    end
  end
end
