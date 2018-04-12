defmodule Current.Folder.Test do
  use Ecto.Schema
  


  schema "methods" do
    field :description, :string
    field :title, :string

    timestamps()
  end

  @doc false
  def changeset(test, attrs) do
    # Ecto changeset function without importing Ecto macro
    test
    |> Ecto.Changeset.cast(attrs, [:title, :description])
    |> Ecto.Changeset.validate_required([:title, :description])
  end
end
