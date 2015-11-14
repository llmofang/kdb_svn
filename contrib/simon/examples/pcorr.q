/ parallel correlation of timeseries 
k)comb:{(,!0){,/(|!#y),''y#\:1+x}/x+\\(y-x-:1)#1}
/ d - date
/ st, et - start time, end time
/ gt - granularity type `minute `second `hour ..
/ gi - granularity interval (for xbar)
/ s - symbols
pcorr:{[d;st;et;gt;gi;s]
	data:select last price by sym,gi xbar gt$time from trade where date=d,sym in s,time within(st,et);
	us:select distinct sym from data;ut:select distinct time from data;
	if[not(count data)=(count us)*count ut; / if there are data holes..
		filler:first 1#0#exec price from data;
		data:update price:fills price by sym from`time xasc(2!update price:filler from us cross ut),data;
		if[count ns:exec sym from data where time=st,null price;
			data:update price:reverse fills reverse price by sym from data where sym in ns]];
	PCORR::0!select avgp:avg price,devp:dev price,price by sym from data;
	data:(::);r:{.[pcorrcalc;;0]PCORR x}peach comb[2]count PCORR;PCORR::(::);r}

pcorrcalc:{[x;y]`sym0`sym1`co!(x[`sym];y[`sym];(avg[x[`price]*y[`price]]-x[`avgp]*y[`avgp])%x[`devp]*y[`devp])}

matrix:{ / convert output from pcorr to matrix
	u:asc value distinct exec sym0 from x; / sym0 has 1 more element than sym1!
	exec u#(value sym1)!co by value sym0 from x}

\
d:first date;st:10:00;et:11:30;gt:`second;gi:10;s:`GOOG`MSFT`AAPL`CSCO`IBM`INTL;
s:100#exec sym from `size xdesc select sym,size from daily where date=d;
show pcorr[d;st;et;gt;gi;s];
show matrix pcorr[d;st;et;gt;gi;s]
