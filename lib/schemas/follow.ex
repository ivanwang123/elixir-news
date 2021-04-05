defmodule SocialMediaV3.Follow do
  use Ecto.Schema
  import Ecto.Changeset
  alias SocialMediaV3.{User, Follow}

  @derive {Jason.Encoder, only: [:id, :follower_id, :following_id]}
  schema "follows" do
    belongs_to :follower, User
    belongs_to :following, User
  end

  def changeset(%Follow{} = follow, attrs) do
    follow
    |> cast(attrs, [:follower_id, :following_id])
    |> validate_required([:follower_id, :following_id], message: "Please fill out all required fields")
    |> unique_constraint([:follower_id, :following_id], message: "Already following that user")
    |> foreign_key_constraint(:follower_id, message: "User does not exist")
    |> foreign_key_constraint(:following_id, message: "User does not exist")
    |> validate_not_self()
  end

  def validate_not_self(%Ecto.Changeset{} = changeset) do
    follower_id = Map.get(changeset.changes, :follower_id)
    following_id = Map.get(changeset.changes, :following_id)

    case follower_id == following_id do
      true -> add_error(changeset, :not_self, "Can not follow yourself")
      false -> changeset
    end
  end
end
