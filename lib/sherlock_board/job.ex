defmodule SherlockBoard.Job do
  alias SherlockBoard.Endpoint
  alias SherlockBoard.JobEvents

  defmacro job(name, period, do: expression) do
    quote do
      defmodule unquote(Module.concat(SherlockBoard.Job, name)) do
        alias SherlockBoard.Endpoint
        def send_event(name, data) do
          data_with_time = Map.merge(data, %{period: period()})
          JobEvents.broadcast({name, data_with_time})
          Endpoint.broadcast("jobs", name, data_with_time)
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
