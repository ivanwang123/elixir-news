defmodule SocialMediaV3.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias SocialMediaV3.{User, Post, Follow, Comment, Upvote}

  @derive {Jason.Encoder, only: [:id, :first_name, :last_name, :full_name, :email, :about, :inserted_at]}
  schema "users" do
    field :first_name
    field :last_name
    field :full_name
    field :email
    field :password
    field :confirm_password, :string, virtual: true
    field :about

    has_many :posts, Post, foreign_key: :creator_id
    has_many :followers, Follow, foreign_key: :follower_id
    has_many :followings, Follow, foreign_key: :following_id
    has_many :comments, Comment, foreign_key: :creator_id
    has_many :upvotes, Upvote

    timestamps()
  end

  def changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:first_name, :last_name, :email, :password, :confirm_password, :about])
    |> validate_required([:first_name, :last_name, :email, :password, :confirm_password], message: "Please fill out all required fields")
    |> validate_format(:email, ~r/^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+.[a-zA-Z0-9-.]+$/, message: "Invalid email format")
    |> unique_constraint(:email, message: "Email has already been taken.")
    |> compare_confirm_password()
    |> hash_password()
    |> put_change(:full_name, generate_full_name(attrs))
  end

  defp generate_full_name(attrs) do
    "#{Map.get(attrs, "first_name", "")} #{Map.get(attrs, "last_name", "")}"
  end

  defp compare_confirm_password(%Ecto.Changeset{} = changeset) do
    password = Map.get(changeset.changes, :password)
    confirm_password = Map.get(changeset.changes, :confirm_password)

    case password == confirm_password do
      true -> changeset
      false -> add_error(changeset, :not_match, "Confirm password does not match")
    end
  end

  defp hash_password(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{password: password}} ->
        put_change(changeset, :password, Pbkdf2.hash_pwd_salt(password))
      _ -> changeset
    end
  end
end
