module GeneratePasswordHelper

  def link_to_generate_password(name, f)

    html = []

    html << content_tag(:button, :type => :button, :class => ['btn', 'btn-warning', 'btn-mini'], :onclick => "generate_password(this)") do
      "Generate"
    end.html_safe

    html.join.html_safe
  end

end
