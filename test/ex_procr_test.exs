defmodule ExProcrTest do
  use ExUnit.Case
  doctest ExProcr
  doctest ExProcr.Album

  import ExProcr.Album

  test "greets the world" do
    assert ExProcr.hello() == :world
  end

  test "checks Path.rootname behavior" do
    assert Path.rootname("") == ""
    assert Path.rootname(".") == ""
    assert Path.rootname(".moo") == ""
    assert Path.rootname("ama.do/fifth") == "ama.do/fifth"
    assert Path.rootname("party/foxtrot.flac") == "party/foxtrot"
    assert Path.rootname("hiena.feroz") == "hiena"
  end

  test "checks Path.basename behavior" do
    assert Path.basename("") == ""
    assert Path.basename(".") == "."
    assert Path.basename(".moo") == ".moo"
    assert Path.basename("ama.do/fifth") == "fifth"
    assert Path.basename("party/foxtrot.flac") == "foxtrot.flac"
  end

  test "checks Path.extname behavior" do
    assert Path.extname("") == ""
    assert Path.extname(".") == "."
    assert Path.extname(".moo") == ".moo"
    assert Path.extname("ama.do/fifth") == ""
  end

  test "checks for a specified extension" do
    assert has_ext_of("/alfa/bra.vo/charlie.ogg", "OGG") == true
    assert has_ext_of("/alfa/bra.vo/charlie.ogg", ".ogg") == true
    assert has_ext_of("/alfa/bra.vo/charlie.ogg", "mp3") == false
  end

  test "strips numbers from a string" do
    assert str_strip_numbers("ab11cdd2k.144") == [11, 2, 144]
    assert str_strip_numbers("144") == [144]
    assert str_strip_numbers("Ignacio Vazquez-Abrams") == []
    assert str_strip_numbers("") == []
  end

  test "lists of integers are not insane" do
    assert [1, 2] < [1, 2, 3] == true
    assert [1, 3] > [1, 2, 3] == true
  end

  test "makes initials" do
    assert make_initials(" ") == "."
    assert make_initials("John ronald reuel Tolkien") == "J.R.R.T."
    assert make_initials("  e.B.Sledge ") == "E.B.S."
    assert make_initials("Apsley Cherry-Garrard") == "A.C-G."
    assert make_initials("Windsor Saxe-\tCoburg - Gotha") == "W.S-C-G."
    assert make_initials("Elisabeth Kubler-- - Ross") == "E.K-R."
    assert make_initials("  Fitz-Simmons Ashton-Burke Leigh") == "F-S.A-B.L."
    assert make_initials("Arleigh \"31-knot\"Burke ") == "A.B."
    assert make_initials(~S{Harry "Bing" Crosby, Kris "Tanto" Paronto}) == "H.C.,K.P."
    assert make_initials("a.s.,b.s.") == "A.S.,B.S."
    assert make_initials("A. Strugatsky, B...Strugatsky.") == "A.S.,B.S."
    assert make_initials("Иржи Кропачек, Йозеф Новотный") == "И.К.,Й.Н."
    assert make_initials("österreich") == "Ö."
  end
end
