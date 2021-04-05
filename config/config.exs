use Mix.Config

config :social_media_v3, :ecto_repos, [SocialMediaV3.Repo]

import_config "#{Mix.env}.exs"
