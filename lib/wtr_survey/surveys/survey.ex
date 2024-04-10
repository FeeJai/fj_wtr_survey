defmodule WtrSurvey.Surveys.Survey do
  use Ecto.Schema
  import Ecto.Changeset

  schema "surveys" do
    field :title, :string
    field :active, :boolean, default: false
    has_many :prompts, WtrSurvey.Data.Prompt

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(survey, attrs) do
    survey
    |> cast(attrs, [:title, :active])
    |> validate_required([:title])
  end
end
