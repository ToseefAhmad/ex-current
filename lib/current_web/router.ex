defmodule CurrentWeb.Router do
  use CurrentWeb, :router

  pipeline :api do
    plug :trim_upcase
    plug :accepts, ["json"]
  end

  scope "/api", CurrentWeb do
    pipe_through :api

    post "/methods", TestController, :create
    get "/methods", TestController, :index
    get "/methods/:id", TestController, :show
    
    get "/call/:title", TestController, :task

    resources "/users", UserController, except: [:new, :edit]

  end
  defp trim_upcase(conn, param) do
    conn
    |> String.trim("\n#{param}\n")
    |> String.upcase()
  end
end
