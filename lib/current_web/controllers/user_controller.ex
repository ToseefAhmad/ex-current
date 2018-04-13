defmodule CurrentWeb.UserController do
  use CurrentWeb, :controller

  alias Current.Admin
  alias Current.Admin.User
  alias CurrentWeb.Guardian
  alias Current.Admin.Auth

  action_fallback CurrentWeb.FallbackController

  def index(conn, _params) do
    users = Admin.list_users()
    render(conn, "index.json", users: users)
  end

  def create(conn, %{"user" => user_params}) do
    with {:ok, %User{} = user} <- Admin.create_user(user_params),
    {:ok, token, _claims} <- Guardian.encode_and_sign(user)  do
      conn
      |> put_status(:created)
      #|> put_resp_header("location", user_path(conn, :show, user))
      |> render("jwt.json", jwt: token)
    end
  end

  def session(conn, %{"username" => username, "password" => password}) do
    case Auth.token_signin(username, password) do
      {:ok, token, _claims} -> 
        conn
        |> render("jwt.json", jwt: token)
        _ ->
          {:error, :unauthorized}
    end
  end



  def show(conn, %{"id" => id}) do
    user = Admin.get_user!(id)
    render(conn, "show.json", user: user)
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    user = Admin.get_user!(id)

    with {:ok, %User{} = user} <- Admin.update_user(user, user_params) do
      render(conn, "show.json", user: user)
    end
  end

  def delete(conn, %{"id" => id}) do
    user = Admin.get_user!(id)
    with {:ok, %User{}} <- Admin.delete_user(user) do
      send_resp(conn, :no_content, "")
    end
  end
end
