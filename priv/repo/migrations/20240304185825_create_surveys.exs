defmodule WtrSurvey.Repo.Migrations.CreateSurveys do
  use Ecto.Migration

  def change do
    create table(:surveys) do
      add :title, :string

      timestamps(type: :utc_datetime)
    end
  end
end
