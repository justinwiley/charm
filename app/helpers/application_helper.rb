# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  # easily add a page title, see layouts/application.rhtml
  def title(page_title)
    content_for(:title) { page_title }
  end
end
