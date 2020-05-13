defmodule BooksList.Repo.Migrations.CreateArticles do
  use Ecto.Migration

  def change do
    create table(:articles) do
      add :title, :string
      add :description, :text
      add :body, :text
      add :published_date, :utc_datetime

      timestamps()
    end

  end
end
