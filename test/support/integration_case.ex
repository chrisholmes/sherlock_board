defmodule SherlockBoard.IntegrationCase do
  use ExUnit.CaseTemplate

  using do
    quote do
      use Hound.Helpers

      import SherlockBoard.Router.Helpers

      alias SherlockBoard.Repo

      # The default endpoint for testing
      @endpoint SherlockBoard.Endpoint

      hound_session
    end
  end
end

