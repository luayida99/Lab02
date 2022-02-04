#!/bin/bash

# Check if we have enough arguments
if [ "$#" -ne 1 ]; then 
    echo "Usage: ./grade.sh <filename>"
fi

# Delete temporary files
rm -rfv ref/*.out

# Compile the reference program
gcc ref/*.c -o $1

# Generate reference output files
for i in ref/*.in; do 
    echo >> $i.out 
    ./$1 < $i > $i.out
done

# Now mark submissions

#
# Note: See Lab02Qn.pdf for format of output file. Marks will be deducted for missing elements.
#

# Iterate over every submission directory
    # Compile C code
    # Print compile error message to output file
    # Generate output from C code using *.in files in ref
    # Compare with reference output files  and award 1 mark if they are identical
# print score for student
# print total files marked.
