defmodule Current.Repo.Migrations.CreateMethods do
  use Ecto.Migration

  def change do
    create table(:methods) do
      add :title, :string
      add :description, :string

      timestamps()
    end

  end
end
