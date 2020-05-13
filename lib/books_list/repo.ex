defmodule BooksList.Repo do
  use Ecto.Repo,
    otp_app: :books_list,
    adapter: Ecto.Adapters.Postgres
end
