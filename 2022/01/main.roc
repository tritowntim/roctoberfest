app "hi"
    packages { pf: "https://github.com/roc-lang/basic-cli/releases/download/0.4.0/DI4lqn7LIZs8ZrCDUgLK-tHHpQmxGF1ZrlevRKq5LXk.tar.br" }
    imports [pf.File, pf.Path, pf.Stdout, pf.Task.{ Task }]
    provides [main] to pf

main : Task {} U32
main =
    task =
        "input.txt" |> Path.fromStr |> File.readUtf8

    splitGroups = \text ->
        Str.split text "\n\n"

    splitLines = \text ->
        Str.split text "\n"

    toU64 = \list ->
        list
        |> List.keepOks Str.toU64

    Task.attempt task \result ->
        when result is
            Ok contents ->
                contents
                |> splitGroups
                |> List.map splitLines
                |> List.map toU64
                |> List.map List.sum
                |> List.max
                |> Result.withDefault 0
                |> Num.toStr
                |> Stdout.line

            Err _ -> Stdout.line "err"
