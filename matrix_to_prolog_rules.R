library(magrittr)

#setwd("/home/schmid/agora/kintreex")

#### sex ####

fix_names <- function(x) {
  gsub("[[:space:]]", "", tolower(x))
}

sl <- read.csv("sex_list.csv")

sl_fixed <- sl %>%
  dplyr::mutate(
    id = fix_names(id)
  ) %>%
  dplyr::arrange(
    sex
  )

individuals_facts <- sapply(
  1:nrow(sl_fixed), function (i) {
    paste0(sl_fixed$sex[i], "(", sl_fixed$id[i], ").")
  })



#### relationships ####

pm <- read.csv("pedigree_matrix.csv", check.names = F)

pm_long <- reshape2::melt(pm) %>%
  setNames(c('id.a', 'id.b', 'value')) %>%
  dplyr::filter(!is.na(value) & value != 100)

pm_long_fixed <- pm_long %>%
  dplyr::mutate(
    id.a = fix_names(id.a),
    id.b = fix_names(id.b),
    value_cut = cut(
      value, 
      breaks = c(101, 26, 12.6, 6.3, 1, -1), 
      labels = c(
        "first_degree",
        "second_degree",
        "third_degree",
        "fourth_degree",
        "unrelated"
      ) %>% rev()
      )
  ) %>%
  dplyr::arrange(
    value
  )

relationship_facts <- sapply(
  1:nrow(pm_long_fixed), function (i) {
    paste0(pm_long_fixed$value_cut[i], "(", pm_long_fixed$id.a[i], ", ", pm_long_fixed$id.b[i], ").")
})

#### write facts to file ####

writeLines(
  text = c(
    "/* Facts */",
    "",
    individuals_facts,
    "",
    relationship_facts
  ),
  con = "facts_template.pl.template"
)
