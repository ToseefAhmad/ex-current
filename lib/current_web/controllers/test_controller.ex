defmodule CurrentWeb.TestController do
  use CurrentWeb, :controller

  alias Current.Folder
  alias Current.Folder.Test

  action_fallback CurrentWeb.FallbackController

  def index(conn, _params) do
    methods = Folder.list_methods()
    render(conn, "index.json", methods: methods)
  end

  def create(conn, %{"test" => test_params}) do
    with {:ok, %Test{} = test} <- Folder.create_test(test_params) do
      conn
      |> put_status(:created)
    #  |> put_resp_header("location", test_path(conn, :show, test))
      |> render("show.json", test: test)
    end
  end

  def show(conn, %{"id" => id}) do
    test = Folder.get_test!(id)
    render(conn, "show.json", test: test)
  end

  def update(conn, %{"id" => id, "test" => test_params}) do
    test = Folder.get_test!(id)

    with {:ok, %Test{} = test} <- Folder.update_test(test, test_params) do
      render(conn, "show.json", test: test)
    end
  end

  def delete(conn, %{"id" => id}) do
    test = Folder.get_test!(id)
    with {:ok, %Test{}} <- Folder.delete_test(test) do
      send_resp(conn, :no_content, "")
    end
  end

  def task(conn, %{"title" => title}) do
    test = Current.Folder.Task.get_by_title(title)
    render(conn, "show.json", test: test)
  end
    
  
end
