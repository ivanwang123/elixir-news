defmodule SocialMediaV3.Upvote do
  use Ecto.Schema
  import Ecto.Changeset
  alias SocialMediaV3.{User, Post, Upvote}

  @derive {Jason.Encoder, only: [:id, :post_id, :user_id]}
  schema "upvotes" do
    belongs_to :post, Post
    belongs_to :user, User
  end

  def changeset(%Upvote{} = upvote, attrs) do
    upvote
    |> cast(attrs, [:post_id, :user_id])
    |> validate_required([:post_id, :user_id], message: "Please fill out all required fields")
    |> foreign_key_constraint(:post_id, message: "Post does not exist")
    |> foreign_key_constraint(:user_id, message: "User does not exist")
    |> unique_constraint([:post_id, :user_id], message: "Already upvoted that post")
  end
end
