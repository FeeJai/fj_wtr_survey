defmodule WtrSurvey.Data.Answer do
  use Ecto.Schema
  import Ecto.Changeset

  schema "answers" do
    field :participant, :float
    field :you, :integer
    belongs_to :prompt, WtrSurvey.Data.Prompt
    belongs_to :session, WtrSurvey.Data.Session

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(answer, attrs) do
    answer
    |> cast(attrs, [:you, :participant, :prompt_id, :session_id])
    |> validate_required([:you, :participant, :prompt_id, :session_id])
  end
end
