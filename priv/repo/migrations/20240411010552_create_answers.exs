defmodule WtrSurvey.Repo.Migrations.CreateAnswers do
  use Ecto.Migration

  def change do
    create table(:answers) do
      add :you, :integer
      add :participant, :float
      add :session_id, references(:sessions, on_delete: :nothing), null: false
      add :prompt_id, references(:prompts, on_delete: :nothing), null: false

      timestamps(type: :utc_datetime)
    end
  end
end
