# This method is used to make it easier to render the same fields styles
# throughout your app
#
# ## Usage
#
#     field(form.email) { |i| email_input i }
#     field(form.email) { |i| email_input i, autofocus: "true" }
#
# ## Customization
#
# You can customize this method so that fields render like you expect
# For example, you might wrap it in a div with a "field-wrapper" class.
#
#    div class: "field-wrapper"
#      label_for field
#      yield field
#      errors_for fields
#    end
#
# You may also want to have more than one method if you render fields
# differently in different parts of your app, e.g. `compact_field`
class Shared::Field(T) < BaseComponent
  needs field : Avram::FillableField(T)
  needs label : String | Bool = true

  def render
    render_label(@label)

    mount Shared::Input.new(@field) do |input_builder|
      yield input_builder
    end
  end

  def render
    render &.text_input
  end

  private def render_label(label_text : String)
    label_for @field, text: label_text
  end

  private def render_label(label_text : Bool)
    if label_text
      render_label(Wordsmith::Inflector.humanize(@field.name))
    end
  end
end
