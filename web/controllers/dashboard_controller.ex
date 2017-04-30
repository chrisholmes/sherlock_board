defmodule SherlockBoard.DashboardController do
  use SherlockBoard.Web, :controller

  def index(conn, %{"dashboard" => dashboard}) do
    try do
      render conn, "#{dashboard}.html"
    rescue Phoenix.Template.UndefinedError ->
      render conn,"404.html"
    end
  end
end
