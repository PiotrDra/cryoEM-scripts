# RELION Cryo-EM Utility Scripts

This is a set of small utility scripts that make cryo-EM data processing easier and faster, especially for RELION-based workflows.

The scripts are designed to be:

Lightweight
Safe and non-destructive
Easy to run from standard RELION directory layouts

***add_jobNo_to_Rln_jobMaps.sh***

*add_jobNo_to_Rln_jobMaps.sh* is a standalone Bash script that creates clear symbolic links containing the job number for *.mrc* output files from RELION 3D jobs. It adds the jobXXX to the final map (or class maps) names, so instead of all files being called *run_class001.mrc* (or *run_itYYY_classZZZ.mrc*), you can easily tell them apart. This makes it easier to track and identify files in ChimeraX sessions when comparing maps from different RELION jobs. 
The script works with both Refine3D and Class3D jobs. 
You should run it from the RELION project directory. 

Functionality: 
For each *Refine3D/jobXXX* (or *Class3D/jobXXX*) directory: 
The script looks for: *run_class001.mrc* (or *run_itYYY_classZZZ.mrc* from the last classification iteration, i.e., highest YYY) 
It creates a symlink in the same job directory called: *jobXXX_run_class001.mrc* (or *jobXXX_run_itYYY_classZZZ.mrc*) 
If the file is missing, the script skips that job. 
If the symlink already exists, the script skips it. 

Usage 
Navigate to your RELION project directory: 
cd /path/to/your_relion_project 
Copy the script into this directory
Make the script executable. You only need to do this the first time you use it: 
chmod +x add_jobNo_to_Rln_jobMaps.sh 
Run the script: 
./add_jobNo_to_Rln_jobMaps.sh 

Safety & Design Notes 
Uses relative symlinks, so it works across different file systems. 
It never overwrites existing files or links. 
It does not modify or delete any RELION output. 
You can safely run the script multiple times. 
The script only needs standard Unix tools: bash, sed, and sort.

***add_jobNo_to_Rln_Class3Dmaps.sh***

*add_jobNo_to_Rln_Class3Dmaps.sh* is a standalone Bash script that creates clear symbolic links with the job number for Class3D output maps from a single RELION Class3D job you choose. It adds the jobXXX prefix to all class maps from the last classification iteration, making it easier to identify and compare class maps from a specific job in ChimeraX or other visualization tools. This script is helpful when you want to focus on one Class3D job at a time instead of processing all jobs in the project. Run it from your RELION project directory.

Functionality:
For a user-specified *Class3D/jobXXX* directory:
The script will ask you for the job number (XXX) when you run it.
It looks for all *run_itYYY_classZZZ.mrc* files in the chosen job directory.
The script automatically finds the last iteration, which is the highest YYY.
For each class map from that last iteration, it creates a symlink in the same job directory called: *jobXXX_run_itYYY_classZZZ.mrc*
If no class map files are found, the script exits without making changes.
If a symlink already exists, the script skips it.

Usage
Navigate to your RELION project directory:
cd /path/to/your_relion_project
Copy the script into this directory
Make the script executable. You only need to do this the first time you use it:
chmod +x add_jobNo_to_Rln_Class3Dmaps.sh
Run the script:
./add_jobNo_to_Rln_Class3Dmaps.sh
When prompted, enter the job number (XXX) for the Class3D job you want to process.

Safety & Design Notes
Uses relative symlinks, so it works across different file systems.
It never overwrites existing files or links.
The script does not modify or delete RELION output. The script only works on a single Class3D job that you choose.ob
You can safely run the script multiple times.
The script only needs standard Unix tools: bash, sed, and sort.

***3Dclass_iteration_stats.sh***

*3Dclass_iteration_stats.sh* is a standalone Bash script that reports per-class statistics for RELION Class3D jobs. It can show data for a single iteration or for all iterations of a job, including class distributions, estimated resolutions, and changes in particle assignments, orientations, and translations. This script helps you quickly summarize the results of a classification job without having to manually check multiple STAR files. Run it from your RELION project directory.

Functionality:
For a user-specified *Class3D/jobXXX* directory:
The script will ask you for the job number (XXX) and, if you want, an iteration number (YYY).
If you specify an iteration, the script prints per-class statistics for that iteration only.
If you do not specify an iteration, it prints statistics for all iterations.

Reported iteration statistics:
Class distribution and estimated resolution for each class
Changes in particle class assignments, particle orientations, and particle X/Y translations over the course of the classification. This is useful for checking if the number of iterations was enough for the classification to converge.

Usage
Navigate to your RELION project directory:
cd /path/to/your_relion_project
Copy the script into this directory
Make the script executable. You only need to do this the first time you use it:
chmod +x 3Dclass_iteration_stats.sh
Run the script:
./3Dclass_iteration_stats.sh

Follow the prompts to enter the job number and, if you want, the iteration number. If you leave the iteration blank, the script reports statistics for all iterations.

Safety & Design Notes
Does not modify or delete any RELION output files
You can safely run the script multiple times.
Reads only standard RELION STAR files in *Class3D/jobXXX* directories
The script only needs standard Unix tools (bash and grep) and RELION’s relion_star_printtable.py

***reconstruct_focused3Dclasses.sh***

*reconstruct_focused3Dclasses.sh* is a standalone Bash script that reconstructs full 3D volumes from the results of focused 3D classification in RELION. It allows the user to select one or more classes from a Class3D job and automatically generates STAR files for those classes, followed by reconstruction using relion_reconstruct_mpi. This is useful for generating high-quality class-specific maps from focused classifications, without manually selecting particles or running separate reconstruction commands. The script should be run from the RELION project directory.

Functionality:
For a user-specified *Class3D/jobXXX* directory:
The script prompts for:

Job number (XXX)
Classes to reconstruct (up to 10, space-separated)
Pixel size (Å)
Expected resolution
Symmetry
Number of MPI processes to use

For each selected class:

Generates a STAR file containing only particles from that class
Reports the number of particles selected

Runs relion_reconstruct_mpi to produce the 3D volume (MRC) for that class
If a class is not specified, it is skipped.

Usage
Navigate to your RELION project directory:
cd /path/to/your_relion_project
Copy the script into this directory
Make the script executable (do this only once when you use the script for the first time):
chmod +x reconstruct_focused3Dclasses.sh
Run the script:
./reconstruct_focused3Dclasses.sh

Follow the prompts to specify the job number, classes, pixel size, resolution, symmetry, and number of MPI processes. The script will reconstruct each selected class automatically.

Safety & Design Notes
Does not modify or delete existing RELION output files
Only selects particles for reconstruction; original STAR and MRC files remain untouched
Safe to re-run multiple times with different class selections
Requires standard Unix tools (bash, grep) and RELION commands: relion_star_handler and relion_reconstruct_mpi

