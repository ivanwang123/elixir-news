defmodule SocialMediaV3.Schema do
  use Absinthe.Schema
  # import_types SocialMediaV3.PostType
  # import_types SocialMediaV3.UserType

  # query do
  #   import_fields :post_queries
  #   import_fields :user_queries
  # end

  object :post do
    field :id, :id
    field :title, :string
    field :link, :string
    field :creator, :user
  end

  object :user do
    field :id, :id
    field :first_name, :string
    field :last_name, :string
    field :full_name, :string
    field :email, :string
    field :about, :string
    field :posts, list_of(:post)
  end

  query do
  # object :user_queries do
    field :user, :user do
      arg :id, non_null(:id)
      resolve(fn %{id: id}, _ ->
        SocialMediaV3.Users.get_user(id)
      end)
    end
    field :users, list_of(:user) do
      resolve &SocialMediaV3.Users.list_users/3
    end
  # end

  # object :post_queries do
    field :post, :post do
      arg :id, non_null(:id)
      resolve(fn %{id: id}, _ ->
        SocialMediaV3.Posts.get_post(id)
      end)
    end
    field :posts, list_of(:post) do
      resolve &SocialMediaV3.Posts.list_posts/3
    end
  # end
  end
end
