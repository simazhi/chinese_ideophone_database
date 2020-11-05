[![DOI](https://zenodo.org/badge/166169099.svg)](https://zenodo.org/badge/latestdoi/166169099)

# Chinese Ideophone Database

<img src='https://github.com/simazhi/chinese_ideophone_database/blob/master/badge/logo.png' align="right" height="139" />

## Current version

**CURRENT VERSION OF THE DATABASE: 0.9.3**

## Link to the paper that details the contents

*add link in future*

## Deployments of the Chinese Ideophone Database

This is the directory where the R data package CHIDEOD is stored.
**PLEASE NOTE THAT THE MAIN PROJECT REPOSITORY IS HELD AT THE OSF REPOSITORY (https://osf.io/kpwgf/) AND NOT HERE,** although you are free to look around at the scripts that are used to update the Chinese Ideophone Database.

If you navigate to the OSF-repository, you can access the Chinese Ideophone Database (CHIDEOD) in the following formats:

* **chideod.rds**
* **chideod.csv**
* **chideod.xlsx**

As a further note, you may found similar files here in this repository. It is not recommended to use these, but always go to the OSF repository.

Other ways of accessing CHIDEOD is through the 

* **[app deployment](https://simazhi.shinyapps.io/chideod_appversion/)** (look under the Wiki tab for a guaranteed link in case this one breaks down).
* as an R package.

The R package can be downloaded as follows:

```
library(devtools)
devtools::install_github("simazhi/chinese_ideophone_database/CHIDEOD")
```

## Contents of this github folder

### Files

* __README.md__ The file you are reading right now.
* __LICENCE.md__ The file that contains the license of this project.
* __chinese_ideophone_database.Rproj__ This file is used when we update CHIDEOD, and allows for easy project management. You can ignore this file.
* __CHIDEOD_VERSIONNUMBER_tar.gz__ This file contains the raw R package of CHIDEOD. You can use this if the above instructions to install the R package fail.
* __.gitignore__ This file tells github which files to ignore. You can do so too.
* __Changelog.md__ This file contains the changes made after CHIDEOD 1.0, which is congruent with the version as published in the explanatory paper (*add link to article*).

### Folders

* __CHIDEOD__ This folder contains the contents of the R package for CHIDEOD, before it is zipped in the tar.gz file. It is not recommended to go inside this.
* __interesting_lists__ This folder contains lists that were deemed interesting for us when making the Chinese Ideophone Database, and holds miscellaneous items and statistics that were made using previous stages of the database. Got a free afternoon and want to go through it for ideophone treasurehunting? Sure, go ahead.
* __scripts__ A misscelaneous collection of scripts from which we draw when updating the database. Feel free to reuse parts of them if they can help you solve your own database problems. On the other hand, please do not expect us to list the contents of each one. They are mostly intented for our own ad hoc use and adaptation and we provide them here for our own open transparency.
* __shiny_app__ The code for the shiny app deployment of CHIDEOD.
* __variables_and_data__ This folder contains the basic structure of CHIDEOD (chideod_variables.pdf), as well as a list of abbreviations and references (abbreviations_references.md), used in the database itself. **We strongly recommend to read the paper version, which goes in detail over all of these items.**

# License

This product is intended as open-source and non-commercial.
The license is the [CC BY-NC-SA 4.0 license](https://creativecommons.org/licenses/by-nc-sa/4.0/). 
Please consult the LICENCE.md file for more information.

# How to cite

As is mentioned on the home project folder for this in the OSF repository (https://osf.io/kpwgf/), the project can be cited as:

**Van Hoey, Thomas & Arthur Lewis Thompson. 2019. Chinese ideophone database (CHIDEOD). doi: 10.17605/OSF.IO/KPWGF**

If used in a project, you can also add the version number (see top of this README.md file).

