#!/bin/bash
# Script to create symlinks for last iteration .mrc files in a user-specified Class3D/jobXXX folder
# Run from relion_parent directory

# Define Class3D folder
CLASS3D_DIR="Class3D"

# Ask user which jobXXX to process
read -p "Enter the job number (XXX) to create symlinks for (e.g., 005): " JOB_NUM
JOB_DIR="$CLASS3D_DIR/job$JOB_NUM"

# Check if the folder exists
if [ ! -d "$JOB_DIR" ]; then
    echo "Error: $JOB_DIR does not exist."
    exit 1
fi

echo "Processing $JOB_DIR..."

# Find all files matching run_it*_class*.mrc
files=("$JOB_DIR"/run_it*_class*.mrc)
[ -e "${files[0]}" ] || { echo "No run_it*_class*.mrc files found in $JOB_DIR, exiting."; exit 1; }

# Extract iteration numbers
iterations=()
for f in "${files[@]}"; do
    filename=$(basename "$f")
    itnum=$(echo "$filename" | sed -n 's/run_it\([0-9]*\)_class[0-9]*\.mrc/\1/p')
    iterations+=("$itnum")
done

# Determine the maximum iteration number (last iteration)
max_it=$(printf "%s\n" "${iterations[@]}" | sort -n | tail -1)
echo "Last iteration detected: it$max_it"

# Loop over all class files in the last iteration and create symlinks
for f in "$JOB_DIR"/run_it"${max_it}"_class*.mrc; do
    filename=$(basename "$f")
    linkname="$JOB_DIR/$(basename "$JOB_DIR")_${filename}"
    [ -e "$linkname" ] && continue  # skip if symlink already exists

    ln -s "$filename" "$linkname"
    echo "Created symlink: $(basename "$linkname") -> $filename"
done
