/*****************************************************************************

		Copyright (c) 1984 - 2000 Prolog Development Center A/S

 Project:  
 FileName: CH06E07.PRO
 Purpose: 
 Written by: PDC
 Modifyed by: Eugene Akimov
 Comments: 
******************************************************************************/

predicates
  factorial(unsigned,real) - determ (i,o)
  factorial_aux(unsigned,real,unsigned,real) - determ (i,o,i,i)

/* Numbers likely to become large are declared as reals. */

clauses
  factorial(N,FactN):- % nilai N=3 nilai FactN=?
	factorial_aux(N,FactN,1,1.0). %N=N=3 diatas , FactB=? , set 2 variabel berikutnya 1 dan 1.0

  factorial_aux(N,FactN,I,P):- 		%[perc 1] 		     N=3 , FactN=? , I=1 (settan dari clause faktorial) , P=1.0 (settan dari clause faktorial)
  					%[perc 2 , hasil dari aux.1] N=3 , FactN=? , I=2  , 				  P=1 
  					%[perc 3 , hasil dari aux.2] N=3 , FactN=? , I=3  , 				  P=2
  					%[perc 4 , hasil dari aux.3] N=3 , FactN=? , I=4  , 				  P=6 (kondisi cut terjadi)
  					
	I <= N,!, % karena I(1) <= N(3) maka lanjut ke syarat berikutnya [perc 1],
		  % karena I(2) <= N(3) maka lanjut ke syarat berikutnya [perc 2],
		  % karena I(3) <= N(3) maka lanjut ke syarat berikutnya [perc 3],
		  % karena I(4) <= N(3) maka terjadi Cut sehingga tidak terjadi backtracking sehingga functional_aux berhenti dengan kondisi falil pada percobaan ke 4
		  
	NewP = P * I,  %NewP => P(1.0) * I(1) = 1 [perc 1] 
		       %NewP => P(1.0) * I(2) = 2 [perc 2] 
		       %NewP => P(2) * I(3) = 6 [perc 3]  
		       
	NewI = I + 1,  %NewI => I(1) + 1 = 2 [perc 1]
		       %NewI => I(2) + 1 = 3 [perc 2]
		       %NewI => I(3) + 1 = 4 [perc 3]
	factorial_aux(N,FactN,NewI,NewP).  %Set I=NewI dan P=NewP , Maka isi factorial_aux(N=3,FactN=?,I=2,P=1) [aux.1]
					   %Set I=NewI dan P=NewP , Maka isi factorial_aux(N=3,FactN=?,I=3,P=2) [aux.2]
					   %Set I=NewI dan P=NewP , Maka isi factorial_aux(N=3,FactN=?,I=4,P=6) [aux.3]

  factorial_aux(N,FactN,I,P) :- % karena nilai di aux.1 (factorial_aux(N=3,FactN=?,I=2,P=1)) I nya tidak lebih besar dari N maka FactN tidak di set Jadi P
  				% karena nilai di aux.2 (factorial_aux(N=3,FactN=?,I=3,P=2)) I nya tidak lebih besar dari N maka FactN tidak di set Jadi P
  				% karena nilai di aux.3 (factorial_aux(N=3,FactN=?,I=4,P=6)) I nya lebih besar dari N maka FactN di set Jadi P Sehingga FanN=P=6
	I > N,
	FactN = P.

goal
  factorial(3,X).
% hasil dari goal terjadi saat percobaan ke 4 [perc 4] yang mana pada perc 4 terjadi cut karena nilai I = 4 yang lebih besar dari N = 3. 
% lalu karena di cut clausa  factorial_aux yang pertama terhenti dan membawa nilai aux.1 (factorial_aux(N=3,FactN=?,I=4,P=6)) 
% lalu ke factorial_aux ke dua , karena nilai I sudah lebih besar dari N maka nilai FactN di set samadengan P yaitu 6.
% karena semua rules di  factorial_aux kedua terpenuhi maka goal akan bernilai benar.
