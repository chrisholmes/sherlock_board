defmodule SherlockBoard.JobLoaderTest do
  use ExUnit.Case, async: true

  test "it loads Job modules from a directory" do
    jobs = SherlockBoard.JobLoader.load("test/job_fixtures")
    assert Enum.map(jobs, fn(j) -> to_string j end) == ["Elixir.JobFixtures.A", "Elixir.JobFixtures.B"]
  end

  test "it will load nothing if directory is empty" do
    jobs = SherlockBoard.JobLoader.load("test/job_fixtures")
    assert Enum.map(jobs, fn(j) -> to_string j end) == ["Elixir.JobFixtures.A", "Elixir.JobFixtures.B"]
  end
end
