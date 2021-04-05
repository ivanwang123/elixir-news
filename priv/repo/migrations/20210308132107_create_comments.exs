defmodule SocialMediaV3.Repo.Migrations.CreateComments do
  use Ecto.Migration

  def change do
    create table(:comments) do
      add :message, :text, null: false

      add :creator_id, references(:users, on_delete: :delete_all)
      add :post_id, references(:posts, on_delete: :delete_all)

      timestamps()
    end
  end
end
