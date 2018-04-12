defmodule Current.FolderTest do
  use Current.DataCase

  alias Current.Folder

  describe "methods" do
    alias Current.Folder.Test

    @valid_attrs %{description: "some description", title: "some title"}
    @update_attrs %{description: "some updated description", title: "some updated title"}
    @invalid_attrs %{description: nil, title: nil}

    def test_fixture(attrs \\ %{}) do
      {:ok, test} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Folder.create_test()

      test
    end

    test "list_methods/0 returns all methods" do
      test = test_fixture()
      assert Folder.list_methods() == [test]
    end

    test "get_test!/1 returns the test with given id" do
      test = test_fixture()
      assert Folder.get_test!(test.id) == test
    end

    test "create_test/1 with valid data creates a test" do
      assert {:ok, %Test{} = test} = Folder.create_test(@valid_attrs)
      assert test.description == "some description"
      assert test.title == "some title"
    end

    test "create_test/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Folder.create_test(@invalid_attrs)
    end

    test "update_test/2 with valid data updates the test" do
      test = test_fixture()
      assert {:ok, test} = Folder.update_test(test, @update_attrs)
      assert %Test{} = test
      assert test.description == "some updated description"
      assert test.title == "some updated title"
    end

    test "update_test/2 with invalid data returns error changeset" do
      test = test_fixture()
      assert {:error, %Ecto.Changeset{}} = Folder.update_test(test, @invalid_attrs)
      assert test == Folder.get_test!(test.id)
    end

    test "delete_test/1 deletes the test" do
      test = test_fixture()
      assert {:ok, %Test{}} = Folder.delete_test(test)
      assert_raise Ecto.NoResultsError, fn -> Folder.get_test!(test.id) end
    end

    test "change_test/1 returns a test changeset" do
      test = test_fixture()
      assert %Ecto.Changeset{} = Folder.change_test(test)
    end
  end
end
