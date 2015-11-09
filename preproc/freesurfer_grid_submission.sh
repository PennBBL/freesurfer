#!/bin/bash
. /etc/bashrc
list=$1
line=$(sed -n "${SGE_TASK_ID}p" $list)
# These should all be set in your environment variables
#export FREESURFER_HOME="/import/monstrum/Applications/freesurfer5_0"
#export SUBJECTS_DIR=$(echo $line | cut -d"," -f3)
#export SUBJECTS_DIR=/import/monstrum/eons_xnat/group_results_n1445/freesurfer/working_subjects/
#export PERL5LIB="/import/monstrum/Applications/freesurfer/mni/lib/perl5/5.8.5"
#export PATH=$FREESURFER_HOME/bin:$PATH
sid=$(echo $line | cut -d, -f1)
mprage=$(echo $line | cut -d, -f2)
outdir=$(echo $line | cut -d, -f3)

	echo $mprage
	echo $subjid

	# saves into your SUBJECTS_DIR under the folder $subjid
	$FREESURFER_HOME/bin/recon-all -i $mprage -subjid $subjid
	# registers the data to fsaverage5 space and smooths at various smoothing levels
	recon-all -subjid $mprage -qcache  -target fsaverage5 -measure thickness -measure sulc
