defmodule SocialMediaV3.Comments do
  import Ecto.Query, warn: false
  alias SocialMediaV3.Repo
  alias SocialMediaV3.Comment

  def list_comments do
    Comment
    |> order_by(desc: :inserted_at)
    |> Repo.all()
  end

  def get_comment(id) do
    Repo.get(Comment, id)
  end

  def create_comment(attrs \\ %{}) do
    %Comment{}
    |> Comment.changeset(attrs)
    |> Repo.insert()
  end

  def update_comment(%Comment{} = comment, attrs) do
    comment
    |> Comment.changeset(attrs)
    |> Repo.update()
  end

  def delete_comment(%Comment{} = comment) do
    Repo.delete(comment)
  end
end
