defmodule SherlockBoard.MyJob do
  import SherlockBoard.Job

  def run do
    IO.puts "hello"
  end

  def period do
    2 * 1000
  end
end
