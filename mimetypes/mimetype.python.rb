# ---------------- solution 1

N = int(raw_input())
Q = int(raw_input())

tableCor = {}
for i in range(N):
    l = raw_input().split(" ")
    tableCor[l[0].lower()] = l[1]

tableFiles = []
for i in range(Q):
    tableFiles.append(raw_input())


keys = tableCor.keys()
for k in tableFiles:
    ll = k.split(".")
    if len(ll)>1:
        e=ll[len(ll)-1].lower()
        if e in keys:
            print tableCor[e]
        else:
            print "UNKNOWN"        
    else:
        print "UNKNOWN"  
	
# ---------------- solution 2	
# Read inputs from Standard Input.
# Write outputs to Standard Output.

import sys

n = int(raw_input())
q = int(raw_input())

mimes = [raw_input() for i in range(n)]
files = [raw_input() for i in range(q)]

mimes_dict = dict()
for m in mimes:
    kv = m.split(' ')
    mimes_dict[kv[0].lower()] = kv[1]

mimes_keys = mimes_dict.keys()
for f in files:
    ext = f.rsplit('.', 1)
    if len(ext) > 1 and ext[1].lower() in mimes_keys:
        print mimes_dict[ext[1].lower()]
    else:
        print 'UNKNOWN'	