defmodule SherlockBoard.PageController do
  use SherlockBoard.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
