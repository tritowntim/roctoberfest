app "roctoberfest-2022-01"
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
                largestGroups =
                    contents
                        |> splitGroups
                        |> List.map splitLines
                        |> List.map toU64
                        |> List.map List.sum
                        |> List.sortDesc
                        |> List.takeFirst 3

                max =
                    largestGroups
                        |> List.max
                        |> Result.withDefault 0

                sum =
                    largestGroups
                        |> List.sum

                [
                    "1. max =",
                    Num.toStr max,
                    "2. sum =",
                    Num.toStr sum,
                ]
                    |> Str.joinWith (" ")
                    |> Stdout.line

            Err _ -> Stdout.line "err"
