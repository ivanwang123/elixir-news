defmodule SocialMediaV3.Router do
  use Plug.Router
  alias SocialMediaV3.Utils

  plug Plug.Logger

  plug CORSPlug, origin: ["http://localhost:3000"]

  plug :match
  # plug Plug.Parsers, parsers: [:json], pass: ["application/json"], json_decoder: Jason
  plug Plug.Parsers,
    parsers: [:urlencoded, :multipart, :json, Absinthe.Plug.Parser],
    pass: ["*/*"],
    json_decoder: Jason
  # plug Absinthe.Plug,
  #   schema: SocialMediaV3.Schema
  plug Plug.Session, store: :ets, key: "social_media_v3_session", table: :session
  plug :dispatch

  forward "/users", to: SocialMediaV3.UserRoute
  forward "/posts", to: SocialMediaV3.PostRoute
  forward "/comments", to: SocialMediaV3.CommentRoute
  forward "/upvotes", to: SocialMediaV3.UpvoteRoute
  forward "/follows", to: SocialMediaV3.FollowRoute
  forward "/graphiql", to: Absinthe.Plug.GraphiQL, schema: SocialMediaV3.Schema

  match _ do
    conn
    |> put_resp_content_type("application/json")
    |> send_resp(400, Jason.encode!(Utils.create_alert("Route does not exist", true)))
  end
end
