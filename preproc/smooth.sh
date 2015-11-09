#!/bin/bash
# this script assumes your SUBJECTS_DIR environment variable is set and that you
# have the fsaverage5 template in your subjects directory.
# This is a list of the subjects to run
subjlist=/home/svandekar/coupling/progs/mgh2asc/freesurfer_ltn_include_n932.csv
fwhm=0
meas=thickness # sulc
template=fsaverage5

for s in $(cat $subjlist); do
	echo "smoothing $s"
	sdir=$SUBJECTS_DIR/$s
	qsub -V -b yes mris_preproc --smooth-cortex-only --s $s --hemi lh --fwhm $fwhm --meas $meas --target $SUBJECTSDIR/$template --out $sdir/surf/lh.thickness.fwhm${fwhm}.fsaverage5.mgh 
	qsub -V -b yes mris_preproc --smooth-cortex-only --s $s --hemi rh --fwhm $fwhm --meas $meas --target $SUBJECTSDIR/$template --out $sdir/surf/rh.thickness.fwhm${fwhm}.fsaverage5.mgh 
done
