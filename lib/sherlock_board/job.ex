defmodule SherlockBoard.Job do
  alias SherlockBoard.Endpoint

  defmacro job(name, period, do: expression) do
    quote do
      defmodule unquote(Module.concat(SherlockBoard.Job, name)) do
        alias SherlockBoard.Endpoint
        def send_event(name, data) do
          Endpoint.broadcast("jobs", name, Map.merge(data, %{period: period}))
        end

        def send_html(name, html) do
          send_event(name, %{html: html})
        end

        def run, do: unquote(expression)
        def period, do: unquote(period)
      end
    end
  end
end
