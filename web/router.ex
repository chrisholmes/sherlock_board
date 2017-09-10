defmodule SherlockBoard.Router do
  use SherlockBoard.Web, :router

  pipeline :browser do
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", SherlockBoard do
    pipe_through :browser # Use the default browser stack
    get "/events", EventsController, :events
    get "/:dashboard", DashboardsController, :index
  end

  # Other scopes may use custom stacks.
  # scope "/api", SherlockBoard do
  #   pipe_through :api
  # end
end
