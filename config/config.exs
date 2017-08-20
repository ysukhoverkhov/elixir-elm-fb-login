# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :login,
  ecto_repos: [Login.Repo]

# Configures the endpoint
config :login, LoginWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "8hpRS9NWXDZkg6sbGDLE2Ez01PS0STSBGF53WOzmS6+KxbZLvKPgX20MmrSzs8jQ",
  render_errors: [view: LoginWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Login.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
