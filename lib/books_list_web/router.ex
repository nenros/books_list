defmodule BooksListWeb.Router do
  use BooksListWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", BooksListWeb do
    pipe_through :api
  end
end
