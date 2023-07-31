#!/bin/bash
#SBATCH --job-name=geocode
#SBATCH --output=/home/%u/out/test_job.%j.out
#SBATCH --error=/home/%u/err/test_job.%j.err
#SBATCH --time=01:00:00
#SBATCH -p normal
#SBATCH -c 1
#SBATCH --mem=32GB
Rscript sherlockGeocode.R
