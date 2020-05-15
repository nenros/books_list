defmodule BooksListWeb.AuthorController do
  use BooksListWeb, :controller

  alias BooksList.Authors
  alias BooksList.Authors.Author

  action_fallback BooksListWeb.FallbackController

  def create(conn, %{"author" => author_params}) do
    with {:ok, %Author{} = author} <- Authors.create_author(author_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.author_path(conn, :show))
      |> put_resp_header("x-author-token", author.token)
      |> render("show.json", author: author)
    end
  end

  def show(conn, _) do
    %{current_author: author} = conn.assigns
    render(conn, "show.json", author: author)
  end

  def update(conn, %{"author" => author_params}) do
    %{current_author: author} = conn.assigns
    with {:ok, author} <- Authors.update_author(author, author_params) do
      conn
      |> put_status(:ok)
      |> render("show.json", author: author)
    end
  end
end
