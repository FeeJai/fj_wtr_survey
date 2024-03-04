defmodule WtrSurvey.DataTest do
  use WtrSurvey.DataCase

  alias WtrSurvey.Data

  describe "surveys" do
    alias WtrSurvey.Data.Survey

    import WtrSurvey.DataFixtures

    @invalid_attrs %{title: nil}

    test "list_surveys/0 returns all surveys" do
      survey = survey_fixture()
      assert Data.list_surveys() == [survey]
    end

    test "get_survey!/1 returns the survey with given id" do
      survey = survey_fixture()
      assert Data.get_survey!(survey.id) == survey
    end

    test "create_survey/1 with valid data creates a survey" do
      valid_attrs = %{title: "some title"}

      assert {:ok, %Survey{} = survey} = Data.create_survey(valid_attrs)
      assert survey.title == "some title"
    end

    test "create_survey/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Data.create_survey(@invalid_attrs)
    end

    test "update_survey/2 with valid data updates the survey" do
      survey = survey_fixture()
      update_attrs = %{title: "some updated title"}

      assert {:ok, %Survey{} = survey} = Data.update_survey(survey, update_attrs)
      assert survey.title == "some updated title"
    end

    test "update_survey/2 with invalid data returns error changeset" do
      survey = survey_fixture()
      assert {:error, %Ecto.Changeset{}} = Data.update_survey(survey, @invalid_attrs)
      assert survey == Data.get_survey!(survey.id)
    end

    test "delete_survey/1 deletes the survey" do
      survey = survey_fixture()
      assert {:ok, %Survey{}} = Data.delete_survey(survey)
      assert_raise Ecto.NoResultsError, fn -> Data.get_survey!(survey.id) end
    end

    test "change_survey/1 returns a survey changeset" do
      survey = survey_fixture()
      assert %Ecto.Changeset{} = Data.change_survey(survey)
    end
  end
end
