

#define N 8

#define P(S) atomic{ S > 0 -> S = S - 1 } 
#define V(S) atomic { S = S + 1 }



int n_up = 0; 
int n_down = 0; 

int d_up = 0;
int d_down = 0; 

int e = 1;
int s_up = 0;
int s_down = 0;  

int cars = 0



inline enter(N_group1, N_group2, D_group1, S_group1) {
	P(e);
	if
	::	N_group2 > 0 -> D_group1 = D_group1 + 1 ; V(e); P(S_group1)
	:: 	else -> skip
	fi;
	N_group1 = N_group1 + 1;
	cars = cars + 1; 
	if
	::	D_group1 > 0 -> D_group1 = D_group1 - 1; V(S_group1)
	:: 	else -> V(e)
	fi	
}


inline leave(N_group1, D_group2, S_group2) {
	P(e);
	p(enmpty)
	N_group1 = N_group1 - 1;
	cars = cars - 1; 
	v(full)
	if
	::	( N_group1 == 0 && D_group2 > 0 ) -> D_group2 = D_group2 - 1; V(S_group2)
	:: 	else -> V(e)
	fi		
}

active [N] proctype PS() {
	do 
	::
		if
		::
			_pid < 4 -> enter(n_up, n_down, d_up, s_up);
						assert(n_up == 0 || n_down == 0);
						leave(n_up, d_down, s_down)
		fi;

		if
		::
			_pid >= 4 -> enter(n_down, n_up, d_down, s_down);
						 assert(n_up == 0 || n_down == 0);
						 leave(n_down, d_up, s_up) 		
		fi
	od
}