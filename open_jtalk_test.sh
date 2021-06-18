#!/bin/bash
#	Parm1: input text file to read from
# 	Parm2: Optional output wav file (i.e. /tmp/foo.wav)
WAV_FILE=/tmp/output.wav
for line in $(cat $1) ; do
	sh talk.sh $line $WAV_FILE

	# finally, remove the file
	rm $WAV_FILE
done

