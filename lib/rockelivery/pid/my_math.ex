defmodule MyMath do
  def start, do: spawn(fn -> loop(0) end)

  def loop(value) do
    new_value =
      receive do
        {:value, caller} -> send(caller, {:response, value})
        {:add, given_value} -> value + given_value
        {:sub, given_value} -> value - given_value
      end

    loop(new_value)
  end

  def add(pid, value), do: send(pid, {:add, value})
  def sub(pid, value), do: send(pid, {:sub, value})

  def get(pid) do
    send(pid, {:value, self()})

    receive do
      {:response, value} -> value
    after
      3000 -> "Error when process response"
    end
  end
end
