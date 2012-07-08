require "spurs/section/builder_base"
class Spurs::Section::SectionBuilder < Spurs::Section::BuilderBase

  def build_section(title,content)
    r = SecureRandom::hex(5)
    section_id = "section_#{r}"


    header_output = build_header(title)
    body_output = build_body(content)
    content_tag(:div,header_output.concat(body_output), :class => "spurs_section #{section_id}")
  end

  private
  def build_header(title)
    content_tag(:legend,title.to_s.titlecase)
  end

  def build_body(content)
    content_tag(:div, content.html_safe, :class => "section_body")
  end
end