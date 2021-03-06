############################################################################
## File Name: user_options.R

## File Purpose: Specify inputs for run_file.R
## Author: Jeanette Birnbaum
## Date: 10/14/2014
## Edited on: 

## Additional Comments: 
#############################################################################

############################################################
# Establish model version if this file is not being called 
# by a wrapper
############################################################
# TODO
if (!'using_wrapper'%in%ls()) {
    warning('Empyting the workspace')
    rm(list=ls())
    model_version <- 'breast_ER-HER2_3b'
    base_path <- '~/screentreat/examples'
}

############################################################
# Input data files
############################################################

treat_file = file.path(base_path, model_version, 'input', 'input.csv')
incidence_file = '~/screentreat/data/bc_1975-1979_incidence.csv'
library_file = '~/screentreat/code/screentreat_library.R'
#life_table_file = '~/cantrance/diagnostics/data/life_table_Reed2012.csv'

############################################################
# Simulation features
############################################################
nsim = 100
times = 1:25
pop_size = 100000
study_year = 2000

############################################################
# Population features
############################################################

pop_chars = 
    list(age=data.frame(age=c(50), prop=c(1)),
         male=data.frame(male=c(0), prop=c(1)))

# Is age in the data age at clinical incidence? 
# If not, provide incidence table
age_is_ageclin = FALSE
if (!age_is_ageclin) {
    inc_table = read.csv(incidence_file, header=TRUE, 
                         stringsAsFactors=FALSE)
}

############################################################
# Screening, treatment and cancer mortality
############################################################

# Stage shift
HR_advanced = 0.75

# Treatment HRs and distributions by subgroup-stage
treat_chars = read.csv(treat_file, header=TRUE, 
                        stringsAsFactors=FALSE)

# Baseline mortality rates and population proportions by
# subgroup-stages. Subgroup stages specified here must
# match those given in the scrtrt_file
control_notreat = data.frame(stage=c(rep('Early',4),
                                     rep('Advanced',4)),
                             subgroup=rep(c('ER+HER2+',
                                            'ER+HER2-',
                                            'ER-HER2+',
                                            'ER-HER2-'),2),
                             mortrate=c(rep(.01992,4),rep(0.10693, 4)),
                             prop=c(0.04, 0.38, 0.02, 0.06,
                                    0.06, 0.34, 0.03, 0.07))


############################################################
# Other-cause mortality
############################################################

ocd_HR = 1

############################################################
# Run model
############################################################

source('~/screentreat/code/run_file.R')

