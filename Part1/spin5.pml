/* DTU Course 02158 Concurrent Programming
 *   Lab 2
 *   spin5.pml
 *     Skeleton PROMELA model of mutual exlusion by coordinator
 */

#define N 5

bool enter[N];  /* Request to enter flags */
bool ok[N];     /* Entry granted flags    */

int incrit = 0; /* For easy statement of mutual exlusion */


/*
 * Below it is utilised that the first N process instances will get 
 * pids from 0 to (N-1).  Therefore, the pid can be directly used as 
 * an index in the flag arrays.
 */

active [N] proctype P()
{
	do
	::	/* First statement is a dummy to allow a label at start */
		skip;

entry:	
		enter[_pid] = true;
		/*await*/ ok[_pid] ->
		
crit:	/* Critical section */
		
		incrit++;
		assert(incrit == 1);
		incrit--;
  	
exit: 
		/* Your code here */
		ok[_pid] = false;
		enter[_pid] = true;
		
		
		

		/* Non-critical setion (may or may not terminate) */
		do :: true -> skip :: break od

	od;
}

active proctype Coordinator()
{
	int i = 0;
	
	do
	::	
		/*  Your code here instead of skip*/
		for (i : 0 .. N - 1) {
			if
			:: enter[i] ->  enter[i] = false;
							ok[i] = true;
							enter[i] ->	skip
							
			:: else -> skip
			fi
		} 
		i = 0;
	od
}


//fairness condition
ltl fairness_0 { [] ( P[0]@entry -> <>P[0]@crit  ) }
ltl fairness_1 { [] ( P[1]@entry -> <>P[1]@crit  ) }
ltl fairness_2 { [] ( P[2]@entry -> <>P[2]@crit  ) }
ltl fairness_3 { [] ( P[3]@entry -> <>P[3]@crit  ) }
ltl fairness_4 { [] ( P[4]@entry -> <>P[4]@crit  ) }
ltl fairness_5 { [] ( P[5]@entry -> <>P[5]@crit  ) }
ltl fairness_6 { [] ( P[6]@entry -> <>P[6]@crit  ) }
ltl fairness_7 { [] ( P[7]@entry -> <>P[7]@crit  ) }