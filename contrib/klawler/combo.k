//Combinatorial functions, eachup/down, primes.
//
//K 3.2
//kevin.lawler@gmail.com 2007.01.21
//
//Use the functions without numbers in the titles.
//
//The non-adverbial functions are necessarily exponential. Precompute the tables.
//The design criteria was shortness, not speed. Most are still fast.
//
//Apply list function recursively, once at each depth "eachup[asc;m]"
eachup:{:[@y;y;x _f'[x;y]]};
eachdown:{:[@y;y;_f'[x;x y]]};
//
//Permutations on n elements  "perm 4"
perm:{{x@<x}x{,/(1!)\'x,'#*x}/,!0}; //Sorted. Function version.
perm0:(,!0){,/(1!)\'x,'y}/!:;       //Unsorted. Inline version.
//
//Combinations, k out of n elements "comb[5;3]"
comb:{{x@<x}@&:'k(?,/(1!)\'r,')/,(r:k=y)=&x-k:y&x-y};   //Sorted. Added exploitation of n-k vs. k symmetry.
comb0:{&:'y(?,/(1!)\'1,')/,&x-y};                       //Unsorted.
//
//Inversion tables of permutations on n elements "pitd 4"
pitd:(,!0)(,/,/:\:)/|!:'1+!:;      //Decreasing numbers. Sorted.
piti:(,!0)(,/,/:\:)/!:'1+!:;       //Increasing numbers. Sorted.
//
//Choose function, counts k out of n combinations "nck[7;3]"
nck:{_*/(x-!y)%1+!y};              //Returns integers
//
//k-Permutations, counts permutations over size k subsets of n elements "npk[5;3]"
npk:{*/x-!y};
//
//Factorial, counts permutations on n elements "fac 7"
fac:*/1+!:;
//
//Primes to n, exclusive "pn 20"
pn:2_&{&/x!'2_!x}'!:;
//
//How to use different functions on the same lists
//{x[y;z]}'(*;+;%;^)               //Thanks AB
