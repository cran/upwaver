
<!-- README.md is generated from README.Rmd. Please edit that file -->
'upwaver'
---------

'upwaver' is a wrapper around the UpWave API that allows users to access the UpWave API from within R.

Installation
------------

You can install 'upwaver' from `CRAN` or `github` with:

``` r
install.packages("upwaver")

# install.packages("devtools")
devtools::install_github("ims-fhs/upwaver")
```

Examples
--------

You can access the following UpWave informations and more with 'upwaver':

-   List of Boards: The list of your UpWave Boards with `list_boards()`
-   Board details: Background Information about a specific board with `board_details()`
-   List of Cards: Detailed Information about all Cards of a specific board with `list_cards()`

``` r
# upwaver::list_boards("your_organisation", "your_token")
# upwaver::board_details("your_organisation", board_id, "your_token")
# upwaver::list_cards("your_organisation", board_id, "your_token")
```

For more detailed Information and further functionalities of the 'upwaver' package, check out the vignette.
