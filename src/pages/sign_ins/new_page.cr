class SignIns::NewPage < AuthLayout
  needs form : SignInForm
  @priv_meth = "WUT"

  def content
    h1 "Sign In"
    render_sign_in_form(@form)
  end

  private def render_sign_in_form(f)
    form_for SignIns::Create do
      sign_in_fields(f)
      submit "Sign In", flow_id: "sign-in-button"
    end
    link "Reset password", to: PasswordResetRequests::New
    text " | "
    link "Sign up", to: SignUps::New
  end

  private def sign_in_fields(f)
    mount Shared::Field, f.email, &.email_input(autofocus: "true")
    mount Shared::Field, f.password, &.password_input(autofocus: "true")
  end
end
