#!/bin/bash
REMOTE="master" # git standard is 'origin'

# Change Remote name with [-r --remote]
while getopts "f:-:" OPTION; do
	case $OPTION in
		r)
			REMOTE="$OPTARG"
		;;
		-)
			case $OPTARG in
				remote)
					REMOTE="$2"
				;;
			esac
		;;
	esac
done

# Check if valid git repo
if [ -d .git ]; then
	:
else
	echo "NOT valid git repo" >&2
	exit 1
fi

GIT_REMOTE_VERBOSE=$(git remote -v | grep -sw "fetch")

LENGTH_REMOTE=${#REMOTE}
START=$(( $LENGTH_REMOTE +1 ))
REMOVE_FROM_END=8 # length of (fetch), the grep search expr
END=$(( ${#GIT_REMOTE_VERBOSE} - $START - $REMOVE_FROM_END))

REMOTE_URI=${GIT_REMOTE_VERBOSE:$START:$END}
LOCAL_COMMIT_ID=$(git log --format="%H" -n 1)
REMOTE_COMMIT_ID=$(git ls-remote $REMOTE_URI HEAD)

REMOTE_COMMIT_ID=( $REMOTE_COMMIT_ID )
REMOTE_COMMIT_ID="${REMOTE_COMMIT_ID[0]}"

if [ "$LOCAL_COMMIT_ID" == "$REMOTE_COMMIT_ID" ]; then
	exit 0
else
	exit 1
fi

# Use "$?" to acess status code (ie. 0,1)
