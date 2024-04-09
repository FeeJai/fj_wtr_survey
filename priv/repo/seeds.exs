# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     WtrSurvey.Repo.insert!(%WtrSurvey.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias WtrSurvey.Surveys.Survey
alias WtrSurvey.Data.Prompt

survey = %Survey{
  title: "My first survey"
}

{:ok, survey} = WtrSurvey.Repo.insert(survey)

IO.puts("Survey created!")

prompt = %Prompt{
  survey_id: survey.id,
  title: "A or B?",
  participant: "yourself",
  max: 10.0,
  factor: 2.5
}

WtrSurvey.Repo.insert(prompt)
