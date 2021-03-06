# for each PR ----
# restart R
rm(list = ls());.rs.restartR();
# Update documentation (NAMESPACE) for functions
devtools::document()
# Load functions
devtools::load_all()
# Run tests first without package style
devtools::test(filter = "package-style|summary", invert = TRUE)
# with package-style (slow)
devtools::test(filter = "package-style|summary"); beepr::beep(5);
# check test coverage
covr::report()
# rebuild site
pkgdown::build_site(devel = TRUE, lazy = TRUE)
# Check if there are any package issues
devtools::check(document = FALSE); beepr::beep(5);

# other pkgdown functions commonly used
pkgdown::build_reference()
pkgdown::build_article(name = "")
pkgdown::build_articles()



# updating release ----
# Bump version in DESCRIPTION:
desc::desc_bump_version("minor")
#Double check vignettes/reference pages in pkgdown:
devtools::install(); pkgdown::build_site()
# Add additional contributors/authors
file.edit("DESCRIPTION")
# Double check _pkgdown.yml for new functions
file.edit("_pkgdown.yml")
# Update NEWS.md: Follow format from previous releases
file.edit("NEWS.md")
# Run package spell check:
spelling::spell_check_package()
# may need to add/edit words
file.edit("inst/WORDLIST")

# send to CRAN




# fn web ----
package_to_analyze <- "simplecolors"
library(package_to_analyze, character.only = TRUE)

tibble::tibble(
  fn = unclass(lsf.str(envir = asNamespace(package_to_analyze), all.names = TRUE)),
  exported = fn %in% unclass(lsf.str(paste0("package:", package_to_analyze), all.names = TRUE))
)

mvbutils::foodweb(
  where = asNamespace(package_to_analyze),
  # descendents = FALSE,
  # ancestors = FALSE,
  cex = 0.8,
  # prune = "sc_within", # specific function of interest
  # boxcolor = "grey90",
  color.lines = TRUE
)
