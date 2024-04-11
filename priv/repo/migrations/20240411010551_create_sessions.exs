defmodule WtrSurvey.Repo.Migrations.CreateSessions do
  use Ecto.Migration

  def change do
    create table(:sessions) do
      add :participant_name, :string, null: false
      add :survey_id, references(:surveys, on_delete: :nothing), null: false

      timestamps(type: :utc_datetime)
    end

    create index(:sessions, [:survey_id])
  end
end
