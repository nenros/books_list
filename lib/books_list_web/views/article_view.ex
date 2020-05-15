defmodule BooksListWeb.ArticleView do
  use BooksListWeb, :view
  alias BooksListWeb.ArticleView

  def render("index.json", %{articles: articles}) do
    %{data: render_many(articles, ArticleView, "article_with_author.json")}
  end

  def render("show.json", %{article: article}) do
    %{data: render_one(article, ArticleView, "article.json")}
  end

  def render("article.json", %{article: article}) do
    %{id: article.id}
  end

  def render("article_with_author.json", %{article: article}) do
    %{
      id: article.id,
      title: article.title,
      desrtiption: article.description,
      published_date: article.published_date,
      body: article.body,
      author: render_one(article.author, BooksListWeb.AuthorView, "author.json")
    }
  end
end
