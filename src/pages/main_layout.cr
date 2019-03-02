abstract class MainLayout
  include Lucky::HTMLPage

  # 'needs current_user : User' makes it so that the current_user
  # is always required for pages using MainLayout
  needs current_user : User

  abstract def content
  abstract def page_title

  # This is the default page title. If you remove this method the compiler will
  # help you remember to include a `page_title` method for every page because
  # we used `abstract def page_title` above. Alternatively, you can leave this
  # here and override the `page_title` class only on the pages you care about.
  def page_title
    "Welcome"
  end

  def render
    html_doctype

    html lang: "en" do
      mount Shared::LayoutHead, page_title: page_title, context: @context

      body do
        mount Shared::FlashMessages, @context.flash
        render_signed_in_user
        content
      end
    end
  end

  private def render_signed_in_user
    text @current_user.email
    text " - "
    link "Sign out", to: SignIns::Delete, flow_id: "sign-out-button"
  end
end
