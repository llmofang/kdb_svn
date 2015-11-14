\d .dsn
write:{[name;host;port;user;pswd] (DSN::`$":",$[count cpf:getenv`$"CommonProgramFiles(x86)";cpf;getenv`CommonProgramFiles],"\\ODBC\\Data Sources\\",(string name),".dsn")0:enlist"[ODBC]\nDRIVER=KDB+\nDBQ=",(string host),":",(string port),"\nUID=",(string user),"\nPWD=",(string pswd),"\n"}
writethisas:write[;.z.h;system"p";`;`]  / writethisas`foo
