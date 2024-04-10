defmodule WtrSurvey.Repo.Migrations.CreateSurvey do
  use Ecto.Migration

  def change do
    create table(:surveys) do
      add :title, :string
      add :active, :boolean, default: false

      timestamps(type: :utc_datetime)
    end
  end
end
