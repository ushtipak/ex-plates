defmodule ExPlates.Application do
  @moduledoc false

  use Application

  defp poolboy_config do
    [
      {:name, {:local, :worker}},
      {:worker_module, ExPlates.Worker},
      {:size, 64},
      {:max_overflow, 32}
    ]
  end

  def start(_type, _args) do
    children = [
      :poolboy.child_spec(:worker, poolboy_config())
    ]

    opts = [strategy: :one_for_one, name: ExPlates.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
