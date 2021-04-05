defmodule SocialMediaV3.PostType do
  use Absinthe.Schema.Notation
  # import_types SocialMediaV3.UserType

  # object :post do
  #   field :id, :id
  #   field :title, :string
  #   field :link, :string
  #   field :creator, :user
  # end

  # object :user do
  #   field :id, :id
  #   field :first_name, :string
  #   field :last_name, :string
  #   field :full_name, :string
  #   field :email, :string
  #   field :about, :string
  #   field :posts, list_of(:post)
  # end

  # object :user_queries do
  #   field :user, :user do
  #     arg :id, non_null(:id)
  #     resolve(fn %{id: id}, _ ->
  #       SocialMediaV3.Users.get_user(id)
  #     end)
  #   end
  #   field :users, list_of(:user) do
  #     resolve &SocialMediaV3.Users.list_users/3
  #   end
  # end

  # object :post_queries do
  #   field :posts, list_of(:post) do
  #     resolve &SocialMediaV3.Posts.list_posts/3
  #   end
  # end
end
