app "roctoberfest-2021-02"
    packages { pf: "../../../roc/examples/interactive/cli-platform/main.roc"}
    imports [
        pf.File,
        pf.Path,
        pf.Program.{ Program, ExitCode },
        pf.Stdout,
        pf.Task
    ]
    provides [main] to pf


main =
    Program.quick solve

solve =
    "input.txt"
        |> Path.fromStr
        |> File.readUtf8
        |> Task.await Stdout.line