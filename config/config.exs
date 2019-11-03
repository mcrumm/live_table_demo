# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :live_table,
  ecto_repos: [LiveTable.Repo]

# Configures the endpoint
config :live_table, LiveTableWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "H7qU9IzwWaimUEGKNRaUko2vWSr/QWf44yuz1yMfBdZAjdCB7+ViL/6OPU0U/z+l",
  render_errors: [view: LiveTableWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: LiveTable.PubSub, adapter: Phoenix.PubSub.PG2],
  live_view: [signing_salt: "HnM5P8046Wtr+5UP3VBH07d+HKGm2CykSommPoDurBQX7pj7m7RVHdctVxFg3aib"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Scrivener routes helper for link generation
config :scrivener_html,
  routes_helper: LiveTableWeb.Router.Helpers,
  view_style: :bootstrap_v4

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
