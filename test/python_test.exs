defmodule PythonTest do
  use ExUnit.Case

  test "start python" do
    {r, pid} = :python.start()
    assert r == :ok

    sum = :python.call(pid, :pystub, :add, [1, 2])
    assert sum == 3

    tr = :python.call(pid, :pystub, :truth, [false])
    assert tr == false

    tr = :python.call(pid, :pystub, :truth, [true])
    assert tr == true

    # None is not compatible with nil.
    tr = :python.call(pid, :pystub, :null, [nil])
    assert tr == 1

    str = :python.call(pid, :pystub, :pass_str, ["alfa"])
    assert str == "alfa"

    lstr = :python.call(pid, :pystub, :pass_str, [[<<"alfa">>, "bravo"]])
    assert lstr == ["alfa", "bravo"]

    pstr = :python.call(pid, :pystub, :pass_str, [lstr])
    assert pstr == lstr

    inp = [
      <<"path">>,
      [
        [<<"artist">>, <<"bilbo">>],
        [<<"album">>, <<"fire">>]
      ]
    ]

    out = [
      "path",
      [
        ["artist", "bilbo"],
        ["album", "fire"]
      ]
    ]

    input = [
      ["artist", "Чуча"],
      ["album", "Fire"]
    ]

    join = ["artist/Чуча", "album/Fire"]

    ret = :python.call(pid, :pystub, :pass_str, [inp])
    assert ret == out

    ret = :python.call(pid, :pystub, :pass_str, [out])
    assert ret == inp

    ret = :python.call(pid, :pystub, :set_tags, [<<"path">>, input])
    assert ret == join
  end
end
