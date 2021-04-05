defmodule SocialMediaV3.UpvoteRoute do
  use Plug.Router
  alias SocialMediaV3.Utils
  alias SocialMediaV3.{Upvotes, Upvote}

  plug :match
  plug :dispatch

  post "/" do
    upvote = conn.body_params
    case Upvotes.create_upvote(upvote) do
      {:ok, _} -> (
        conn
        |> put_resp_content_type("application/json")
        |> send_resp(200, Jason.encode!(Utils.create_alert("Successfully upvoted post!", false)))
      )
      {:error, cs} -> (
        error = Utils.get_error_msg(cs)
        conn
        |> put_resp_content_type("application/json")
        |> send_resp(500, Jason.encode!(Utils.create_alert(error, true)))
      )
    end
  end

  post "/unvote" do
    case Upvotes.delete_upvote(conn.body_params) do
      {:ok, _} -> (
        conn
        |> put_resp_content_type("application/json")
        |> send_resp(200, Jason.encode!(Utils.create_alert("Successfully unvoted post!", false)))
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
    |> send_resp(400, Jason.encode!(Utils.create_alert("Route does not exist", true)))
  end
end
