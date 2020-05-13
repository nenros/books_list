# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :books_list,
  ecto_repos: [BooksList.Repo]

# Configures the endpoint
config :books_list, BooksListWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "epCgXJDwSIlBhLIRgw3PYsnffagf64NohBBv0hGjsIsAwj6DxWP10upXG4kwpVBA",
  render_errors: [view: BooksListWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: BooksList.PubSub,
  live_view: [signing_salt: "1kkQPvcJ"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
