defmodule CurrentWeb.TestControllerTest do
  use CurrentWeb.ConnCase

  alias Current.Folder
  alias Current.Folder.Test

  @create_attrs %{description: "some description", title: "some title"}
  @update_attrs %{description: "some updated description", title: "some updated title"}
  @invalid_attrs %{description: nil, title: nil}

  def fixture(:test) do
    {:ok, test} = Folder.create_test(@create_attrs)
    test
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all methods", %{conn: conn} do
      conn = get conn, test_path(conn, :index)
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create test" do
    test "renders test when data is valid", %{conn: conn} do
      conn = post conn, test_path(conn, :create), test: @create_attrs
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get conn, test_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "description" => "some description",
        "title" => "some title"}
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, test_path(conn, :create), test: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update test" do
    setup [:create_test]

    test "renders test when data is valid", %{conn: conn, test: %Test{id: id} = test} do
      conn = put conn, test_path(conn, :update, test), test: @update_attrs
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get conn, test_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "description" => "some updated description",
        "title" => "some updated title"}
    end

    test "renders errors when data is invalid", %{conn: conn, test: test} do
      conn = put conn, test_path(conn, :update, test), test: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete test" do
    setup [:create_test]

    test "deletes chosen test", %{conn: conn, test: test} do
      conn = delete conn, test_path(conn, :delete, test)
      assert response(conn, 204)
      assert_error_sent 404, fn ->
        get conn, test_path(conn, :show, test)
      end
    end
  end

  defp create_test(_) do
    test = fixture(:test)
    {:ok, test: test}
  end
end
