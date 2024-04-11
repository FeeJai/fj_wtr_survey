defmodule WtrSurvey.Data.Prompt do
  use Ecto.Schema
  import Ecto.Changeset

  schema "prompts" do
    field :title, :string
    field :participant, :string
    field :max, :integer
    field :factor, :float
    field :survey_id, :id, references: WtrSurvey.Data.Survey
    # belongs_to :survey, WtrSurvey.Data.Survey
    has_many :answers, WtrSurvey.Data.Answer

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(prompt, attrs) do
    prompt
    |> cast(attrs, [:title, :participant, :max, :factor, :survey_id])
    |> validate_required([:title, :participant, :max, :factor, :survey_id])
  end
end
