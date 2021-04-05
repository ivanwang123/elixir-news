defmodule SocialMediaV3.Users do
  import Ecto.Query, warn: false
  alias SocialMediaV3.Repo
  alias SocialMediaV3.User

  def list_users(_parent, _args, _resolution) do
    users = User
    |> order_by(desc: :inserted_at)
    |> Repo.all()
    {:ok, users}
  end

  def get_user(id) do
    user = Repo.get!(User, id)
    |> Repo.preload(:posts)
    {:ok, user}
  end

  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end

  def login_user(%{"email" => email, "password" => password}) do
    user = Repo.get_by(User, email: email)
    if user != nil do
      if Pbkdf2.verify_pass(password, user.password) do
        {:ok, user}
      else
        {:error, "Invalid password"}
      end
    else
      {:error, "No account with that email"}
    end
  end
  def login_user(_) do
    {:error, "Missing credentials"}
  end

  def update_user(%User{} = user, attrs) do
    user
    |> User.changeset(attrs)
    |> Repo.update()
  end

  def delete_user(%User{} = user) do
    Repo.delete(user)
  end
end
