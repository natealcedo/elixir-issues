defmodule Issues.CLI do
  @default_count  4
  def parse_args(argv) do
    parse_result = OptionParser.parse(argv, switches: [help: :boolean], aliases: [h: :help])
    case parse_result do
      {[help: true], _, _} -> :help
      {_, [user, project], _} -> {user, project, @default_count}
      {_, [user, project, count], _} -> {user, project, String.to_integer(count)}
    end
  end
end
