defmodule Issues.GithubIssues do
  @user_agent [{"User-agent", "Elixir dave@pragrog.com"}]

  def fetch(user, project) do
    get_issues_url(user, project)
    |> HTTPoison.get(@user_agent)
    |> handle_response
  end

  def get_issues_url(user, project) do
    "https://api.github.com/repos/#{user}/#{project}/issues"
  end

  def handle_response({:ok, %{status_code: 200, body: body}}), do: {:ok, :jsx.decode(body)}
  def handle_response({:ok, %{status_code: _, body: body}}), do: {:error, :jsx.decode(body)}
end