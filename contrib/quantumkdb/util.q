/ useful utility functions

\d .util

// internal

NSX:`q`Q`h`o                                                            / excluded namespaces, edit as needed
ns:~[1#.q]1#                                                            / check if argument is a namespace
k)a:{x@<x}                                                              / shorthand asc (for vectors only)                                                             
m0:{where like[lower x;lower$[10h=abs type y;y;"*",string[y],"*"]]}     / returns indices of case insensitive matches, attaches "*" to either side for symbols
m1:{x m0[x]y}                                                           / returns matches
m2:{x m0[last each` vs'x]y}                                             / examines end of inputs when split on . e.g. upd matches .u.strupdate but not .upd.test

// public
find:{
 f:{(n where not b),raze .z.s each(n:` sv'x,'k)where b:ns each x k:a 1_key x};    / flattens out all variables in a namespace
 v:m2[a[key`.],raze f each` sv'`,'a except[key`]NSX]x;                            / returns all variables in session
 ([]name:v;typ:type each get each v)}                                             / find matching variables (case insensitive). searches root and defined namespaces

findcol:{
 f:{(` sv'x,'get"\\a ",string x),raze .z.s each` sv'x,'a where ns each get x};    / flatten out all table names in namespace and subnamespaces
 t:get["\\a"],raze f each` sv'`,'a except[key`]NSX;                               / combine tables in root to all namespaced tables
 i:where 0<count each c:(cols each t)m1\:x;                                       / find matching column names (case insensitive)
 ([]table:t i;colnames:c i)}                                                      / return matching columns and tables they belong to

\d .

\

USAGE

.util.find`upd         / matches all variables containing upd
.util.find"upd*"       / matches variables beginning with upd

.util.findcol`price    / match all cols containg price
.util.findcol"*size"   / match cols ending with size
