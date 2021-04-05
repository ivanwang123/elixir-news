defmodule SocialMediaV3.UserType do
  use Absinthe.Schema.Notation
  # import_types SocialMediaV3.PostType

  # object :user_type do
  #   field :first_name, :string
  #   field :last_name, :string
  #   field :full_name, :string
  #   field :email, :string
  #   field :about, :string
  #   # field :posts, list_of(:post)
  # end

  # object :user_queries do
  #   field :users, list_of(:user_type) do
  #     resolve &SocialMediaV3.Users.list_users/3
  #   end
  # end
end
