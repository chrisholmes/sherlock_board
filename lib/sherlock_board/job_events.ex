defmodule SherlockBoard.JobEvents do
  use GenStage
  require Logger

  def start_link_unnamed() do
     GenStage.start_link(__MODULE__, :ok, [])
  end

  def start_link() do
     GenStage.start_link(__MODULE__, :ok, name: __MODULE__)
  end

  def broadcast({_name, _data} = event, stage \\ __MODULE__) do
    GenStage.cast(stage, {:broadcast, event})
  end

  def stream(stage \\ __MODULE__) do
    GenStage.stream([stage])
  end

  def init(:ok) do
    {:producer, :ok, dispatcher: GenStage.BroadcastDispatcher}
  end

  def handle_cast({:broadcast, event}, state) do
    {:noreply, [event], state}
  end

  def handle_demand(_demand, state) do
    {:noreply, [], state} # We don't care about the demand
  end
end

