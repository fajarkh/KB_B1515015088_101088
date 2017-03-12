predicates 
	nondeterm
	pemerintahan(symbol,long) %jabatan dan gaji
	nondeterm
	orang(symbol,symbol,long) %nama, jabatan dan pendapatannya
	nondeterm
	kasus_bersalah(symbol,symbol,symbol) %nama
	nondeterm
	kasus_takbersalah(symbol,symbol,symbol)
	nondeterm
	pelaku(symbol)
clauses
	orang(yahya,dpr,20000000).
	orang(andre,tni,20000000).		%orang2 beserta gajihnya
	orang(yopan,dpr,20000000).
	
	pemerintahan(dpr,20000000).
	pemerintahan(mpr,35000000).
	pemerintahan(tni,1000000).
	pemerintahan(gubernur,15000000).	%gaji standar dari setiap jabatan dalam pemerintahan
	pemerintahan(presiden,10000000).
	pemerintahan(mulung,15000000).

pelaku(yahya). %orang2 yang dicurigai
pelaku(andre).	%orang2 yang dicurigai

	kasus_bersalah(Nama,Jabatan,Status):-
		pelaku(P),
		orang(N,J,G),
		N=P,
		pemerintahan(J,Gk),			%fungsi untuk menganalisis apakah pelaku yg di curigai bersalah
		G>Gk,
		Nama=N,
		Jabatan=J,
		Status="Bersalah".
		
	kasus_takbersalah(Nama,Jabatan,Status):-
		orang(N,J,G),
		pelaku(P),
		N=P,
		pemerintahan(J,Gk),			%fungsi untuk menganalisis apakah pelaku yg di curigai tak bersalah
		G=Gk,
		Nama=N,
		Jabatan=J,
		Status="Tak_Bersalah".
goal
	kasus_bersalah(Nama,Jabatan,Status); 	%goalnya akan memanggil fungsi bersalah atau tidak bersalah ke pada para pelaku lalu di tampilkan hasilnya
	kasus_takbersalah(Nama,Jabatan,Status).