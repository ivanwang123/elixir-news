defmodule SocialMediaV3.Repo.Migrations.CreateUpvotes do
  use Ecto.Migration

  def change do
    create table(:upvotes) do
      add :post_id, references(:posts, on_delete: :delete_all)
      add :user_id, references(:users, on_delete: :delete_all)
    end

    create unique_index(:upvotes, [:post_id, :user_id])
  end
end
