#!/usr/bin/env python
import sys
 
#--- get all lines from stdin ---
for line in sys.stdin:
    line = line.strip()
    words = line.split(',')
    # Map the circuit name and driver name as one (comma separated) key
    print '%s,%s\t%s' % (words[0], words[1], "1")

