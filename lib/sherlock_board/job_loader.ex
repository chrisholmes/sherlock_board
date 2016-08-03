defmodule SherlockBoard.JobLoader do
  def load(directory) do
    File.ls!(directory) 
    |> Enum.map(fn(f) -> Path.join(directory, f) end)
    |> Enum.flat_map(fn(file) -> Code.load_file(file) end) 
    |> Enum.map(fn({module_name, _bytecode}) -> module_name end)
  end
end
