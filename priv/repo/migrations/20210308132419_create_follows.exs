defmodule SocialMediaV3.Repo.Migrations.CreateFollowers do
  use Ecto.Migration

  def change do
    create table(:follows) do
      add :follower_id, references(:users, on_delete: :delete_all)
      add :following_id, references(:users, on_delete: :delete_all)
    end

    create unique_index(:follows, [:follower_id, :following_id])
  end
end
