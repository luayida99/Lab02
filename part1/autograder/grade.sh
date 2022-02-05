#!/bin/bash

# Check if we have enough arguments
if [ "$#" -ne 1 ]; then 
    echo "Usage: ./grade.sh <filename>"
    exit 1
fi

# Delete temporary files
rm -rfv ref/*.out

# Compile the reference program
gcc ref/*.c -o $1

# Generate reference output files
total_marks=0

for i in ref/*.in; do 
    echo >> $i.out 
    ./$1 < $i > $i.out
    total_marks=$((total_marks+1))
done

# Now mark submissions

#
# Note: See Lab02Qn.pdf for format of output file. Marks will be deducted for missing elements.
#
if [[ -f results.out ]]; then
    rm results.out
fi
day=$(date +%A)
date=$(date +%e)
month=$(date +%B)
year=$(date +%Y)
time=$(date +%T)
echo -e "Test date and time: $day, $date $month $year, $time\n" >> results.out

# Iterate over every submission directory
    # Compile C code
    # Print compile error message to output file
    # Generate output from C code using *.in files in ref
    # Compare with reference output files  and award 1 mark if they are identical
# print score for student
# print total files marked.
processed=0

for i in subs/*; do 
    subdir_name=${i#subs/}
    gcc $i/*.c -o $i/$subdir_name
    if [[ "$?" -ne 0 ]]; then
        processed=$((processed+1))
        echo "Directory $subdir_name has a compile error." >> results.out
        #compile error means that no marks given
        echo "Directory $subdir_name score 0 / $total_marks." >> results.out
    else 
        marks=0
        for j in ref/*.in; do 
            if [[ ! -d $i/ref ]]; then
                mkdir $i/ref
            fi
            echo >> $i/$j.out 
            ./$i/$subdir_name < $j > $i/$j.out 
            diff $i/$j.out $j.out
            if [[ "$?" -eq 0 ]]; then
                marks=$((marks+1))
            fi
        done
        processed=$((processed+1))
        echo "Directory $subdir_name score $marks / $total_marks." >> results.out
    fi
done

echo -e "\nProcessed $processed files." >> results.out