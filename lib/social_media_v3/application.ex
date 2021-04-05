defmodule SocialMediaV3.Application do
  use Application

  @impl true
  def start(_type, _args) do
    children = [
      SocialMediaV3.Repo,
      Plug.Cowboy.child_spec(
        scheme: :http,
        plug: SocialMediaV3.Router,
        options: [port: 4000]
      )
    ]

    :ets.new(:session, [:named_table, :public, read_concurrency: true])

    opts = [strategy: :one_for_one, name: SocialMediaV3.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
