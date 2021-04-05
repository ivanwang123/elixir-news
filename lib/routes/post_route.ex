defmodule SocialMediaV3.PostRoute do
  use Plug.Router
  alias SocialMediaV3.Utils
  alias SocialMediaV3.Posts

  plug :match
  plug :dispatch

  get "/" do
    conn
    |> put_resp_content_type("application/json")
    |> send_resp(200, Jason.encode!(
        Map.merge(%{posts: Posts.list_posts()},
        Utils.create_alert("Successfully retrieved posts!", false)
      )))
  end

  get "/top" do
    current_user = conn |> fetch_session() |> get_session(:current_user)
    conn
    |> put_resp_content_type("application/json")
    |> send_resp(200, Jason.encode!(
        Map.merge(%{posts: Posts.get_posts_by_score(current_user)},
        Utils.create_alert("Successfully retrieved posts!", false)
      )))
  end

  get "/new" do
    current_user = conn |> fetch_session() |> get_session(:current_user)
    conn
    |> put_resp_content_type("application/json")
    |> send_resp(200, Jason.encode!(
        Map.merge(%{posts: Posts.get_posts_by_time(current_user)},
        Utils.create_alert("Successfully retrieved posts!", false)
      )))
  end

  get "/tag/:tag" do
    current_user = conn |> fetch_session() |> get_session(:current_user)
    conn
    |> put_resp_content_type("application/json")
    |> send_resp(200, Jason.encode!(
        Map.merge(%{posts: Posts.get_posts_by_tag(current_user, tag)},
        Utils.create_alert("Successfully retrieved posts!", false)
      )))
  end

  get "/:id" do
    case Posts.get_post(id) do
      nil -> (
        conn
        |> put_resp_content_type("application/json")
        |> send_resp(404, Jason.encode!(Utils.create_alert("Post does not exist", true)))
      )
      post -> (
        conn
        |> put_resp_content_type("application/json")
        |> send_resp(200, Jason.encode!(
            Map.merge(%{post: post},
            Utils.create_alert("Successfully retrieved post!", false)
          )))
      )
    end
  end

  post "/" do
    post = conn.body_params
    case Posts.create_post(post) do
      {:ok, _} -> (
        conn
        |> put_resp_content_type("application/json")
        |> send_resp(200, Jason.encode!(Utils.create_alert("Successfully created post!", false)))
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
    post = Posts.get_post(id)
    if (post == nil) do
      conn
      |> put_resp_content_type("application/json")
      |> send_resp(500, Jason.encode!(Utils.create_alert("Post does not exist", true)))
    else
      case Posts.delete_post(post) do
        {:ok, _} -> (
          conn
          |> put_resp_content_type("application/json")
          |> send_resp(200, Jason.encode!(Utils.create_alert("Successfully deleted post!", false)))
        )
        {:error, _} -> (
          conn
          |> put_resp_content_type("application/json")
          |> send_resp(500, Jason.encode!(Utils.create_alert("Unable to delete post", true)))
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
