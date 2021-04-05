defmodule SocialMediaV3.Repo do
  use Ecto.Repo,
    otp_app: :social_media_v3,
    adapter: Ecto.Adapters.Postgres
end
