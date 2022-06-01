defmodule Calculator do
  def operations(value, :sum), do: GenServer.cast(:calculator_pid, {:sum, value})

  def operations(value, :sub), do: GenServer.cast(:calculator_pid, {:sub, value})

  def operations(value, :mult), do: GenServer.cast(:calculator_pid, {:mult, value})

  def operations(value, :div), do: GenServer.cast(:calculator_pid, {:div, value})

  def result(), do: GenServer.call(:calculator_pid, :result)
end
