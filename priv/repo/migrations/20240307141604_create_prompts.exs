defmodule WtrSurvey.Repo.Migrations.CreatePrompts do
  use Ecto.Migration

  def change do
    create table(:prompts) do
      add :title, :string
      add :participant, :string
      add :max, :float
      add :factor, :float

      add :survey_id, references(:surveys, on_delete: :delete_all)

      timestamps(type: :utc_datetime)
    end
  end
end