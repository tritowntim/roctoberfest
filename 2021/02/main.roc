app "roctoberfest-2021-02"
    packages { pf: "../../../roc/examples/cli/cli-platform/main.roc"}
    imports [
        pf.File,
        pf.Path,
        pf.Program.{ Program, ExitCode },
        pf.Stdout,
        pf.Task
    ]
    provides [main] to pf

main =
    Program.quick task

task =
    "input.txt"
        |> Path.fromStr
        |> File.readUtf8
        |> Task.await solve

solve = \content ->
    content
        |> Str.trim
        |> Str.split "\n"
        |> List.keepOks (\line -> Str.splitFirst line " ")
        |> List.walk ({ x: 0, y: 0 }) step
        |> (\state -> state.x * state.y)
        |> Num.toStr
        |> Stdout.line

step = \state, pair ->
    after =
        pair
            |> .after
            |> Str.toU128
            |> Result.withDefault 0

    when pair.before is
        "forward" ->
            { state & x: state.x + after }
        "down" ->
            { state & y: state.y + after }
        "up" ->
            { state & y: state.y - after }
        _ ->
            state
