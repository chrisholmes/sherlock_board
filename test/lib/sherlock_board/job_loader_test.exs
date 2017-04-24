defmodule SherlockBoard.JobLoaderTest do
  use ExUnit.Case, async: true

  setup do
    Temp.track
    :ok
  end

  def module_name(length) do
    alphabets = "abcdefghijklmnopqrstuvwxyz" |> String.split("")
    List.duplicate(:foo, length)
    |> Enum.map(fn(_) -> Enum.random(alphabets) end ) 
    |> Enum.join 
    |> String.capitalize
  end

  def create_job_module(path, name) do
    module_name = "JobFixtures.#{name}"
    module_definition = "defmodule #{module_name} do\nend"
    File.write(Path.join(path, "#{name}.exs"), module_definition)
    module_name
  end

  def create_job_modules(path, names) do
    Enum.map(names, fn(name) -> create_job_module(path, name) end) |> Enum.sort
  end

  test "it loads Jobs from a directory" do
    directory = Temp.mkdir!("jobs")
    names = [module_name(12), module_name(12)]
    loaded_module_names = create_job_modules(directory, names) 
                    |> Enum.map(fn(name) -> "Elixir.#{name}" end)
    jobs = SherlockBoard.JobLoader.load(directory)
    assert Enum.map(jobs, fn(j) -> to_string j end) == loaded_module_names
  end

  test "it will error if no directory" do
    assert_raise File.Error, fn ->
      SherlockBoard.JobLoader.load("test/job_fixtures_foo")
    end
  end

  test "it will load nothing if directory is empty" do
    directory = Temp.mkdir!("jobs")
    jobs = SherlockBoard.JobLoader.load(directory)
    assert jobs == []
  end
end
