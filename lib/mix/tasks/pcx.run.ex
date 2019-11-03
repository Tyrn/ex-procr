defmodule Mix.Tasks.Pcx.Run do
  use Mix.Task

  @shortdoc " >>> Run audio album builder <<<"

  def run(argv) do
    ExProcr.CLI.main(argv)
  end
end
