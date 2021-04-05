defmodule SocialMediaV3.Comment do
  use Ecto.Schema
  import Ecto.Changeset
  alias SocialMediaV3.{User, Post, Comment}

  @derive {Jason.Encoder, only: [:id, :message, :post_id, :creator_id]}
  schema "comments" do
    field :message

    belongs_to :post, Post
    belongs_to :creator, User

    timestamps()
  end

  def changeset(%Comment{} = comment, attrs) do
    comment
    |> cast(attrs, [:message, :post_id, :creator_id])
    |> validate_required([:message, :post_id, :creator_id], message: "Please fill out all required fields")
    |> foreign_key_constraint(:post_id, message: "Post does not exist")
    |> foreign_key_constraint(:creator_id, message: "User does not exist")
  end
end
