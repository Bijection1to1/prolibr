
# prolibr

As of now this micro package provides only one function to initialize and
configure project specific library for Rstudio project. Package leverages 
default R session startup mechanism through use of .Rprofile file.

## Installation

``` r
# install.packages("devtools")
devtools::install_github("Bijection1to1/prolibr")
```
## Usage

``` r
prolibr::use_project_lib()
```
After that R session must be restarted for changes to take effect.
