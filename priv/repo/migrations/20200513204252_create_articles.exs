defmodule BooksList.Repo.Migrations.CreateArticles do
  use Ecto.Migration

  def change do
    create table(:articles) do
      add :title, :string
      add :description, :text
      add :body, :text
      add :author_id, references(:authors, on_delete: :delete_all), null: false

      timestamps(inserted_at: :published_date)
    end

  end
end
