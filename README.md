# Multi-Level Linguistic Alignment in a Dynamic Collaborative Problem-Solving Task

N Duran, A. Paige, S D'Mello., Others. Cognitive Science.

## What does this respository and README include?

> - R data analysis code (.Rmd files) that provides a step-by-step tutorial of all statistical procedures
>   - Also, accompanying the .Rmd code is the knitted HTML output that reproduces results reported in manuscript in an easy-to-read format
> - Complete input and processed data for running analyses
> - Data codebook and variable descriptions used in source code to generate analysis (NOT ADDED YET)

## R data analysis code (.Rmd)

The files in the **R_RMD_Analysis** folder contains the sequence of steps in R to generate the results, tables, and figures as reported in the manuscript. Detailed notes and annotations are included. Complete replication possible with access to the available source data files.

> **Relevant Files:**
>
> - **Step1_Features.Rmd**
>   - Notebook takes raw output files from the ALIGN analysis and performs a clean-up to creates necessary variables for analysis, with a focus on creating the composite linguistic variables
> - **Step2_Optional_IndividDiff.Rmd**
>   - Notebook adds optional individual difference measures to main datasheet
> - **Step3_M1_Lexical.Rmd**
>   - Notebook contains code for replicating section in manuscript: Analysis 1: Alignment over time: Lexical
> - **Step3_M1_Syntax.Rmd**
>   - Notebook contains code for replicating section in manuscript: Analysis 1: Alignment over time: Syntax
> - **Step3_M1_Semantic.Rmd**
>   - Notebook contains code for replicating section in manuscript: Analysis 1: Alignment over time: Semantic
> - **Step3_M2_Trophies.Rmd**
>   - Notebook contains code for replicating section in manuscript: Analysis 2: Alignment and CPS outcomes
> - **Step3_Descriptives.Rmd**
>   - Notebook contains code for computing level stats on relationship between # of turns, trophy completions, block, and verbosity

## R data analysis output (.HTML)

The files in the **R_HTML_Analysis_Output** folder contains easy-to-read formatted HTML files. To view in web browser, please right-click on each file below to open in a new tab or window. (NOT ADDED YET)

> **Relevant Files:**
>
> - http://dynamicog.org/CPS-align/Step1_Features.html
> - http://dynamicog.org/CPS-align/Step3_M1_Lexical.html
> - http://dynamicog.org/CPS-align/Step3_M1_Syntax.html
> - http://dynamicog.org/CPS-align/Step3_M1_Semantic.html
> - http://dynamicog.org/CPS-align/Step3_M2_Trophies.html

## Stat R Helper Files (.R)

The files in the **R_Helper** folder contain R scripts imported by the main .Rmd files to do a series of mundane clean-up and data prep tasks

> **Relevant Files:**
>
> - **Step1_helper.R**
> - **Step3_helper.R**

## Data (.CSV and .TXT)

The files in the **Data** folder contain the raw (from ALIGN) and processed data (from .Rmd) to compute analyses.

> **Relevant Folder: RAW**
>
> - **ALIGN_Output**

> **Relevant Files: PREPPED**
>
> - **Step1_PrepareFeatures.csv**
>   - Prepped output from running "Step1_CogSci_Features_MASTER.Rmd"
> - **Step2_Optional_IndividDiff.csv**
>   - Prepped output from running "Step2_Optional_IndividDiff_MASTER.Rmd"

## Accompanying Datasheets for Building New Variables (.CSV)

The files in the **Accompanying_Data** folder contain additional datasheets necessary to build out the ALIGN raw data and to add task/individual difference variables.

> **Relevant Folders/Files:**
>
> - **Step1_FilesToIntegrate**
>   - CPS2_Teams.csv
>   - Levels_PP_Logs_Lab_Before_Split_by_Trophy.csv
>   - SWITCH_PARTICIPANTS.csv

> - **Step2_FilesToIntegrate**
>   - person_block.csv
>   - person.csv

## SPECIAL NOTE ON GENERATING BASELINE DATA RESULTS

All **.Rmd** files in the **R_RMD_Analysis** folder can be rerun by simply commenting out the line that imports the datasheet with the real data and uncommenting the line that imports the equivalent datasheet generated using the baseline data.
