#!/bin/sh

# This script was authored by MirrorMatter.  Use and/or modify and/or distribute it however you'd like, though I'd appreciate a shout-out if it's the latter.

# The purpose of this script is to produce a high-quality DVD rip while minimizing file size; it doesn't give you comprehensive options for ripping.  It makes best guesses about which title of the DVD contains the main content, which audio track is to be used (and will encode it in stereo), and how subtitles should be handled based on the language of the audio track.

# Requirements for this to work:  sudo permissions (to mount $HOME/temp into tmpfs; if you don't want that, eliminate lines 36-39 and 42-52), Bourne Shell or Bash, HandBrakeCLI, and lsdvd.  The latter two are probably available in your distribution's repository but, if not, you can retrieve them from https://handbrake.fr/ and http://sourceforge.net/projects/lsdvd/, respectively.  If you want to rip encrypted DVDs, you will also need libdvdcss.  If you want to automatically preview the test clip, you will need VLC installed.

# This script will look for a $HOME/rips and a $HOME/temp directory and create them if they are not found.  It will also mount $HOME/temp into RAM because I feel that's a good place for the HandBrake log and the test clip to go (a test clip will consume fewer than 100 megabytes of space).  If you want that data stored on your hard drive, instead, you can safely delete lines 36-39 and 42-52.

# Expect rips to take a LONG time.  Depending on your CPU, this can take as long as playing the movie in real time, or longer.  You can minimze this time by making sure you're not running any CPU-intensive applications concurrently with this script and making sure nothing causes your CPU frequency scaling to kick in.

if
	! `command -v lsdvd > /dev/null` && ! `command -v HandBrakeCLI > /dev/null`;
		then
			echo -e "\nYou must install both lsdvd and HandBrakeCLI before this script will work.\n\n";
			exit;

elif
	! `command -v lsdvd > /dev/null`;
		then
			echo -e "\nYou must install lsdvd before this script will work.\n\n";
			exit;

elif
	! `command -v HandBrakeCLI > /dev/null`;
		then
			echo -e "\nYou must install HandBrakeCLI before this script will work.\n\n"
			exit;
elif
	! `command -v lsdvd > /dev/null`;
		then
			echo -e "\nYou must install lsdvd before this script will work.\n\n"
			exit;

fi

if
	[ ! -d "$HOME/temp" ];
		then
			echo -e "\n$HOME/temp does not exist.  Creating it now.";
			mkdir $HOME/temp;
			echo -e "\nMounting $HOME/temp into tmpfs.\n"
			sudo mount -t tmpfs mode=0777,noatime $HOME/temp;
			echo -e "\n$(tput bold)It is recommended that you add the following line to your /etc/fstab file for future rips:
			\ntmpfs\t$HOME/temp\ttmpfs\tmode=0777,noatime\t0\t0$(tput sgr0)\n";
fi

findmnt $HOME/temp > /dev/null;

	if [ $? != 0 ];

		then
			echo -e "\nMounting $HOME/temp into tmpfs.\n"
			sudo mount -t tmpfs mode=0777,noatime $HOME/temp;
			echo -e "\n$(tput bold)It is recommended that you add the following line to your /etc/fstab file for future rips:
			\ntmpfs\t$HOME/test\ttmpfs\tmode=0777,noatime\t0\t0$(tput sgr0)\n";

	fi

if

	[ ! -d "$HOME/rips" ]
		then
			echo -e "\n$HOME/rips does not exist.  Creating it now.\n";
			mkdir $HOME/rips;
fi

echo -e "\nGathering data...\n";

dev="$(lsblk -p | awk '/rom/ {print $1}')";

lsdvd $dev > /dev/null 2>&1;

	if [ $? != 0 ]

		then
			echo -e "\nNo data found.  Please make sure that you've inserted a playable DVD and that your optical drive is working.\n"
			exit

	fi

name="$(lsdvd $dev 2>/dev/null | awk 'NR==1 {print $3}' | sed 's/.*/\L&/; s/[a-z]*/\u&/g; s/_/ /g')";

title="$(lsdvd $dev 2>/dev/null | awk 'END{print $3}')";

audio=$(lsdvd -a -t $title $dev 2>/dev/null | awk '/Audio: 1/ {print $6}' | sed 's/,//');

# if you want subtitles burned in use option 'burned' instead of 'default'

if [[ "$audio" != "English" ]];

	then

		strack="default";

	else

		strack="default";
fi

subtitle="$(lsdvd -s -t $title $dev 2>/dev/null | grep English | awk 'NR==1 {print $2}' | sed 's/,//')";

echo -e "\nThe name of the disc is $name.\nThe title to be encoded is $title.\nThe audio track is in $audio.\nThe subtitles will be encoded as $strack.\n";

read -p $'\n'"Do you want to change the name of the rip, now? [y/N]"$'\n> '

if [[ $REPLY =~ ^[Yy] ]];

	then

		read -ep $'\nEnter what you want the rip to be named: ' name;

fi

read -p $'\n'"Do you want to change the subtitle track? [y/N]"$'\n> '

if [[ $REPLY =~ ^[Yy] ]];

	then

		read -ep $'\nEnter the subtitle track you want encoded: ' subtitle;

fi

read -p $'\n'"Do you want to make a test clip for `echo $name`, first? [Y/n]"$'\n> '

if [[ $REPLY =~ ^[Nn] ]];

	then

		echo -e "\nOkay.  Encoding title $title, now.  This will take a while.\n\n";

		HandBrakeCLI -t $title -i $dev -o ~/rips/"$name".mp4 -2 -O --vfr -e x264 -x me=tesa:subme=9:no-fast-pskip:no-dct-decimate:open-gop -b 896k -E av_aac -B 128 -6 stereo -5 -s $subtitle --subtitle-$strack $subtitle 2>~/temp/"$name".log;

		echo -e "\n$name.mp4 has been placed in $HOME/rips/.\n";


	else

		echo -e "\nEncoding chapter 02 of title $title, now.  This will take a few minutes.\n\n";

		HandBrakeCLI -t $title -c 02 -i $dev -o ~/temp/"$name"-c2.mp4 -2 -O --vfr -e x264 -x me=tesa:subme=9:no-fast-pskip:no-dct-decimate:open-gop -b 896k -E av_aac -B 128 -6 stereo -5 -s $subtitle --subtitle-$strack $subtitle 2>~/temp/"$name"-c2.log;
	
		vlc ~/temp/"$name"-c2.mp4 > /dev/null 2>&1 &
	
		read -p $'\n'"Clip has been placed in $HOME/temp/$name-c2.mp4.  Do you want to rip the entire title, now? [Y/n]"$'\n> '
	
		if [[ $REPLY =~ ^[Nn] ]];
	
			then
	
				echo -e "\nExiting.\n";
	
			else

				echo -e "\nEncoding title $title, now.  This will take a while.\n\n";
	
				HandBrakeCLI -t $title -i $dev -o ~/rips/"$name".mp4 -2 -O --vfr -e x264 -x me=tesa:subme=9:no-fast-pskip:no-dct-decimate:open-gop -b 896k -E av_aac -B 128 -6 stereo -5 -s $subtitle --subtitle-$strack $subtitle 2>~/temp/"$name".log;

				echo -e "\n$name.mp4 has been placed in $HOME/rips/.\n";

		fi

fi

echo -e "\nThe script for $name has exited.\n\n"
