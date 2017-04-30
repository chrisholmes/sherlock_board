defmodule SherlockBoard.Job do
  alias SherlockBoard.Endpoint
  def send_event(name, data) do
    Endpoint.broadcast("jobs", name, data)
  end

  def send_html(name, html) do
    Endpoint.broadcast("jobs", name, %{html: html})
  end

  defmacro job(name, period, do: expression) do
    quote do
      defmodule unquote(Module.concat(SherlockBoard.Job, name)) do
        import SherlockBoard.Job
        def run, do: unquote(expression)
        def period, do: unquote(period)
      end
    end
  end
end
