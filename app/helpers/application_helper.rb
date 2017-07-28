module ApplicationHelper
  def current_user?(user)
    user == current_user
  end
  def sortable(column, title = nil, flavor)
    title ||= column.titleize
    css_class = column == sort_column ? "current #{sort_direction}" : nil
    direction = sort_direction == "asc" ? "desc" : "asc"
    link_to title, {:sort => column, :direction => direction, :flavor => flavor}, {:class => css_class}
  end
end
