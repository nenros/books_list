defmodule BooksListWeb.ArticleController do
  use BooksListWeb, :controller

  alias BooksList.Authors
  alias BooksList.Authors.Article

  action_fallback BooksListWeb.FallbackController

  def create(conn, %{"article" => article_params}) do
    with {:ok, %Article{} = article} <- Authors.create_article(article_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.article_path(conn, :show, article))
      |> render("show.json", article: article)
    end
  end


  def delete(conn, %{"id" => id}) do
    article = Authors.get_article!(id)

    with {:ok, %Article{}} <- Authors.delete_article(article) do
      send_resp(conn, :no_content, "")
    end
  end
end
