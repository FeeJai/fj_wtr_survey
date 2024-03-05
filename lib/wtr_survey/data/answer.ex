defmodule WtrSurvey.Data.Answer do
  use Ecto.Schema
  import Ecto.Changeset

  schema "answers" do
    field :participant, :float
    field :you, :float
    belongs_to :prompt, WtrSurvey.Data.Prompt

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(answer, attrs) do
    answer
    |> cast(attrs, [:you, :participant, :prompt_id])
    |> validate_required([:you, :participant, :prompt_id])
  end
end
