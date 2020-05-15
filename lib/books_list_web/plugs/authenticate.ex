defmodule BooksListWeb.AuthenticatePlug do
  import Plug.Conn

  alias BooksList.Authors

  def init(options) do
    options
  end

  def call(conn, _opts) do
    with [token]  <- get_req_header(conn, "x-author-token"),
          author = %Authors.Author{} <- Authors.get_author_by_token!(token)
      do
      conn
      |> assign(:current_author, author)
    else
      _ ->
        conn
        |> BooksListWeb.FallbackController.call({:error, :unauthorized})
        |> halt
    end
  end


end
