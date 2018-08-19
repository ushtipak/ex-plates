defmodule PlatesPlay.Worker do
  use GenServer

  def start_link(_) do
    GenServer.start_link(__MODULE__, nil, [])
  end

  def init(_) do
    {:ok, nil}
  end

  def handle_call({word}, _from, state) do
    {:reply, word, state}
  end
end
