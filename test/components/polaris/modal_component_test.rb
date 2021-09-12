require "test_helper"

class ModalComponentTest < Minitest::Test
  include Polaris::ComponentTestHelpers

  def test_default_modal
    render_inline(Polaris::ModalComponent.new(title: "Modal Title")) do
      "Modal Content"
    end

    assert_selector ".Polaris-Modal-Dialog__Modal" do
      assert_selector ".Polaris-Modal-Header" do
        assert_selector ".Polaris-Modal-Header__Title" do
          assert_selector "h2.Polaris-DisplayText.Polaris-DisplayText--sizeSmall", text: "Modal Title"
        end
      end

      assert_selector ".Polaris-Modal__BodyWrapper" do
        assert_selector ".Polaris-Modal__Body" do
          assert_selector ".Polaris-Modal-Section", text: "Modal Content"
        end
      end

    end
  end

  def test_modal_with_close_button
    render_inline(Polaris::ModalComponent.new) do |modal|
      modal.close_button(data: {action: 'modal#close'})
    end

    assert_selector ".Polaris-Modal-Dialog__Modal" do
      assert_selector ".Polaris-Modal-Header" do
        assert_selector "button[data-action='modal#close'].Polaris-Modal-CloseButton" do
          assert_selector ".Polaris-Icon"
        end
      end
    end
  end

  def test_modal_with_action
    render_inline(Polaris::ModalComponent.new(title: "Modal Title")) do |modal|
      modal.action(primary: true) { "Primary Button" }
    end

    assert_selector ".Polaris-Modal-Dialog__Modal" do
      assert_selector ".Polaris-Modal-Footer" do
        assert_selector ".Polaris-Modal-Footer__FooterContent" do
          assert_selector ".Polaris-Button--primary", text: "Primary Button"
        end
      end
    end
  end

  def test_modal_with_multiple_actions
    render_inline(Polaris::ModalComponent.new(title: "Modal Title")) do |modal|
      modal.action() { "Button" }
      modal.action(primary: true) { "Primary Button" }
    end

    assert_selector ".Polaris-Modal-Dialog__Modal" do
      assert_selector ".Polaris-Modal-Footer" do
        assert_selector ".Polaris-Modal-Footer__FooterContent" do
          assert_selector ".Polaris-Button", text: "Button"
          assert_selector ".Polaris-Button--primary", text: "Primary Button"
        end
      end
    end
  end

  def test_modal_with_secondary_action
    render_inline(Polaris::ModalComponent.new(title: "Modal Title")) do |modal|
      modal.secondary_action() { "Secondary" }
      modal.action() { "Button" }
      modal.action(primary: true) { "Primary Button" }
    end

    assert_selector ".Polaris-Modal-Dialog__Modal" do
      assert_selector ".Polaris-Modal-Footer" do
        assert_selector ".Polaris-Modal-Footer__FooterContent" do
          assert_selector ".Polaris-Button", text: "Secondary"
          assert_selector ".Polaris-Button", text: "Button"
          assert_selector ".Polaris-Button--primary", text: "Primary Button"
        end
      end
    end
  end
end
