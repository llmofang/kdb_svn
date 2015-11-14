/ http://wikipedia.org/wiki/bollinger_bands
/ typically bb[2;20] data 
bb:{[k;n;data]m+/:(k*-1 0 1)*\:md:sqrt mavg[n;data*data]-m*m:mavg[n;data]}
