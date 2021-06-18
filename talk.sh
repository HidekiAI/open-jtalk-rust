#!/bin/bash
#	Parm1: input text file to read from
# 	Parm2: Optional output wav file (i.e. /tmp/foo.wav)
WAV_FILE=$2
if [ "$WAV_FILE" = "" ] ; then
	WAV_FILE=/tmp/output.wav
fi
echo "Using output file $WAV_FILE"
DICT_UTF8=/var/lib/mecab/dic/open-jtalk/naist-jdic/

# Now just call it (we'll use "-ow" for wav)
# cat $1 | open_jtalk -td tree-dur.inf -tf tree-lf0.inf -tm tree-mgc.inf -md dur.pdf -mf lf0.pdf -mm mgc.pdf -df lf0.win1 -df lf0.win2 -df lf0.win3 -dm mgc.win1 -dm mgc.win2 -dm mgc.win3 -cf gv-lf0.pdf -cm gv-mgc.pdf -ef tree-gv-lf0.inf -em tree-gv-mgc.inf -k gv-switch.inf -ow $WAV_FILE -x /var/lib/mecab/dic/open-jtalk/naist-jdic/
VOICE_DIR=/usr/share/hts-voice/nitech-jp-atr503-m001/
VOICE=$VOICE_DIR/nitech_jp_atr503_m001.htsvoice
VOICE=./data/mei/mei_bashful.htsvoice
open_jtalk \
	-x $DICT_UTF8 \
	-m $VOICE \
	$1 \
	-ow $WAV_FILE
aplay $WAV_FILE
rm $WAV_FILE

VOICE_DIR=/usr/share/hts-voice/mei_normal/

# First, go to the location where model tree definitions reside
cd $VOICE_DIR

for line in $(echo $1 | sed 's/。/\n/g') ; do
	echo "$line"

	echo "$line" | open_jtalk \
		-td $VOICE_DIR/tree-dur.inf \
		-tf $VOICE_DIR/tree-lf0.inf \
		-tm $VOICE_DIR/tree-mgc.inf \
		-md $VOICE_DIR/dur.pdf \
		-mf $VOICE_DIR/lf0.pdf \
		-mm $VOICE_DIR/mgc.pdf \
		-df $VOICE_DIR/lf0.win1 \
		-df $VOICE_DIR/lf0.win2 \
		-df $VOICE_DIR/lf0.win3 \
		-dm $VOICE_DIR/mgc.win1 \
		-dm $VOICE_DIR/mgc.win2 \
		-dm $VOICE_DIR/mgc.win3 \
		-ef $VOICE_DIR/tree-gv-lf0.inf \
		-em $VOICE_DIR/tree-gv-mgc.inf \
		-cf $VOICE_DIR/gv-lf0.pdf \
		-cm $VOICE_DIR/gv-mgc.pdf \
		-k  $VOICE_DIR/gv-switch.inf \
		-s 48000 \
		-p 240 \
		-a 0.58 \
		-u 0.0 \
		-jm 0.7 \
		-jf 0.5 \
		-l \
		-z 48000 \
		-x $DICT_UTF8 \
		-ow $WAV_FILE \
		-ot /tmp/jtalk_out.log

	# Now play it using VLC
	#cvlc $WAV_FILE
	aplay $WAV_FILE

done
