// http://mathworld.wolfram.com/BenfordsLaw.html
bf:{d!10 xlog 1+reciprocal d:1 2 3 4 5 6 7 8 9}
bfx:{(1 2 3 4 5 6 7 8 9!9#0f)+(count each group floor x%10 xexp floor 10 xlog x)%count x,:()} 
bfd:{bf[]-bfx x} / difference
