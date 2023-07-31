# R Geocoding Workflow

This repo uses an R wrapper for [spaCy](https://cran.r-project.org/web/packages/spacyr/vignettes/using_spacyr.html) to identify places in a directory of txt files, then uses 
[tmaptools](https://cran.r-project.org/web/packages/tmaptools/tmaptools.pdf) to geocode those places with lat/long data.

## File Overview

1. [sherlockGeocode.R](sherlockGeocode.R) is the main script that performs NER and geocoding on a text corpus.

2. [sherlockGeocodeR.sbatch](sherlockGeocodeR.sbatch) is the slurm script that runs the job on Sherlock.

## Usage Instructions

### Connect to Farmshare

 First you must connect to Farmshare using
```
ssh SUNetID@rice.stanford.edu
```
in your terminal program.

### Configuring Outputs

While we're here, let's create a few directories for our outputs:
```bash
mkdir out err /scratch/users/$USER/outputs
```

### Navigate to Files

Next, we're going to move to the learning environment for this lesson
```bash  
cd /farmshare/learning/scripts/scripts/geocoding_r
```
You can check out the files with ```ls``` if you'd like.

### Running the script

At this point, you should be ready to run. To do this, make sure you're in the geocoding directory and type
```
sbatch sherlockGeocodeR.sbatch
```
This will run sherlockGeocode.R, and output a file called "places.csv" to the directory. If you have any issues, contact [srcc-support@stanford.edu](srcc-support@stanford.edu) and your question will be 
routed to me.
