defmodule Server do
  use GenServer

  def start_link(arg \\ 0), do: GenServer.start_link(__MODULE__, arg, name: :calculator_pid)

  def init(arg \\ 0), do: {:ok, arg}

  def handle_cast({:sum, value}, state), do: {:noreply, value + state}
  def handle_cast({:sub, value}, state), do: {:noreply, state - value}
  def handle_cast({:mult, value}, state), do: {:noreply, value * state}
  def handle_cast({:div, value}, state), do: {:noreply, state / value}

  def handle_call(:result, _from, value) do
    {:reply, value, value}
  end
end
