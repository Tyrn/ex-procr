#!/usr/bin/env python
import sys, os
from pathlib import Path

arglist = list(sys.argv)
arglist.pop(0)

src = None
dst = None

if len(arglist) > 1:
   src = Path(arglist[-2]).absolute()
   dst = Path(arglist[-1]).absolute()
   arglist[-2] = src.__str__()
   arglist[-1] = dst.__str__()

rawargs = " ".join(["'" + x + "'" for x in arglist])

os.chdir(Path('/home/alexey/spaces/elixir/ex_procr'))

os.system("mix pcx.run " + rawargs)
