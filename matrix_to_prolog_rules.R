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
    sex, id
  )

individuals_facts <- sapply(
  1:nrow(sl_fixed), function (i) {
    paste0(sl_fixed$sex[i], "(", sl_fixed$id[i], ").")
  })



#### relationships ####

pm <- read.csv("pedigree_matrix.csv", check.names = F, row.names = 1)
pm[upper.tri(pm)] <- t(pm)[upper.tri(pm)]

pm_long <- reshape2::melt(as.matrix(pm)) %>%
  setNames(c('id.a', 'id.b', 'value')) %>%
  dplyr::filter(value != 100)

pm_long_fixed <- pm_long %>%
  dplyr::mutate(
    id.a = fix_names(id.a),
    id.b = fix_names(id.b),
    value_cut = cut(
      value, 
      breaks = c(101, 50, 25, 12.5, 6.25, -1), 
      labels = c(
        "first_degree",
        "second_degree",
        "third_degree",
        "fourth_degree",
        "unrelated"
      ) %>% rev(),
      include.lowest = TRUE,
      right = FALSE
      )
  ) %>%
  dplyr::arrange(
    value, id.a
  )

relationship_facts <- sapply(
  1:nrow(pm_long_fixed), function (i) {
      paste0(
        pm_long_fixed$value_cut[i], "(", 
          pm_long_fixed$id.a[i], ", ", pm_long_fixed$id.b[i], 
        ")."
      )
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
  con = "facts.pl"
)
