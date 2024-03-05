defmodule WtrSurvey.Repo.Migrations.CreatePrompts do
  use Ecto.Migration

  def change do
    create table(:prompts) do
      add :title, :string
      add :participant, :string
      add :max, :float
      add :factor, :float

      timestamps(type: :utc_datetime)
    end
  end
end
