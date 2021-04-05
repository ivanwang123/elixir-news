defmodule SocialMediaV3.FollowRoute do
  use Plug.Router
  alias SocialMediaV3.Utils
  alias SocialMediaV3.Follows

  plug :match
  plug :dispatch

  post "/" do
    follow = conn.body_params
    case Follows.create_follow(follow) do
      {:ok, _} -> (
        conn
        |> put_resp_content_type("application/json")
        |> send_resp(200, Jason.encode!(Utils.create_alert("Successfully followed user!", false)))
      )
      {:error, cs} -> (
        error = Utils.get_error_msg(cs)

        conn
        |> put_resp_content_type("application/json")
        |> send_resp(500, Jason.encode!(Utils.create_alert(error, true)))
      )
    end
  end

  match _ do
    conn
    |> put_resp_content_type("application/json")
    |> send_resp(400, "Route does not exist")
  end
end
