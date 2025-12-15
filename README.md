# RELION Cryo-EM Utility Scripts

This is a set of small utility scripts that make cryo-EM data processing easier and faster, especially for RELION-based workflows.

These scripts are made to be:

-Lightweight
-Safe (non-destructive)
-Easy to run from standard RELION directory layouts

**add_jobNo_to_Rln_jobMaps.sh**

add_jobNo_to_Rln_jobMaps.sh is a standalone Bash script that creates clear symbolic links containing the job number for .mrc output files from RELION 3D jobs. It adds the jobXXX to the final map (or class maps) names, so instead of all files being called run_class001.mrc (or run_itYYY_classZZZ.mrc), you can easily tell them apart. This makes it easier to track and identify files in ChimeraX sessions when comparing maps from different RELION jobs. 
It works with both Refine3D and Class3D jobs.
You should run it from the RELION project directory.

Functionality:
For each Refine3D/jobXXX (or Class3D/jobXXX) directory:
The script looks for: run_class001.mrc (or run_itYYY_classZZZ.mrc from the last classification iteration, i.e., higest YYY)
It creates a symlink in the same job directory called: jobXXX_run_class001.mrc (or jobXXX_run_itYYY_classZZZ.mrc)
If the file does not exist, the script skips that job.
If the symlink already exists, it is skipped.

Usage
Navigate to your RELION project directory:
cd /path/to/your_relion_project
Make the script executable (do this only once when you use the script first time):
chmod +x add_jobNo_to_Rln_jobMaps.sh
Run the script:
./add_jobNo_to_Rln_jobMaps.sh

Safety & Design Notes
Uses relative symlinks (portable across file systems)
Never overwrites existing files or links.
Does not modify or delete RELION output
Safe to re-run multiple times
Requires only standard Unix tools (bash, sed, sort)


