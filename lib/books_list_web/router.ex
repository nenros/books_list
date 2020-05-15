defmodule BooksListWeb.Router do
  use BooksListWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :authenticated do
    plug BooksListWeb.AuthenticatePlug
  end

  scope "/api", BooksListWeb do
    pipe_through [:api]

    resources "/author", AuthorController, singleton: true, only: [:create]
  end

  scope "/api", BooksListWeb do
    pipe_through [:api, :authenticated]

    resources "/author", AuthorController, singleton: true, only: [:show, :update]
    resources "/articles", ArticleController, only: [:index, :create, :delete]

  end
end
