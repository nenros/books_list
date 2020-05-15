defmodule BooksListWeb.AuthorView do
  use BooksListWeb, :view
  alias BooksListWeb.AuthorView


  def render("show.json", %{author: author}) do
    %{data: render_one(author, AuthorView, "author.json")}
  end

  def render("author.json", %{author: author}) do
    %{
      id: author.id,
      first_name: author.first_name,
      last_name: author.last_name,
      age: author.age
    }
  end
end
