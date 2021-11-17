# Multi-Level Linguistic Alignment in a Dynamic Collaborative Problem-Solving Task 
N Duran, A. Paige, S D'Mello. Cognitive Science.

## What does this respository and README include?

> - R data analysis code (.Rmd files) that provides a step-by-step tutorial of all statistical procedures 
>   - Also, accompanying the .Rmd code is the knitted HTML output that reproduces results reported in manuscript in an easy-to-read format
> - Complete input and processed data for running analyses
> - Data codebook and variable descriptions used in source code to generate analysis (NOT ADDED YET)

## R data analysis code (.Rmd)

The files in the **R_RMD_Analysis** folder contains the sequence of steps in R to generate the results, tables, and figures as reported in the manuscript. Detailed notes and annotations are included. Complete replication possible with access to the available source data files. 

> **Relevant Files:**
> - **Step1_CogSci_Features_MASTER.Rmd**
>   - Notebook takes raw output files from the ALIGN analysis and performs a clean-up to creates necessary variables for analysis, with a focus on creating the composite linguistic variables
> - **Step2_Optional_IndividDiff_MASTER.Rmd**
>   - Notebook adds optional individual difference measures to main datasheet
> - **Step3_CogSci_M1_MASTER.Rmd**
>   - Notebook contains code for replicating section in manuscript: Analysis 1: Alignment over time 
> - **Step3_CogSci_M2_MASTER.Rmd**
>   - Notebook contains code for replicating section in manuscript: Analysis 2: Alignment and CPS outcomes
> - **Step3_CogSci_Descriptives_MASTER.Rmd**
>   - Notebook contains code for computing level stats on relationship between # of turns, trophy completions, block, and verbosity

## R data analysis output (.HTML)

The files in the **R_HTML_Analysis_Output** folder contains easy-to-read formatted HTML files. To view in web browser, please right-click on each file below to open in a new tab or window. (NOT ADDED YET)

> **Relevant Files:**
> - http://dynamicog.org/...
> - http://dynamicog.org/...
> - http://dynamicog.org/...

## Stat R Helper Files

The files in the **R_Helper** folder contain R scripts imported by the main .Rmd files to do a series of mundane clean-up and data prep tasks

> **Relevant Files:**
> - **Step1_helper.R**
>   - Something here
> - **Step3_helper.R**
>   - Something here

## Data (.CSV and .TXT)

The files in the **Data** folder contain the raw (from ALIGN) and processed data (from .Rmd) to compute analyses

> **Relevant Folder: RAW**
> - **ALIGN_Output**
>   - Something here

> **Relevant Files: PREPPED**
> - **Step1_PrepareFeatures.csv**
>   - Something here
>   - **Step2_Optional_IndividDiff.csv**
>   - Something here

## Accompanying Datasheets for Building New Variables

The files in the **Accompanying_Data** folder contain additional datasheets necessary to build out the ALIGN raw data and to add task/individual difference variables. 

> **Relevant Folders/Files:**
> - **Step1_FilesToIntegrate**
>   - Something here
>       - Something here
> - **Step2_FilesToIntegrate**
>   - Something here
>       - Something here
