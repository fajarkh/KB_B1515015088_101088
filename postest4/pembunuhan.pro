/*****************************************************************************

		Copyright (c) 1984 - 2000 Prolog Development Center A/S

 Project:  
 FileName: CH04E12.PRO
 Purpose: 
 Written by: PDC
 Modifyed by: Eugene Akimov
 Comments: 
******************************************************************************/

trace
domains
  name,sex,occupation,vice,object,substance = symbol     %atur tipe beberapa variabel
  age=integer

predicates
  person(name,age,sex,occupation) - nondeterm (o,o,o,o), nondeterm (i,o,o,i), nondeterm (i,o,i,o)
  had_affair(name,name) - nondeterm (i,i), nondeterm (i,o) %punya urusan/berkaitan
  killed_with(name,object) - determ (i,o)
  killed(name) - procedure (o)
  killer(name) - nondeterm (o)
   motive(vice) - nondeterm (i)
  smeared_in(name,substance) - nondeterm (i,o), nondeterm (i,i)
  owns(name,object) - nondeterm (i,i)
  operates_identically(object,object) - nondeterm (o,i)
  owns_probably(name,object) - nondeterm (i,i)
 nondeterm suspect(name) 

/* * * Facts about the murder * * */
clauses
  person(bert,55,m,carpenter).
  person(allan,25,m,football_player).
  person(allan,25,m,butcher).
  person(john,25,m,pickpocket).

% orang2 yg punya hubungan percintaan
  had_affair(barbara,john). 
  had_affair(barbara,bert).
  had_affair(susan,john).

  killed_with(susan,club). %dubunuh dengan senjata tongkat
  killed(susan). %yg terbunuh

  motive(money).
  motive(jealousy).
  motive(righteousness).

  smeared_in(bert,blood).
  smeared_in(susan,blood). 
  smeared_in(allan,mud).
  smeared_in(john,chocolate).
  smeared_in(barbara,chocolate).
  
%  own(allan,football_boot).
  owns(bert,wooden_leg). %bert punya wooden leg yg nyatanya bisa dijadikan pentungan. 
  owns(john,pistol).

/* * * Background knowledge * * */
%barang2 yg cara kerjanya mirip dgn senjata
  operates_identically(wooden_leg, club). %wooden log (kaki palsu) cara kerjanya mirip pentungan
  operates_identically(bar, club).
  operates_identically(pair_of_scissors, knife).
  operates_identically(football_boot, club).


% kemungkinan milik
  owns_probably(X,football_boot):-
	person(X,_,_,football_player).
  owns_probably(X,pair_of_scissors):-
	person(X,_,_,hairdresser).
  owns_probably(X,Object):-
	owns(X,Object).

/* * * * * * * * * * * * * * * * * * * * * * *
 * Suspect all those who own a weapon with   *
 * which Susan could have been killed.       *
 * * * * * * * * * * * * * * * * * * * * * * */
% dugaan2 yg orang2 punya senjata yang senjata itu mirip dengan senjata meneyeb terbunuhnya susan
  suspect(X):-
	killed_with(susan,Weapon) ,		% cek senjata yg digunakan (senjatanya=pentungan)
	operates_identically(Object,Weapon) ,	% cek senjata yg mirip cara kerjanya dgn pentungan
	owns_probably(X,Object).

/* * * * * * * * * * * * * * * * * * * * * * * * * *
 * Suspect men who have had an affair with Susan.  *
 * * * * * * * * * * * * * * * * * * * * * * * * * */
% orang2 yg dicurigai berselingkuh dengan susan
  suspect(X):-
	motive(jealousy), %motiv cemburu
	person(X,_,m,_), % seseorang laki2		%bert bukan org yg tak berselingkuh dgn bert
	had_affair(susan,X). % yg

/* * * * * * * * * * * * * * * * * * * * *
 * Suspect females who have had an       *
 * affair with someone that Susan knew.  *
 * * * * * * * * * * * * * * * * * * * * */
% dicurigai perempuan  yg selinggkuh dgn laki2 selingkuhan susan
  suspect(X):-
	motive(jealousy), %motif cemburu
	person(X,_,f,_), %cek perempuan2
	had_affair(X,Man), % yg punya hubungan perselngkuhan dengan laki2
	had_affair(susan,Man). %  yg juga selingkuh dengan susan

/* * * * * * * * * * * * * * * * * * * * * * * * * * *
 * Suspect pickpockets whose motive could be money.  *
 * * * * * * * * * * * * * * * * * * * * * * * * * * */
% dicurigai mencopet yg ingin uang
  suspect(X):-
	motive(money),
	person(X,_,_,pickpocket).

  killer(Killer):-    %program akan melacak data data yang cocok dengan goal2 hasil yg nanti didapatkan akan di simpan pada variabel Killer
	person(Killer,_,_,_),  %panggil subgoal pertama maka cek orang(Pembunuh,_,_,_),
	killed(Killed), %cek yang terbunuh dan hasilnya adalah susan yg terbunuh
	Killed <> Killer, /* pernyatan korban tidak bunuh diri */
	suspect(Killer), % lalu orang2 yg tadi di panggil di syarat pertama di cek melalui kecurigaan2 yg ada di clause
	smeared_in(Killer,Goo), %cek bukti apakah yg dicurigai ternodai darah
	smeared_in(Killed,Goo). %cek lagi

goal
  killer(X).
% dari banyaknya orang  prolog mencari dari bebrapa kecurigaan,
% cek orang2 yg pertama adalah bert
% cek siapa yg terbunuh, yg terbunuh adalah susan
% tersangka bukanlah korban , (artinya korban tidak bunuh diri)
% cek bert ke semua kecurigaan2
% di kecurigaan pertama cek setiap orang yg memiliki barang yg bisa dijadikan pentungan
% saat dicek kecuriggan alat yg mirip dgn pentungan, bert terindikasi mempunyai alat tersebut yaitu wooden leg
% lalu cek apakah ada bukti darah di tubuhnya, dan ternyata bert dan susan ternodai oleh darah, namun karena pembunuh bukan yg terbunuh, maka bert lah yg menjadi tersangka

% dari program ini prolog melakukan backtrackingpada saat "smeared_in(Killed,Goo)" yg kedua, karena susan juga ternodau darah namun di pernyaan diatasnya bahwa korban (susan) tidak mati bunuh diri.
% karena banyak kecurigaan2 yg dibuat, orang2 yg di lacak akan melalui kemungkinan2 tersebut, kaau org pertama tak memenuhi syarat amaka akan melakukan backtracking lagi ke orang berikutnya.