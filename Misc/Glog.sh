#!/bin/bash

# dice rolling function
# first argument is number of dice
# second is die size
roll() {
	DICE=$1
	DIE=$2
	RESULT=""
	RESULTS=""
	TOTAL=""
	echo "Rolling "$1"d"$2"…"
	while (($DICE > 0)); do
		RESULT=$(jot -r 1 1 $DIE)
		RESULTS+="$RESULT "
		TOTAL=$(($TOTAL + $RESULT))
		DICE=$(($DICE-1))
	done
	echo "Roll results "$RESULTS
	echo "Total is "$TOTAL
}

# glog magic dice rolling
# since a magic die is 50/50 chance to be expended or not, we can simulate a d2 coin flip
# on a 1, the die is expended and the total number available is reduced by 1
# on a 2, the die is kept, no change in the number of dice available
# this tells us how many rolls we can expect given a total starting pool
glogTotal () {
	MAGICDICE=$1
	STARTINGMAGICEDICE=$MAGICDICE
	while (($MAGICDICE > 0)); do
		echo $MAGICDICE" magic dice remaining."
		roll 1 2
		GLOGROLLS=$(($GLOGROLLS+1))
		if [ $RESULT == 1 ]; then
			MAGICDICE=$(($MAGICDICE-1))
			echo "Rolled "$RESULT", magic dice reduced."
			echo ""
		elif [ $RESULT == 2 ]; then
	 		echo "Rolled "$RESULT", magic dice maintained."
			echo ""
		fi
	done
	if (($MAGICDICE == 0)); then
		echo "All done, no more magic dice. "$GLOGROLLS" total magic dice rolled from an initial count of "$STARTINGMAGICEDICE"."
	fi
}

# tells how many dice were kept for a spell cast using a given number of magic dice
glogSpell () {
	roll $1 2
	KEPTDICE=$(echo $RESULTS | tr -cd '2' | wc -c)
	echo "For a spell using "$1" magic dice,"$KEPTDICE" were kept."
}