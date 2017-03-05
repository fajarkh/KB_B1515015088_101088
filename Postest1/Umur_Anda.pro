/*****************************************************************************
 Project:  
 FileName: UmurAnda.PRO
 Purpose: 
 Written by: PCD
 Modifyed by: Fajar Khairumman
 Comments: 05-mar-2017
******************************************************************************/

domains
  tgl = long %membuat tgl menjadi format angka panjang (long)
  
  predicates
  tanggal(tgl,tgl,tgl,tgl,tgl,tgl,tgl,tgl) - procedure (i,i,i,i,i,i,o,o) %
nondeterm status_usia(integer,symbol) %nondeterm pada section predicates berfungsi untuk memberi
				      % tahu compiler bahwa predikat tersebut mempunyai lebih dari satu kemungkinan jawaban.
  

clauses
  tanggal(Ts,Bs,Ths,Tl,Bl,Thl,Res,Umur):-
	Res=(Ths-Thl)*365+(Bs-Bl)*30+(Ts-Tl),
	Umur=Res/365.
	
status_usia(20,S):-
       S="remaja".

status_usia(10,S):-
       S="Bocah".
       
status_usia(1,S):-
       S="Balita".
status_usia(40,S):-
       S="Tua".
	goal
  tanggal(10,4,1997,5,3,2017,Anda_hidup,Umur_anda),
  status_usia(Saat_UMUR,Status_anda),Saat_UMUR=Saat_UMUR.