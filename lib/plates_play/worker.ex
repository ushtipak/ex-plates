defmodule ExPlates.Worker do
  use GenServer

  def start_link(_) do
    GenServer.start_link(__MODULE__, nil, [])
  end

  def init(_) do
    {:ok, nil}
  end

  def handle_call({word, plate_codes}, _from, state) do
    IO.inspect plate_codes
    {:reply, word, state}
  end
end
