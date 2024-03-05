defmodule WtrSurvey.Data.Prompt do
  use Ecto.Schema
  import Ecto.Changeset

  schema "prompts" do
    field :title, :string
    field :participant, :string
    field :max, :float
    field :factor, :float
    has_many :answers, WtrSurvey.Data.Answer

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(prompt, attrs) do
    prompt
    |> cast(attrs, [:title, :participant, :max, :factor])
    |> validate_required([:title, :participant, :max, :factor])
  end
end
