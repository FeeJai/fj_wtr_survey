defmodule WtrSurvey.Repo.Migrations.CreateAnswers do
  use Ecto.Migration

  def change do
    create table(:answers) do
      add :you, :float
      add :participant, :float
      add :prompt_id, references(:prompts, on_delete: :delete_all)

      timestamps(type: :utc_datetime)
    end
  end
end
