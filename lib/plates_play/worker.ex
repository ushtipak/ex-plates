defmodule ExPlates.Worker do
  use GenServer

  def start_link(_) do
    GenServer.start_link(__MODULE__, nil, [])
  end

  def init(_) do
    {:ok, nil}
  end

  def handle_call({word, plate_codes}, _from, state) do
    for plate_code <- plate_codes do
      is_valid = String.starts_with?(String.downcase(word), String.downcase(plate_code))
      if is_valid do
        IO.puts word
      end
    end
    {:reply, word, state}
  end
end
