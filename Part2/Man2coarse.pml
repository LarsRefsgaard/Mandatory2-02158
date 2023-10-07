
#define N 8

int up = 0; 
int down = 0; 
int cars = 0; 



inline enter(Group1, Group2 ) {
	atomic {(Group1 == 0) -> 
				Group2++;
				cars++
				}	
}


inline leave(Group1) {
	atomic {
		Group1--;
		cars--
			}
}

active [N] proctype P() {
	
	do 
	::
	
		if 
		::
	  	_pid < 4 ->	enter(down, up);
			   	assert((down == 0 || up == 0) && cars >= 0 );
				leave(up)

		:: 
		  else -> 	enter(up, down);
			   	assert((down == 0 || up == 0) && cars >= 0 );
				leave(down)
		fi	
	od
}