defmodule SherlockBoard.DashboardView do
  use SherlockBoard.Web, :view

  def render("404.html", _assigns) do
    "Dashboard not found"
  end
end
