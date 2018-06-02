defmodule IssuesTest do
  use ExUnit.Case
  doctest Issues

  import Issues.CLI,
    only: [
      parse_args: 1,
      sort_into_ascending_order: 1,
      convert_to_list_of_hashdicts: 1
    ]

  test ":help returned by passing with -h and --help options" do
    expected_result = :help
    placeholder = "placeholder"
    assert parse_args(["-h", placeholder]) == expected_result
    assert parse_args(["--help", placeholder]) == expected_result
  end

  test "should return 3 arguments when 3 arguments are passed" do
    expected_result = {"user", "project", 99}
    assert parse_args(["user", "project", "99"]) == expected_result
  end

  test "count should default to 4 when only 2 arguments are passed" do
    expected_result = {"user", "project", 4}
    assert parse_args(["user", "project"]) == expected_result
  end

  test "sort ascending orders the correct way" do
    result = fake_created_at_list(["c", "b", "a"]) |> sort_into_ascending_order
    issues = for issue <- result, do: issue["created_at"]
    assert issues == ~w(a b c)
  end

  defp fake_created_at_list(values) do
    data = for value <- values, do: [{"created_at", value}, {"other_data", "xxx"}]
    convert_to_list_of_hashdicts(data)
  end
end
