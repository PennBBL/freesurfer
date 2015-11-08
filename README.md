# freesurfer
bbl freesurfer scripts

preproc/surf_to_grid.sh
submits freesurfer preprocessing to SGE.

preproc/freesurfer_grid_submission.sh
run on the grid. Runs freesurfer, and also registers to fsaverage5 template and smooths.

preproc/smooth.sh:
Not necessary to run because script above runs this.
Registers subject surfaces to fsaverage5 template and smooths the surfaces in template space.

preproc/mgh2asc.sh:
Converts freesurfer fsaverage5 surfaces to a combined csv file
