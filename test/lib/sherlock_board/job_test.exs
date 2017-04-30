defmodule SherlockBoard.JobTest do
  use ExUnit.Case, async: true

  import SherlockBoard.Job

  test "use job macro to define a test" do
    {:module, module_name, _, _} = job(:FooBarTestJob, 2, do: "expected result")
    assert module_name == SherlockBoard.Job.FooBarTestJob
    assert module_name.run == "expected result"
    assert module_name.period == 2
  end

end
