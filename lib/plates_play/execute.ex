defmodule Execute do
  @timeout 1000

  def start do
    plate_codes_file = "/home/m/live-test/ex/plates"
    wordlist_file = "/home/m/live-test/ex/words"

    plate_codes = File.stream!(plate_codes_file) 
            |> Stream.map(&String.trim/1) 
            |> Enum.to_list
    IO.inspect plate_codes

    File.stream!(wordlist_file)
    |> Stream.map(&String.trim/1)
    |> Stream.filter(fn(n) -> String.length(n) == 4 end)      
    |> Stream.map(fn line -> async_word_check(line) end)
    |> Stream.each(fn task -> await_and_inspect(task) end)
    |> Stream.run
  end

  defp async_word_check(word) do
    Task.async(fn ->
      :poolboy.transaction(
        :worker,
        fn pid -> GenServer.call(pid, {word}) end,
        @timeout
      )
    end)
  end

  defp await_and_inspect(task), do:
    task
    |> Task.await(@timeout)
    |> IO.inspect()
end
