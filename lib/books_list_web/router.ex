defmodule BooksListWeb.Router do
  use BooksListWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :authenticated do

  end

  scope "/api", BooksListWeb do
    pipe_through [:api, :autheticated]

  end
end
