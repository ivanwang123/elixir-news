defmodule SocialMediaV3.CommentRoute do
  use Plug.Router
  alias SocialMediaV3.Utils
  alias SocialMediaV3.Comments

  plug :match
  plug :dispatch

  get "/" do
    conn
    |> put_resp_content_type("application/json")
    |> send_resp(200, Jason.encode!(
        Map.merge(%{comments: Comments.list_comments()},
        Utils.create_alert("Successfully retrieved comments!", false)
      )))
  end

  get "/:id" do
    case Comments.get_comment(id) do
      nil -> (
        conn
        |> put_resp_content_type("application/json")
        |> send_resp(404, Jason.encode!(Utils.create_alert("Comment does not exist", true)))
      )
      comment -> (
        conn
        |> put_resp_content_type("application/json")
        |> send_resp(200, Jason.encode!(
            Map.merge(%{comments: comment},
            Utils.create_alert("Successfully retrieved comment!", false)
          )))
      )
    end
  end

  post "/" do
    comment = conn.body_params
    case Comments.create_comment(comment) do
      {:ok, _} -> (
        conn
        |> put_resp_content_type("application/json")
        |> send_resp(200, Jason.encode!(Utils.create_alert("Successfully created comment!", false)))
      )
      {:error, cs} -> (
        error = Utils.get_error_msg(cs)
        conn
        |> put_resp_content_type("application/json")
        |> send_resp(500, Jason.encode!(Utils.create_alert(error, true)))
      )
    end
  end

  delete "/:id" do
    comment = Comments.get_comment(id)
    if (comment == nil) do
      conn
      |> put_resp_content_type("application/json")
      |> send_resp(500, Jason.encode!(Utils.create_alert("Comment does not exist", true)))
    else
      case Comments.delete_comment(comment) do
        {:ok, _} -> (
          conn
          |> put_resp_content_type("application/json")
          |> send_resp(200, Jason.encode!(Utils.create_alert("Successfully deleted comment!", false)))
        )
        {:error, _} -> (
          conn
          |> put_resp_content_type("application/json")
          |> send_resp(500, Jason.encode!(Utils.create_alert("Unable to delete comment", true)))
        )
      end
    end
  end

  match _ do
    conn
    |> put_resp_content_type("application/json")
    |> send_resp(400, "Route does not exist")
  end
end
