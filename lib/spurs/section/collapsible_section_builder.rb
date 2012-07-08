require "spurs/section/builder_base"

class Spurs::Section::CollapsibleSectionBuilder < Spurs::Section::BuilderBase

  def build_collapsible_section(title,content)
    r = SecureRandom::hex(5)
    section_id = "section_#{r}"


    header_output = build_header(title,section_id)
    body_output = build_body(content)
    content_tag(:div,header_output.concat(body_output), :class => "spurs_collapsible_section #{section_id}")
  end

  private
  def build_header(title,section_id)
    header_content = build_toggle_button(section_id)
    header_content.concat(content_tag(:h4,title))
    content_tag(:div,header_content,:class => "section_header", :onclick => "spurs.sections.toggle($('.#{section_id}'));")
  end
  def build_toggle_button(section_id)
    content_tag(:a, content_tag(:i,"",:class => "icon-chevron-right"), :class => "section_toggle")
  end
  def build_body(content)
    content_tag(:div, content.html_safe, :class => "section_body")
  end
end