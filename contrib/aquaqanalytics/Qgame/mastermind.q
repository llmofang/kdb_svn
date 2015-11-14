// Just for fun, a bit a mastermind game!
// Developed by WooiKent Lee
// AquaQ Analytics

system"S ",8?string"j"$.z.p;							/ super random

tab:([name:`$();id:`long$()]code:();tries:`long$();stime:`time$();etime:`time$();ans:();result:());

tabpath:hsym`$-2_string .z.f;							/ path to stats

if[count key tabpath;tab:tab upsert get tabpath];		/ combine historical stats

welcome:{
	("Hello and welcome to the MasterMind game!!                                                  ";
	 "The game is simple, guess the correct 4 digit code and you win!                             ";
	 "Each time you supply an answer, you will receive a clue whether your answer is close or not.";
	 "For example, if the code is 1234 and you guess 1122, you will get the following clues:      ";
	 "1 correct character and correct position.                                                   ";
	 "1 correct character but wrong possition.                                                    "; 
	 "Hope you enjoy the game at your leisure. Use 'start' to start the game!                     ";
	 "Also use 'ghelp' for further details!\n							     					  ")
	};

bye:{
	 "\nThanks for playing! See you next time and have a good day!\n                                "
	};

start:{
	if[""~exec result 0 from tab where name in .z.u,id=max id;
		:("";
		  "You already started the game!";
		  "Your guesses were ",(","sv exec ans 0 from tab where name in .z.u,id=max id),"\n")];
	n:exec max id from tab where name in .z.u;
	if[not count select from tab where name in .z.u;n:0];
	`tab upsert `name`id`code`tries`stime`etime`ans`result!(.z.u;n+1;4?.Q.n;0;.z.t;0Nt;();"");
	("";
	 "Game started! Please supply answer. Example: Just type '1234' on the console.               ";
	 "You have 10 tries left! Good luck!!\n                                                       ")
	};

play:{
	t:exec first code from tab where name=.z.u,id in max id,result like "";
	if[not count t;'"Please start the game before supplying answer!\n"];
	if[4<>count x;'"It must be 4 digit answer!\n"];
	update tries+1,ans:enlist[last[ans],enlist x] from `tab where name=.z.u,id in max id,result like "";
	yes:count where x=t;								/ correct position and char
	po:4-yes+count({x _ x?y}/).(x;t)@\:where x<>t;		/ correct chat but wrong position
	$[yes=count t;win x;clue[yes;po]]					/ return clues
	};

win:{
	update result:enlist"solved",etime:.z.t from `tab where name=.z.u,id in max id;
	("";
	 win2`;
	 "If you want to play again, use 'start' to restart the game!\n")
	};

win2:{
	tri:exec last tries from `tab where name=.z.u,id in max id;
	$[tri=1;
		"You must be cheating, no honour for you!!";
		"Well done! You beat the game!"]
	};

clue:{
	t:exec first tries from tab where name=.z.u,id in max id,result like "";
	a:exec first code from tab where name=.z.u,id in max id,result like "";
	if[t=10;update result:enlist"end",etime:.z.t from `tab where name=.z.u,id in max id;
		:("";
		  "No more tries, you lose! :( The answer is ",a,".";
		  "If you want to play again, use 'start' to restart the game!\n")];
	("";
	 string[x]," correct character and correct position.                                                   ";
	 string[y]," correct character but wrong possition.                                                    ";
	 string[10-t]," tries left!                                                                            ";
	 raze teaser[x;y],"\n")
	};

teaser:{
	if[4=x+y;:1?("Omg you are so close, don't lose it!";
		     "Seriously?! Just solve it already!";
		     "Is it so hard to just rearrange your answer CORRECTLY??")];
	if[3=x+y;:1?("Close enough, keep up the good work!";
		     "This is not bad, better get it quickly!";
		     "Are you going to solve it soon or what?")];
	if[2=x+y;:1?("Half way there perhaps?";
		     "Well I can only give you half a credit here.";
		     "Not even sure this is going anaywhere.")];
	if[1=x+y;:1?("Come on keep your head in the game!";
		     "Nice try but not good enough!";
		     "Seriously? How hard can this be?")];
	if[0=x+y;:1?("Ah well, you need all the luck you can!";
		     "I don't think you are the material for this game";
		     "Alt+F4? It can make your life easier.")];
	};

giveup:{
        t:exec first code from tab where name=.z.u,id in max id,result like "";
        if[not count t;:enlist"\nError: You can't give up before you start a game!\n"];
	update result:enlist"giveup",etime:.z.t from `tab where name=.z.u,id in max id;
	:("";
	  "Dissapointment... Sigh...";
	  "Answer is ",t,"\n");
	};

ghelp:{
	("";
	 "Use 'start' to start a game.";
	 "Use 'giveup to give up a game.";
	 "Use 'stats' to check your progress.";
	 "Supply answer by typing 4 digits on console.";
	 "You can exit game by using 'exit' or \\\\.\n")
	};

stats:{
	tot:exec count[i] from tab where name=.z.u;
	los:exec count[i] from tab where name=.z.u,result like"end";
	win:exec count[i] from tab where name=.z.u,result like"solved";
	giv:exec count[i] from tab where name=.z.u,result like"giveup";
	st:exec "i"$r[0]%1000 from (update r:etime-stime from tab)where name=.z.u,result like"solved",r=min r;
	lt:exec "i"$r[0]%1000 from (update r:etime-stime from tab)where name=.z.u,result like"solved",r=max r;
	mis:exec tries 0 from tab where name=.z.u,result like"solved",tries=min tries;
	mas:exec tries 0 from tab where name=.z.u,result like"solved",tries=max tries;
	rat:100*win%los+win+giv;
	("";
	 "Here are your stats!\n";
	 "You have played ",string[tot]," games so far.";
	 "You lose ",string[los]," games so far.";
	 "You win ",string[win]," games so far.";
	 "You give up ",string[giv]," games so far. ",$[giv>0;"Shame :(";""],"\n";
	 "Shortest completion time is ",string[st]," sec.";
	 "Longest completion time is ",string[lt]," sec.\n";
	 "Minimum steps you take are ",string[mis]," steps.";
	 "Maximum steps you take are ",string[mas]," steps.\n";
	 "Win rate is ",string[rat],"%.\n")
	};
	
check:{
	x:-1_x;														/ take off line break char
	if[x like "start";:-1 start`];								/ check for start command
	if[x like "giveup";:-1 giveup`];      	     	  			/ check for giveup command
	if[x like "ghelp";:-1 ghelp`];								/ check for ghelp command
	if[x like "stats";:-1 stats`];								/ check for stats command
	if[0<="I"$x;:-1 @[play;x;{enlist"\nError: ",x}]];			/ check solution
	if[(x like"*exit")|(x like "\\\\");shutdown`];				/ check exit
	:-1"\nPlease use 'ghelp' to see the available commands\n";	/ ban other activities
	};

shutdown:{
	tabpath upsert tab;						/ save stats
	-1 bye`;								/ goodbye message
	exit 0;									/ exit clean
	};

.z.pi:check;

-1 welcome`;

system"";
