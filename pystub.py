import os

def add(a, b):
    return a + b

def set_tags(path, tags):
    return [b"/".join(x) for x in tags]

def pass_str(s):
    return s

def truth(t):
    if t == True: return True
    if t == False: return False
    return 10

def null(n):
    if n == None: return None
    return 1
