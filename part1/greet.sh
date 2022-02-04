#!/bin/bash
name=$(whoami)
day=$(date +%A)
date=$(date +%e)
month=$(date +%B)
year=$(date +%Y)
time=$(date +%T)
echo “Hello $name, today is $day, $date $month $year, and the time is $time.”