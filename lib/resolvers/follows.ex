defmodule SocialMediaV3.Follows do
  import Ecto.Query, warn: false
  alias SocialMediaV3.Repo
  alias SocialMediaV3.Follow

  def list_follows do
    Follow
    |> order_by(desc: :inserted_at)
    |> Repo.all()
  end

  def get_follow(id) do
    Repo.get(Follow, id)
  end

  def create_follow(attrs \\ %{}) do
    %Follow{}
    |> Follow.changeset(attrs)
    |> Repo.insert()
  end

  def update_follow(%Follow{} = follow, attrs) do
    follow
    |> Follow.changeset(attrs)
    |> Repo.update()
  end

  def delete_follow(%Follow{} = follow) do
    Repo.delete(follow)
  end
end
