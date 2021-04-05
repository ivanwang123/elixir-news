defmodule SocialMediaV3.UserRoute do
  use Plug.Router
  alias SocialMediaV3.Users
  alias SocialMediaV3.Utils

  plug :match
  plug :dispatch

  get "/" do
    conn
    |> put_resp_content_type("application/json")
    |> send_resp(200, Jason.encode!(
        # Map.merge(%{users: Users.list_users()},
        Utils.create_alert("Successfully retrieved users!", false)
      # )
      ))
  end

  get "/me" do
    cur_user = conn |> fetch_session() |> get_session(:current_user)
    if cur_user == nil do
      conn
      |> put_resp_content_type("application/json")
      |> send_resp(404, Jason.encode!(Utils.create_alert("User not logged in", true)))
    else
      case Users.get_user(cur_user) do
        nil -> (
          conn
          |> put_resp_content_type("application/json")
          |> send_resp(404, Jason.encode!(Utils.create_alert("User does not exist", true)))
        )
        user -> (
          conn
          |> put_resp_content_type("application/json")
          |> send_resp(200, Jason.encode!(
              Map.merge(%{user: user},
              Utils.create_alert("Successfully retrieved user!", false)
            )))
        )
      end
    end
  end

  get "/:id" do
    case Users.get_user(id) do
      nil -> (
        conn
        |> put_resp_content_type("application/json")
        |> send_resp(404, Jason.encode!(Utils.create_alert("User does not exist", true)))
      )
      user -> (
        conn
        |> put_resp_content_type("application/json")
        |> send_resp(200, Jason.encode!(
            Map.merge(%{user: user},
            Utils.create_alert("Successfully retrieved user!", false)
          )))
      )
    end
  end

  post "/register" do
    user = conn.body_params
    case Users.create_user(user) do
      {:ok, _} -> (
        conn
        |> put_resp_content_type("application/json")
        |> send_resp(200, Jason.encode!(Utils.create_alert("Successfully registered user!", false)))
      )
      {:error, cs} -> (
        error = Utils.get_error_msg(cs)
        conn
        |> put_resp_content_type("application/json")
        |> send_resp(500, Jason.encode!(Utils.create_alert(error, true)))
      )
    end
  end

  post "/login" do
    credentials = conn.body_params
    case Users.login_user(credentials) do
      {:ok, user} -> (
        conn
        |> fetch_session()
        |> put_session(:current_user, user.id)
        |> put_resp_content_type("application/json")
        |> send_resp(200, Jason.encode!(
            Map.merge(%{user: user},
            Utils.create_alert("Successfully logged in user!", false))
          ))
      )
      {:error, msg} -> (
        conn
        |> put_resp_content_type("application/json")
        |> send_resp(500, Jason.encode!(Utils.create_alert(msg, true)))
      )
    end
  end

  post "/logout" do
    conn
    |> fetch_session()
    |> delete_session(:current_user)
    |> put_resp_content_type("application/json")
    |> send_resp(200, Jason.encode!(Utils.create_alert("Successfully logged out user!", true)))
  end

  delete "/:id" do
    user = Users.get_user(id)
    if (user == nil) do
      conn
      |> put_resp_content_type("application/json")
      |> send_resp(500, Jason.encode!(Utils.create_alert("User does not exist", true)))
    else
      case Users.delete_user(user) do
        {:ok, _} -> (
          conn
          |> put_resp_content_type("application/json")
          |> send_resp(200, Jason.encode!(Utils.create_alert("Successfully deleted user!", false)))
        )
        {:error, _} -> (
          conn
          |> put_resp_content_type("application/json")
          |> send_resp(500, Jason.encode!(Utils.create_alert("Unable to delete user", true)))
        )
      end
    end
  end

  match _ do
    conn
    |> put_resp_content_type("application/json")
    |> send_resp(400, Jason.encode!(Utils.create_alert("Route does not exist", true)))
  end
end
