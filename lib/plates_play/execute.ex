defmodule Execute do
  @timeout 1000

  def start do
    plate_codes_file = "/home/m/live-test/ex/plates"
    wordlist_file = "/usr/share/dict/words"

    plate_codes = File.stream!(plate_codes_file) 
                  |> Stream.map(&String.trim/1)
                  |> Enum.to_list

    File.stream!(wordlist_file)
    |> Stream.map(&String.trim/1)
    |> Stream.filter(fn(n) -> String.length(n) == 4 end)      
    |> Stream.map(fn line ->
         Task.async(fn ->
           :poolboy.transaction(
             :worker,
             fn pid -> GenServer.call(pid, {line, plate_codes}) end,
             @timeout
           )
         end)
       end)
    |> Stream.each(fn task -> task |> Task.await(@timeout) end)
    |> Stream.run
  end

end
