defmodule Client do
  require Logger

  def start() do
    for _ <- 1..10 do
      Task.async(&run/0)
    end
    |> Task.await_many()
  end

  def run() do
    {:ok, socket} = :gen_tcp.connect(~c"localhost", 4100, [:binary, packet: :line, active: false])
    :ok = :gen_tcp.send(socket, "hello\n")
    {:ok, "hello\n"} = :gen_tcp.recv(socket, 0)
    Logger.info("ok")
  end
end

Client.start()
