## Workflow for generating QC statistics from cram/bam files.
### Usage

```

=======================================================================
  BAM/CRAM FILE ASSESSMENT: TAPIR Pipeline version 1.0dev
=======================================================================
 The typical command for running the pipeline is as follows:
        nextflow run main.nf --reads "PathToReadFile(s)" --assemblies "PathToFastafile(s)" --output_dir "PathToOutputDir" --sequencing_date "GYYMMDD" 

        Mandatory arguments:
         --reads                        Query fastq.gz file of sequences you wish to supply as input (e.g., "/dir/T055-8-*.fastq.gz")
	 --assemblies			Query fasta file (e.g., assembly/T055-8*.fasta)
         --sequencing_date              sequencing date (e.g., G230519)
         --output_dir                   Output directory to place output (e.g., "out/")
         
        Optional arguments:
         --help                         This usage statement.
         --version                      Version statement

```


## Introduction
This pipeline generates a text file containing [QC outputs](https://github.com/wdecoster/cramino#example-output). Further details can be found at the github page of the [original authors](https://github.com/wdecoster/cramino).  


## Sample command
An example of a command to run this pipeline is:

```
nextflow run main.nf --reads "Sample_files/*.fastq.gz" --assemblies "Sample_files/*.fasta" --output_dir "test2" --sequencing_date "GYYMMDD"
```

## Word of Note
This is an ongoing project at the Microbial Genome Analysis Group, Institute for Infection Prevention and Hospital Epidemiology, Üniversitätsklinikum, Freiburg. The project is funded by BMBF, Germany, and is led by [Dr. Sandra Reuter](https://www.uniklinik-freiburg.de/institute-for-infection-prevention-and-control/microbial-genome-analysis.html).


## Authors and acknowledgment
The TAPIR (Track Acquisition of Pathogens In Real-time) team.
