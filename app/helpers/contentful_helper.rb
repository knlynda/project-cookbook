# frozen_string_literal: true

module ContentfulHelper
  def render_html_from_markdown(markdown)
    renderer = ::Redcarpet::Markdown.new(::Redcarpet::Render::HTML, autolink: true)
    renderer.render(markdown).html_safe
  end
end
