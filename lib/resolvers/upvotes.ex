defmodule SocialMediaV3.Upvotes do
  import Ecto.Query, warn: false
  alias SocialMediaV3.Repo
  alias SocialMediaV3.Upvote

  def create_upvote(attrs \\ %{}) do
    %Upvote{}
    |> Upvote.changeset(attrs)
    |> Repo.insert()
  end

  def delete_upvote(%{"post_id" => post_id, "user_id" => user_id}) do
    Repo.one(from u in Upvote, where: u.post_id == ^post_id and u.user_id == ^user_id)
    |> Repo.delete()
  end

  def delete_upvote(%Upvote{} = upvote) do
    Repo.delete(upvote)
  end
end
