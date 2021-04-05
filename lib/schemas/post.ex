defmodule SocialMediaV3.Post do
  use Ecto.Schema
  import Ecto.Changeset
  alias SocialMediaV3.{User, Post, Comment, Upvote}

  @derive {Jason.Encoder, only: [:id, :title, :link, :creator_id, :total_upvotes, :did_upvote, :inserted_at]}
  schema "posts" do
    field :title
    field :link
    field :tag
    field :total_upvotes, :integer, virtual: true, default: 0
    field :did_upvote, :boolean, virtual: true, default: false

    has_many :comments, Comment
    has_many :upvotes, Upvote
    belongs_to :creator, User

    timestamps()
  end

  def changeset(%Post{} = post, attrs) do
    post
    |> cast(attrs, [:title, :link, :tag, :creator_id])
    |> validate_required([:title, :link, :creator_id], message: "Please fill out all required fields")
    |> foreign_key_constraint(:creator_id, message: "User does not exist")
    |> put_change(:tag, generate_tag(attrs))
  end

  def generate_tag(attrs) do
    if Map.has_key?(attrs, "title") do
      title = Map.get(attrs, "title")

      cond do
        String.slice(title, 0..7) == "Show EN:" -> "show"
        String.slice(title, 0..6) == "Ask EN:" -> "ask"
        String.slice(title, 0..7) == "Hire EN:" -> "job"
        true -> ""
      end
    end
  end
end
