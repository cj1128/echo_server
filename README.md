# A Simple Echo Server

I implemented a simple echo server in Elixir.

When I test it using `echo hello | nc localhost 4100`, everyting is fine.

But when I use a custom client which concurrently starts 10 connections, I got below error, so confused.

```
13:25:12.299 [error] Task #PID<0.108.0> started from #PID<0.95.0> terminating
** (MatchError) no match of right hand side value: {:error, :closed}
    lib/client.exs:14: Client.run/0
    (elixir 1.14.3) lib/task/supervised.ex:89: Task.Supervised.invoke_mfa/2
    (elixir 1.14.3) lib/task/supervised.ex:34: Task.Supervised.reply/4
    (stdlib 4.2) proc_lib.erl:240: :proc_lib.init_p_do_apply/3
Function: #Function<1.124100197/0 in Client.run>
    Args: []

13:25:12.299 [error] Task #PID<0.107.0> started from #PID<0.95.0> terminating
** (MatchError) no match of right hand side value: {:error, :closed}
    lib/client.exs:14: Client.run/0
    (elixir 1.14.3) lib/task/supervised.ex:89: Task.Supervised.invoke_mfa/2
    (elixir 1.14.3) lib/task/supervised.ex:34: Task.Supervised.reply/4
    (stdlib 4.2) proc_lib.erl:240: :proc_lib.init_p_do_apply/3
Function: #Function<1.124100197/0 in Client.run>
    Args: []
```

## How to run

```bash
$ mix run --no-halt
# in another shell
$ elixir lib/client.exs
```
