domains
  tgl = symbol 
z = symbol  
  predicates
tanggal(tgl,tgl,tgl)
nondeterm zodiak_jan(symbol,symbol)
nondeterm zodiak_feb(symbol,symbol)
nondeterm zodiak_mar(symbol,symbol)
nondeterm zodiak_ap(symbol,symbol)
nondeterm zodiak_mei(symbol,symbol)
nondeterm zodiak_jun(symbol,symbol)
nondeterm zodiak_jul(symbol,symbol)
nondeterm zodiak_ags(symbol,symbol)
nondeterm zodiak_sep(symbol,symbol)
nondeterm zodiak_ok(symbol,symbol)
nondeterm zodiak_nov(symbol,symbol)
nondeterm zodiak_des(symbol,symbol)

clauses
tanggal(Tgl,Bl,Th):-
	readln(Tgl),
	readln(Bl),
	readln(Th).

zodiak_jan(Res,B):-
	tanggal(_,Bl,_),
	B=Bl,
	Bl="januari",
	Res="Lucu".
zodiak_feb(Res,B):-
	tanggal(_,Bl,_),
	B=Bl,
	Bl="februari",
	Res="lemayan lucu".
zodiak_mar(Res,B):-
	tanggal(_,Bl,_),
	B=Bl,
	Bl="maret",
	Res="marahan".	
zodiak_ap(Res,B):-
	tanggal(_,Bl,_),
	B=Bl,
	Bl="april",
	Res="imut".
zodiak_mei(Res,B):-
	tanggal(_,Bl,_),
	B=Bl,
	Bl="mei",
	Res="lincah".
zodiak_jun(Res,B):-
	tanggal(_,Bl,_),
	B=Bl,
	Bl="juni",
	Res="aktif".	
zodiak_jul(Res,B):-
	tanggal(_,Bl,_),
	B=Bl,
	Bl="juli",
	Res="gaul".
zodiak_ags(Res,B):-
	tanggal(_,Bl,_),
	B=Bl,
	Bl="agustus",
	Res="riang".
zodiak_sep(Res,B):-
	tanggal(_,Bl,_),
	B=Bl,
	Bl="september",
	Res="riang".
zodiak_nov(Res,B):-
	tanggal(_,Bl,_),
	B=Bl,
	Bl="november",
	Res="gila".
zodiak_des(Res,B):-
	tanggal(_,Bl,_),
	B=Bl,
	Bl="desember",
	Res="Lucu".
zodiak_ok(Res,B):-
	tanggal(_,Bl,_),
	B=Bl,
	Bl="oktober",
	Res="Lucu".
goal
  tanggal(Tgl,Bl,Th),
  zodiak_jan(Res,_).