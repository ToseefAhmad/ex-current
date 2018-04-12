defmodule CurrentWeb.Router do
  use CurrentWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", CurrentWeb do
    pipe_through :api

    post "/methods", TestController, :create
    get "/methods", TestController, :index
    get "/methods/:id", TestController, :show
  end
end
