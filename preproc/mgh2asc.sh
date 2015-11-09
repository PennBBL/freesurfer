#!/bin/bash
# creates concatenated subject ascii file from the subject level
# mgh files. Assumes your SUBJECTS_DIR variable is set.

# I hard-coded some of these things I won't change much.
hemi=$1 # lh or rh
meas=$2 #(thickness, area, volume, meancurv)
fwhm=$3 # number indicating smoothing amount
# subject list as in smoothing.sh
slist=/home/svandekar/coupling/progs/mgh2asc/freesurfer_ltn_include_n932.csv
template=fsaverage5

### CREATES THE SUBJECT LEVEL ASCIIS ###
########################################
for subject in $(cat $slist);do
	echo $subject
	infile=$(ls -d $SUBJECTS_DIR/$subject/surf/$hemi.$meas.fwhm$fwhm.$template.mgh)
	ofile=$(echo $infile | sed 's/.mgh/.asc/g')
	echo $ofile	
	mris_convert -c  $infile $SUBJECTS_DIR/fsaverage5/surf/$hemi.sphere $ofile

done



# supply list of subjects
n=`cat $slist | wc -l`
# the line below can be modified to represent the number of vertices for other template surfaces
# This is what is used for fsaverage5 space, i.e. 10242 vertices, with index numbers starting at 0
vertnames=`seq 0 10241 | tr "\n" "," | sed 's/,$//'`


echo "subject",$vertnames > $SUBJECTS_DIR/../vertex_wise_analyses/csvs/$hemi.$meas.fwhm$fwhm.$template.n$n.allvertices.csv

for i in $(cat $slist);do
	echo $i

	if [ -f $SUBJECTS_DIR/$i/surf/$hemi.$meas.fwhm$fwhm.$template.asc ]
	then
		rh_vertex=`cat $SUBJECTS_DIR/$i/surf/$hemi.$meas.fwhm$fwhm.$template.asc | cut -d " " -f 5 | tr "\n" ","`
		rh_vertex=`echo $rh_vertex | sed 's/,$//'`
		echo $i,$rh_vertex >> $SUBJECTS_DIR/../vertex_wise_analyses/csvs/$hemi.$meas.fwhm$fwhm.$template.n$n.allvertices.csv
	else
		echo "$i/$hemi.$meas.fwhm$fwhm.$template.asc : No Such File"
	fi
done
