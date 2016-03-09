# test range...

def r(t,a) :
    # take t from 0..1, and a, a total angle
    # for t in 0-.5 return 0 to a
    # for t in .5-1 return a to 0

    angle = (a*t)-22.5
    return angle



for i in range(10):
    print r(i/10.0, 45)
