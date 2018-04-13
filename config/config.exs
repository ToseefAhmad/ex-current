# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :current,
  ecto_repos: [Current.Repo]

# Configures the endpoint
config :current, CurrentWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "5NvDd2Xa89w3Y56aszBMBBkPXDOEkzFrXEaDPicJh2nrITqRhm1ym7SEyrjHXOZs",
  render_errors: [view: CurrentWeb.ErrorView, accepts: ~w(json)],
  pubsub: [name: Current.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

  # Guardian config
config :current, CurrentWeb.Guardian,
issuer: "current",
secret_key: "v3TsZSKiQ5eTVIIIwUSKa0zrQZVT99TOi8rdoUV8XSz7cZF2RgVfZ6/N6z5fPhGp"

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
