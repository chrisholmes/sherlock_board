defmodule SherlockBoard.DashboardsController do
  use SherlockBoard.Web, :controller

  def index(conn, %{"dashboard" => dashboard}) do
    render conn,  "#{dashboard}.html"
  end
end
