defmodule Current.Folder.Test do
  use Ecto.Schema
  


  schema "methods" do
    field :description, :string
    field :title, :string

    timestamps()
  end

  @doc false
  def changeset(test, attrs) do
    # Ecto changeset function without importing Ecto macros
    test
    |> Ecto.Changeset.cast(attrs, [:title, :description])
    |> Ecto.Changeset.validate_required([:title, :description])

     #For trim spacing in title
     |> Ecto.Changeset.update_change(:title, &String.trim/1)
    #Thirs task for vaildating field must contain in title1, title2 and title3
    |> Ecto.Changeset.validate_inclusion(:title, ["title1", "title2", "title3"], message: "Please use title1, title2 or title3")
   
  end

end
