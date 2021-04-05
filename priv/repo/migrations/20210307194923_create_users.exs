defmodule SocialMediaV3.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :first_name, :string, null: false
      add :last_name, :string, null: false
      add :full_name, :string, null: false
      add :email, :string, null: false
      add :password, :string, null: false
      add :about, :text

      timestamps()
    end

    create unique_index(:users, [:email])
  end
end
