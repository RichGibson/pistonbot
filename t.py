length=6.0;
cnt=4.0;

import pdb

# distribute cnt holes over length
gap = length/(cnt);
print "gap: ", gap
for i in range(4):
    loc = -1;
    loc = gap/2.0 + i*gap
    print "%i: %f " % (i, loc)
