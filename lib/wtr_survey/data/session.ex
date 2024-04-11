defmodule WtrSurvey.Data.Session do
  use Ecto.Schema
  import Ecto.Changeset

  schema "sessions" do
    field :participant_name, :string
    field :survey_id, :id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(session, attrs) do
    session
    |> cast(attrs, [:participant_name])
    |> validate_required([:participant_name])
  end
end
