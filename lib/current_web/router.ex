defmodule CurrentWeb.Router do
  use CurrentWeb, :router

  pipeline :api do
   #plug :trim_upcase
    plug :accepts, ["json"]
  end

  pipeline :ensure_user do
    plug Current.Admin.AuthPipeline
  end

  scope "/api", CurrentWeb do
    pipe_through :api

    post "/methods", TestController, :create
    get "/methods", TestController, :index
    get "/methods/:id", TestController, :show
    get "/call/:title", TestController, :task

  end

  scope "/api", CurrentWeb do
    pipe_through [:api, :ensure_user]

    post "/users", UserController, :create
    post "/signin", UserController, :session
  end

  #defp trim_upcase(conn, param) do
   # conn
    #|> String.trim("\n#{param}\n")
    #|> String.upcase()
  #end
  
end
