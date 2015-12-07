% HW 4 for CSC344


%% -- gets glads and doves and initializes lists and values --

start(Glads,Doves):-
  write('Probabilities for '),print(Glads),write(' gladiators with '),print(Doves),write(' doves...'),nl,
  write('-----------------------------------------------------------------------'),nl,
  combos(Glads,Combo),Plusone is Glads + 1,Doors is 7, Odoors is Doors,
  makelist(Plusone,0,ProbList),makelist(Plusone,0,MasterList),makelist(Plusone,0,Final),
  Prob is Doves / Doors, TotalProb is 1,Count is 0, Oprob is Prob,
  onerun(Doves,Doors,Odoors,Combo,Prob,TotalProb,ProbList,MasterList,Final,Count).


%% -- handles outer-list, resets values between running processing predicates --
onerun(Doves,Doors,Odoors,[Head|Tail],Prob,TotalProb,ProbList,MasterList,Final,Count) :- Head = [],
  length(Final, L),
  finalprint(Final,0,L).

  
onerun(Doves,Doors,Odoors,[Head|Tail],Prob,TotalProb,ProbList,MasterList,Final,Count) :- Tail = [],
  Doors is Odoors, Prob is Doves / Doors, TotalProb is 1, Count is 0,
  processList(Doves,Doors,_,Head,Prob,TotalProb,ProbList,MasterList,Final,Count).
onerun(Doves,Doors,Odoors,[Head|Tail],Prob,TotalProb,ProbList,MasterList,Final,Count) :- Head \= [],
  Doors is Odoors, Prob is Doves / Doors, TotalProb is 1, Count is 0,
  processList(Doves,Doors,Tail,Head,Prob,TotalProb,ProbList,MasterList,Final,Count).

%% -- printing -- 
 
finalprint([Fhead|Ftail],Index,Length):-
  Lp1 is Length + 1,
  Index < Lp1, Index2 is Index + 1,
  write('The probability that '), write(Index), write(' gladiators live is: '),
  write(Fhead),X is rationalize(Fhead), rational(X,N,D),
  
  write('   or '),format('(~d/~d)',[N,D]),nl,
  finalprint(Ftail,Index2,Length).
finalprint([Fhead|Ftail],Index,Length):- !.
 

%% -- finds the probability for a single sublist --  
  
processList(Doves,Doors,UpperTail,[SubHead|SubTail],Prob,TotalProb,ProbList,MasterList,Result,Count):- SubHead = 0, SubTail = [],
  TempProb is TotalProb * (1 - Prob),
  replace(Count,TempProb,ProbList,Temp),
  list_sum(Temp,Result,Final),
  onerun(Doves,7,7,UpperTail,_,_,ProbList,Temp,Final,_).
  
  
processList(Doves,Doors,UpperTail,[SubHead|SubTail],Prob,TotalProb,ProbList,MasterList,Result,Count):- SubHead = 1, SubTail = [],
  TempCount is Count + 1,
  TempProb is TotalProb * Prob,
  updateDoors(Doves,Doors,NewDoors), 
  NewProb is (Doves / NewDoors),
  replace(TempCount,TempProb,ProbList,Temp),
  list_sum(Temp,Result,Final),
  onerun(Doves,7,7,UpperTail,_,_,ProbList,Temp,Final,_). 

  
processList(Doves,Doors,UpperTail,[SubHead|SubTail],Prob,TotalProb,ProbList,MasterList,Result,Count):- SubHead = 1,SubHead \= [],
  TempCount is Count + 1,
  TempProb is TotalProb * Prob,
  updateDoors(Doves,Doors,NewDoors),
  NewProb is (Doves / NewDoors),
  processList(Doves,NewDoors,UpperTail,SubTail,NewProb,TempProb,ProbList,MasterList,Result,TempCount).
  
processList(Doves,Doors,UpperTail,[SubHead|SubTail],Prob,TotalProb,ProbList,MasterList,Result,Count):- SubHead \= [],SubHead = 0,
  TempProb is TotalProb * (1 - Prob),
  processList(Doves,Doors,UpperTail,SubTail,Prob,TempProb,ProbList,MasterList,Result,Count).
  

  
  
%% --updates number of doors--
  
updateDoors(Doves,Doors,NewDoors):- Doors > Doves,
  NewDoors is Doors - 1.  
updateDoors(Doves,Doors,NewDoors):- NewDoors is Doves.

  
%% --utilities--  

list_sum([],[],[]).
list_sum([H1|T1],[H2|T2],[X|L3]):-list_sum(T1,T2,L3), X is H1+H2.

replace(0,Object,[_|T],[Object|T]).
replace(ListPosition,Object,[H|T1],[H|T2]) :-
  K is ListPosition - 1,
  replace(K,Object,T1,T2).


makelist(0,_,[]).
makelist(Length,Element,[Element|Rest]) :-
  K is Length - 1,
  makelist(K,Element,Rest).
  
writelist([]).
writelist([H|T]) :- write(H),nl,writelist(T).

item(N,[H|_],H) :- N is 0.
item(N,[_|T],E) :- N > 0, K is N - 1,item(K,T,E).
  
try([],[]).
try([L|Ls],[M|Ms]):-
    member(M,L),
    try(Ls,Ms).

all(L,All) :- findall(M, try(L,M), All).  

combos(1,Combo) :- all([[0,1]],Combo).
combos(2,Combo) :- all([[0,1],[0,1]],Combo).
combos(3,Combo) :- all([[0,1],[0,1],[0,1]],Combo).
combos(4,Combo) :- all([[0,1],[0,1],[0,1],[0,1]],Combo).
combos(5,Combo) :- all([[0,1],[0,1],[0,1],[0,1],[0,1]],Combo).
combos(6,Combo) :- all([[0,1],[0,1],[0,1],[0,1],[0,1],[0,1]],Combo).
combos(7,Combo) :- all([[0,1],[0,1],[0,1],[0,1],[0,1],[0,1],[0,1]],Combo).
combos(8,Combo) :- all([[0,1],[0,1],[0,1],[0,1],[0,1],[0,1],[0,1],[0,1]],Combo).
combos(9,Combo) :- all([[0,1],[0,1],[0,1],[0,1],[0,1],[0,1],[0,1],[0,1],[0,1]],Combo).
combos(10,Combo) :- all([[0,1],[0,1],[0,1],[0,1],[0,1],[0,1],[0,1],[0,1],[0,1],[0,1]],Combo).
combos(11,Combo) :- all([[0,1],[0,1],[0,1],[0,1],[0,1],[0,1],[0,1],[0,1],[0,1],[0,1],[0,1]],Combo).
combos(12,Combo) :- all([[0,1],[0,1],[0,1],[0,1],[0,1],[0,1],[0,1],[0,1],[0,1],[0,1],[0,1],[0,1]],Combo).


