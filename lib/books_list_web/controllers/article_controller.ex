defmodule BooksListWeb.ArticleController do
  use BooksListWeb, :controller

  alias BooksList.Authors
  alias BooksList.Authors.Article

  action_fallback BooksListWeb.FallbackController

  def index(conn, _params) do
    with articles <- Authors.list_articles_with_author_details() do
      conn
      |> put_status(:ok)
      |> render("index.json", articles: articles)
    end
  end

  def create(conn, %{"article" => article_params}) do
    author = conn.assigns.current_author
    with {:ok, %Article{} = article} <- Authors.create_article(author, article_params) do
      conn
      |> put_status(:created)
      |> render("show.json", article: article)
    end
  end


  def delete(conn, %{"id" => id}) do
    article = Authors.get_article!(id)
    author = conn.assigns.current_author

    with true <- id_match(article, author),
         {:ok, %Article{}} <- Authors.delete_article(article) do
      send_resp(conn, :no_content, "")
    else
      {:error, error} -> {:error, error}
      false -> {:error, :unauthorized}
    end
  end

  defp id_match(%{author_id: author_id}, %{id: current_author_id}), do: author_id == current_author_id
end
