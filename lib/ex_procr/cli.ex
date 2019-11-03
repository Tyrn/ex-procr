defmodule ExProcr.CLI do
  @moduledoc """
  Main function and command line handling. Any function taking a path
  argument, defined in this project, takes an ABSOLUTE PATH.
  in this module 
  """

  def main(argv) do
    argv
    |> parse_args()
    |> ExProcr.Album.copy()
  end

  @utility_description """
  pcx "Procrustes" SmArT is a CLI utility for copying subtrees containing
  supported audio files in sequence, naturally sorted. The end result is a
  "flattened" copy of the source subtree. "Flattened" means that only a namesake
  of the root source directory is created, where all the files get copied to,
  names prefixed with a serial number. Tag "Track Number" is set, tags "Title",
  "Artist", and "Album" can be replaced optionally. The writing process is
  strictly sequential: either starting with the number one file, or in the
  reversed order. This can be important for some mobile devices.
  """

  @doc """
  Parses the command line.
  """
  def parse_args(argv) do
    Optimus.new!(
      name: "pcx",
      # description: "Audio album builder",
      # version: "0.1.0",
      # author: "Tyrn",
      about: @utility_description,
      allow_unknown_args: false,
      parse_double_dash: true,
      args: [
        src_dir: [
          value_name: "SRC_DIR",
          help: "source directory",
          required: true,
          parser: fn s -> {:ok, Path.expand(s)} end
        ],
        dst_dir: [
          value_name: "DST_DIR",
          help: "general destination directory",
          required: true,
          parser: fn s -> {:ok, Path.expand(s)} end
        ]
      ],
      flags: [
        verbose: [
          short: "-v",
          long: "--verbose",
          help: "verbose output"
        ],
        drop_tracknumber: [
          short: "-d",
          long: "--drop-tracknumber",
          help: "do not set track numbers"
        ],
        strip_decorations: [
          short: "-s",
          long: "--strip-decorations",
          help: "strip file and directory name decorations"
        ],
        file_title: [
          short: "-f",
          long: "--file-title",
          help: "use file name for title tag"
        ],
        file_title_num: [
          short: "-F",
          long: "--file-title-num",
          help: "use numbered file name for title tag"
        ],
        sort_lex: [
          short: "-x",
          long: "--sort-lex",
          help: "sort files lexicographically"
        ],
        tree_dst: [
          short: "-t",
          long: "--tree-dst",
          help: "retain the tree structure of the source album at destination"
        ],
        drop_dst: [
          short: "-p",
          long: "--drop-dst",
          help: "do not create destination directory"
        ],
        reverse: [
          short: "-r",
          long: "--reverse",
          help: "copy files in reverse order (number one file is the last to be copied)"
        ],
        prepend_subdir_name: [
          short: "-i",
          long: "--prepend-subdir-name",
          help: "prepend current subdirectory name to a file name"
        ],
        overwrite: [
          short: "-w",
          long: "--overwrite",
          help: "silently remove existing destination directory (not recommended)"
        ],
        dry_run: [
          short: "-y",
          long: "--dry-run",
          help: "without actually copying the files"
        ]
      ],
      options: [
        file_type: [
          value_name: "FILE_TYPE",
          short: "-e",
          long: "--file-type",
          help: "accept only audio files of the specified type",
          parser: :string
        ],
        unified_name: [
          value_name: "UNIFIED_NAME",
          short: "-u",
          long: "--unified-name",
          help:
            "destination root directory name and file names are " <>
              "based on UNIFIED_NAME, serial number prepended, file " <>
              "extensions retained; also album tag, if the latter is " <>
              "not specified explicitly",
          parser: :string
        ],
        album_num: [
          value_name: "ALBUM_NUM",
          short: "-b",
          long: "--album-num",
          help: "0..99; prepend ALBUM_NUM to the destination root directory name",
          parser: :integer
        ],
        artist_tag: [
          value_name: "ARTIST_TAG",
          short: "-a",
          long: "--artist-tag",
          help: "artist tag name",
          parser: :string
        ],
        album_tag: [
          value_name: "ALBUM_TAG",
          short: "-g",
          long: "--album-tag",
          help: "album tag name",
          parser: :string
        ]
      ]
    )
    |> Optimus.parse!(argv)
  end
end
