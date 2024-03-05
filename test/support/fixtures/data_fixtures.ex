defmodule WtrSurvey.DataFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `WtrSurvey.Data` context.
  """

  @doc """
  Generate a prompt.
  """
  def prompt_fixture(attrs \\ %{}) do
    {:ok, prompt} =
      attrs
      |> Enum.into(%{
        title: "some title"
      })
      |> WtrSurvey.Data.create_prompt()

    prompt
  end

  @doc """
  Generate a answer.
  """
  def answer_fixture(attrs \\ %{}) do
    {:ok, answer} =
      attrs
      |> Enum.into(%{
        participant: 120.5,
        you: 120.5
      })
      |> WtrSurvey.Data.create_answer()

    answer
  end
end
