module ApplicationHelper

  def draw_svg(id_name, svg_name)
    content_tag :object, id: id_name, data: asset_path(svg_name), type: "image/svg+xml" do
      javascript_tag("new Vivus('#{id_name}', {duration: 200});")
    end.html_safe
  end

end
