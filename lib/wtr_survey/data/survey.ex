defmodule WtrSurvey.Data.Survey do
  use Ecto.Schema
  import Ecto.Changeset

  schema "surveys" do
    field :title, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(survey, attrs) do
    survey
    |> cast(attrs, [:title])
    |> validate_required([:title])
  end
end
