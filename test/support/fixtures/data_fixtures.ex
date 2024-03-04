defmodule WtrSurvey.DataFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `WtrSurvey.Data` context.
  """

  @doc """
  Generate a survey.
  """
  def survey_fixture(attrs \\ %{}) do
    {:ok, survey} =
      attrs
      |> Enum.into(%{
        title: "some title"
      })
      |> WtrSurvey.Data.create_survey()

    survey
  end
end
