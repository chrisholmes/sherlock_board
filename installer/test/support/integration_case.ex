defmodule SherlockBoard.Installer.IntegrationCase do
  use ExUnit.CaseTemplate

  using do
    quote do
      use Hound.Helpers
      hound_session

      def wait_until(fun), do: wait_until(5000, fun)

      def wait_until(0, fun), do: fun.()

      def wait_until(timeout, fun) do
        try do
          fun.()
        rescue
          ExUnit.AssertionError ->
            :timer.sleep(100)
            wait_until(max(0, timeout - 100), fun)
        end
      end
    end
  end
end

