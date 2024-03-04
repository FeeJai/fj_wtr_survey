defmodule WtrSurveyWeb.SurveyLiveTest do
  use WtrSurveyWeb.ConnCase

  import Phoenix.LiveViewTest
  import WtrSurvey.DataFixtures

  @create_attrs %{title: "some title"}
  @update_attrs %{title: "some updated title"}
  @invalid_attrs %{title: nil}

  defp create_survey(_) do
    survey = survey_fixture()
    %{survey: survey}
  end

  describe "Index" do
    setup [:create_survey]

    test "lists all surveys", %{conn: conn, survey: survey} do
      {:ok, _index_live, html} = live(conn, ~p"/surveys")

      assert html =~ "Listing Surveys"
      assert html =~ survey.title
    end

    test "saves new survey", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/surveys")

      assert index_live |> element("a", "New Survey") |> render_click() =~
               "New Survey"

      assert_patch(index_live, ~p"/surveys/new")

      assert index_live
             |> form("#survey-form", survey: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#survey-form", survey: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/surveys")

      html = render(index_live)
      assert html =~ "Survey created successfully"
      assert html =~ "some title"
    end

    test "updates survey in listing", %{conn: conn, survey: survey} do
      {:ok, index_live, _html} = live(conn, ~p"/surveys")

      assert index_live |> element("#surveys-#{survey.id} a", "Edit") |> render_click() =~
               "Edit Survey"

      assert_patch(index_live, ~p"/surveys/#{survey}/edit")

      assert index_live
             |> form("#survey-form", survey: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#survey-form", survey: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/surveys")

      html = render(index_live)
      assert html =~ "Survey updated successfully"
      assert html =~ "some updated title"
    end

    test "deletes survey in listing", %{conn: conn, survey: survey} do
      {:ok, index_live, _html} = live(conn, ~p"/surveys")

      assert index_live |> element("#surveys-#{survey.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#surveys-#{survey.id}")
    end
  end

  describe "Show" do
    setup [:create_survey]

    test "displays survey", %{conn: conn, survey: survey} do
      {:ok, _show_live, html} = live(conn, ~p"/surveys/#{survey}")

      assert html =~ "Show Survey"
      assert html =~ survey.title
    end

    test "updates survey within modal", %{conn: conn, survey: survey} do
      {:ok, show_live, _html} = live(conn, ~p"/surveys/#{survey}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Survey"

      assert_patch(show_live, ~p"/surveys/#{survey}/show/edit")

      assert show_live
             |> form("#survey-form", survey: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#survey-form", survey: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/surveys/#{survey}")

      html = render(show_live)
      assert html =~ "Survey updated successfully"
      assert html =~ "some updated title"
    end
  end
end
