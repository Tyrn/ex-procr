defmodule Mix.Tasks.Pcx.Run do
  @moduledoc """
  Running the audio album builder (main entry).
  """

  use Mix.Task

  @shortdoc " >>> Run audio album builder <<<"

  def run(argv) do
    ExProcr.CLI.main(argv)
  end
end
