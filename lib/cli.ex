defmodule Issues.CLI do
  @default_count  4

  def process({user, project, _count}) do
    Issues.GithubIssues.fetch(user, project)
    |> handle_response
  end

  def handle_response({:ok, body}), do: body
  def handle_response({:error, error}) do
    {_, message} = List.keyfind(error, "message", 0)
    IO.puts "Error Fetching from Github: #{message}"
    System.halt(2)
  end

  def process(:help) do
    IO.puts """
    usage: issues <user> <project> [ count | #{@default_count} ]
    """
    System.halt(0)
  end

  def run(argv) do
    argv
    |> parse_args
    |> process
  end

  def parse_args(argv) do
    parse_result = OptionParser.parse(argv, switches: [help: :boolean], aliases: [h: :help])
    case parse_result do
      {[help: true], _, _} -> :help
      {_, [user, project], _} -> {user, project, @default_count}
      {_, [user, project, count], _} -> {user, project, String.to_integer(count)}
    end
  end
end
