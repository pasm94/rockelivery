defmodule Rockelivery.Shared.Cache.Ets.CacheEts do
  use GenServer

  @database :providers

  def start_link(_), do: GenServer.start_link(__MODULE__, %{}, name: CacheEts)

  def init(state) do
    :ets.new(@database, [:set, :public, :named_table])

    {:ok, state}
  end

  def handle_cast({:put, key, value}, state) do
    :ets.insert(@database, {key, value})

    {:noreply, state}
  end

  def handle_call({:get, key}, _from, state) do
    reply =
      :ets.lookup(@database, key)
      |> case do
        [] -> {:not_found, []}
        [{_key, value}] -> {:ok, value}
      end

    {:reply, reply, state}
  end
end

# Rockelivery.Shared.Cache.Ets.CacheEts.start_link()
# GenServer.cast(CacheEts, {:put, key, value})
# GenServer.call(CacheEts, {:get, key})
