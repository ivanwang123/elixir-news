defmodule SocialMediaV3.Repo.Migrations.CreatePosts do
  use Ecto.Migration

  def change do
    create table(:posts) do
      add :title, :string, null: false
      add :link, :string, null: false
      add :tag, :string

      add :creator_id, references(:users, on_delete: :delete_all)

      timestamps()
    end
  end
end
