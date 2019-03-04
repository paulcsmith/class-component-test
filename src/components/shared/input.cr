class Shared::Input(T) < BaseComponent
  needs field : Avram::FillableField(T)

  def render
    with_defaults field: @field do |input_builder|
      yield input_builder
    end

    mount Shared::FieldErrors.new(@field)
  end
end
