#!/bin/bash
# Combined script to create symlinks for Refine3D and Class3D jobXXX folders
# Run from relion_parent directory
#
# Usage:
#   1. Navigate to your relion_parent directory (the folder containing Refine3D and Class3D)
#   2. Make the script executable if not already:
#        chmod +x relion_combined_symlinks.sh
#   3. Run the script:
#        ./relion_combined_symlinks.sh
#
# Functionality:
#   - Refine3D/jobXXX: creates symlinks for run_class001.mrc files named jobXXX_run_class001.mrc
#   - Class3D/jobXXX: creates symlinks for all run_itXXX_classXXX.mrc files from the last iteration
#       named jobXXX_run_itXXX_classXXX.mrc
#   - Skips files or symlinks that do not exist or already exist

###########################
# Part 1: Refine3D/jobXXX #
###########################
# Define the folder containing Refine3D job directories
REFINE_DIR="Refine3D"

# Check if Refine3D folder exists
if [ -d "$REFINE_DIR" ]; then
    # Loop over each jobXXX folder inside Refine3D
    for dir in "$REFINE_DIR"/job*; do
        # Skip if it’s not a directory
        [ -d "$dir" ] || continue

        # Name of the target file inside the job directory
        target="run_class001.mrc"
        # Name of the symlink to create
        linkname="$dir/$(basename "$dir")_run_class001.mrc"

        # Skip this job if the target file does not exist
        if [ ! -f "$dir/$target" ]; then
            echo "Refine3D: Skipping $dir, $target not found."
            continue
        fi

        # Create the symlink if it does not already exist
        if [ ! -e "$linkname" ]; then
            ln -s "$target" "$linkname"
            echo "Refine3D: Created symlink in $dir: $(basename "$dir")_run_class001.mrc -> $target"
        fi
    done
else
    echo "Refine3D folder not found, skipping."
fi

##########################
# Part 2: Class3D/jobXXX #
##########################
# Define the folder containing Class3D job directories
CLASS3D_DIR="Class3D"

# Check if Class3D folder exists
if [ -d "$CLASS3D_DIR" ]; then
    # Loop over each jobXXX folder inside Class3D
    for dir in "$CLASS3D_DIR"/job*; do
        [ -d "$dir" ] || continue
        echo "Class3D: Processing $dir..."

        # Find all files matching the pattern run_it*_class*.mrc
        files=("$dir"/run_it*_class*.mrc)
        # Skip if no such files exist
        [ -e "${files[0]}" ] || { echo "  No run_it*_class*.mrc files found, skipping."; continue; }

        # Extract iteration numbers from filenames
        iterations=()
        for f in "${files[@]}"; do
            filename=$(basename "$f")
            # Extract the iteration number (itXXX) using sed
            itnum=$(echo "$filename" | sed -n 's/run_it\([0-9]*\)_class[0-9]*\.mrc/\1/p')
            iterations+=("$itnum")
        done

        # Determine the maximum iteration number (last iteration)
        max_it=$(printf "%s\n" "${iterations[@]}" | sort -n | tail -1)
        echo "  Last iteration: it$max_it"

        # Loop over all class files in the last iteration
        for f in "$dir"/run_it"${max_it}"_class*.mrc; do
            filename=$(basename "$f")
            # Name the symlink as jobXXX_run_itXXX_classXXX.mrc
            linkname="$dir/$(basename "$dir")_${filename}"
            # Skip if symlink already exists
            [ -e "$linkname" ] && continue

            # Create the symlink
            ln -s "$filename" "$linkname"
            echo "  Created symlink: $(basename "$linkname") -> $filename"
        done
    done
else
    echo "Class3D folder not found, skipping."
fi
