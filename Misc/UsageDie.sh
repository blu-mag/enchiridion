#!/bin/zsh

# Usage Die Calculator
#
# Estimates the total number of uses for a Usage Die of a given size, from d4 to d10.

# die size will default to d10 unless otherwise specified
DEFAULTDIE=10
DIE="${1:-$DEFAULTDIE}"
ROLLS=0
RESULT=0

# rolling function, returns a random number between 1 and the specified die size, inclusive
roll() {
	jot -r 1 1 $1
}

while (( $DIE > 3 ))
do
	echo "Rolling D"$DIE
	while (( $RESULT != 1 ))
	do
		RESULT=$(roll $DIE)
		ROLLS=$((ROLLS+1))
		echo "D"$DIE" rolled "$RESULT
	done
	DIE=$((DIE-2))
	RESULT=0
done

echo $ROLLS" total rolls."