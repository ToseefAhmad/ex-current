defmodule Current.Admin.User do
  use Ecto.Schema
  import Ecto.Changeset

  import Comeonin.Bcrypt


  schema "users" do
    field :password, :string
    field :username, :string

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:username, :password])
    |> validate_required([:username, :password])
    |> unique_constraint(:username)
    |> validate_confirmation(:password, message: "Password not match")
    |> hash_password
  end

  defp hash_password(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{password: password}}
        ->
          put_change(changeset, :password, hashpwsalt(password))
      _ ->
          changeset
    end
  end


end
