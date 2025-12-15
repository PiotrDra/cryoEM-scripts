#!/bin/bash

# by Piotr Draczkowski 2021-03-23


echo 'This script will report per class statistics after a given iteration of a classification job eg. iteration 007 Or from all the iterationsc'
echo ' '
echo 'IMPORTANT: This script should be executed from the Relion project directory (i.e. from which you execute relion command)'
echo ' '
echo 'specify job number (example: 045)'
read job_no

echo 'specify the iteration number (example: 025) OR leave it empty if you want to print the stats for all the iterations' 
read it_no

if [ -z "$it_no"]
then
	#run relion_star_printtable.py for all *model.star in the job directory ie. show stats from all the iterations
	for i in Class3D/job${job_no}/*model.star
	do
	echo ' '
	echo 'per class statistics in' $i
	echo '#1class name #2ClassDistribution #3EstimatedResolution'
	echo ' '
	relion_star_printtable ${i} data_model_classes rlnReferenceImage rlnClassDistribution rlnEstimatedResolution
	done
	echo ' '
	echo 'Changes in the particles class assignment over the course of the classification'
	grep rlnChangesOptimalClasses Class3D/job${job_no}/*optimiser.star
	echo ' '	
	echo 'Changes in the particles orientations over the course of the classification'
	grep rlnChangesOptimalOrientations Class3D/job${job_no}/*optimiser.star
	echo ' '
	echo 'Changes in the particles X/Y translations over the course of the classification'
	grep rlnChangesOptimalOffsets Class3D/job${job_no}/*optimiser.star
else
	#run relion_star_printtable.py with the user inputted iteration number
	echo ' '
	echo 'per class statistics in '$it_no
	echo '#1 class name #2 ClassDistribution #3 EstimatedResolution'
	echo ' '
	relion_star_printtable Class3D/job${job_no}/run_it${it_no}_model.star data_model_classes rlnReferenceImage rlnClassDistribution rlnEstimatedResolution
fi

