module ApplicationHelper

  def draw_svg(id_name, svg_name, speed = 200)
    content_tag :object, id: id_name, data: asset_path("#{svg_name}.svg"), type: "image/svg+xml" do
      javascript_tag("new Vivus('#{id_name}', {duration: #{speed.to_i}});")
    end.html_safe
  end

end
