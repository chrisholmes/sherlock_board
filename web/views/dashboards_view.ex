defmodule SherlockBoard.DashboardsView do
  use SherlockBoard.Web, :view
  require Logger

  @dashboard_directory Application.get_env(:sherlock_board, :directory)
  |> Path.join("dashboards")

  def render(name, _assigns) do
    name |> fetch |> render_dashboard
  end

  def render_dashboard(:error) do
    dashboard_names = Map.keys(dashboards)
    render_template("not_found.html", %{dashboards: dashboard_names})
  end

  def render_dashboard({:ok, dashboard}) do
    {:safe,  dashboard}
  end

  def fetch(name) do
    Map.fetch(dashboards, name)
  end

  def dashboards do
    @dashboard_directory
    |> File.ls!
    |> Enum.map(fn(path) -> {path, File.read!(Path.join(@dashboard_directory, path))} end)
    |> Enum.into(%{})
  end
end
