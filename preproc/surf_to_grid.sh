#!/bin/bash
# This script assumes you've set your SUBJECTS_DIR environment variable
# subject list
slist=/import/monstrum/eons_xnat/group_results_n1445/freesurfer/subject_lists/short_list.csv
# logs in home directory
logs=~/eons_fs_logs
mkdir $logs 2>/dev/null
# remove old logs
rm -f $logs/*.[eo]*
datestr=$(date | sed "s/ \+/ /g" | cut -d" " -f4 | sed "s/://g")
# will loop over this list
templist=$logs/templist_${datestr}.txt

# remove temp list if, for some reason, it exists already.
if [ -e $templist ]; then rm -f $templist; fi
for i in $slist;do
	# subject variable
	subjid=$i
	outdir=$SUBJECTS_DIR/$subjid
	mprage=$( ls /directory/to/your/mprages/$subjid/mprage.nii.gz 2>/dev/null)
	if [ -z $mprage ]; then
		echo "can't find image for $subjid."
	else # run the subject
		echo going to run $mprage and output to $outdir
		echo $subjid,$mprage,$outdir >> $templist
	fi
done
	nlist=$(cat $templist | wc -l)
	qsub -V -q all.q -o $logs -e $logs -t 1-$nlist /path/to/freesurfer_grid_submission.sh $templist
