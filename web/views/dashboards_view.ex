defmodule SherlockBoard.DashboardsView do
  use SherlockBoard.Web, :dashboard_view

  def render("404.html", _assigns) do
    "Dashboard not found"
  end
end
