
#define N 8

# define P(S) atomic{ S > 0 -> S = S - 1}
# define V(S) atomic{ S = S + 1 }


int S_up = 1;
int S_down = 1; 

int up = 0; 
int down = 0;

inline enter(Numb) {

	int temp = 0; 
	if

	:: Numb < 4 -> 
		P(S_down);
		if 
		:: down == 0 -> P(S_up)
		:: else -> skip
		fi 
		temp = down;
		down = temp + 1;
		V(S_down)

	:: Numb >= 4 -> 
		P(S_up);
		if 
		:: up == 0 -> P(S_down) 
		:: else -> skip
		fi
		temp = up;
		up = temp + 1;
 		V(S_up)
	fi

}


inline leave(Numb) {
	
int temp = 0; 
	if

	:: Numb < 4 -> 
		temp = down; 
		down = temp - 1;
		if 
		:: down == 0 -> V(S_up) 
		:: else -> skip
		fi

	:: Numb >= 4 -> 
		temp = up;
		up = temp -1;
		if 
		:: up == 0 -> V(S_down) 
		:: else -> skip
		fi

	fi
}

active [N] proctype Cars() {
	do 
	::
		enter(_pid);
		assert(down == 0 || up == 0);
		leave(_pid)
	od
}