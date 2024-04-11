defmodule WtrSurvey.Data.Session do
  use Ecto.Schema
  import Ecto.Changeset

  schema "sessions" do
    field :participant_name, :string
    field :survey_id, :id, references: WtrSurvey.Data.Survey
    has_many :answers, WtrSurvey.Data.Answer

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(session, attrs) do
    session
    |> cast(attrs, [:participant_name, :survey_id])
    |> validate_required([:participant_name, :survey_id])
    |> validate_length(:participant_name, min: 2)
  end
end
