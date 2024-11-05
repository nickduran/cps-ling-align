#Controller.r

teams = read.csv('CPS2_Teams.csv', sep=",")
teams$Warmup = "Warmup"
teams$ExpBlock1 = "ExpBlock1"
teams$ExpBlock2 = "ExpBlock2"
teams = teams %>% pivot_longer(Warmup:ExpBlock2, names_to = "Cond") %>% select(-value) %>%
  mutate(
    Controller = case_when(
      Cond=="Warmup" ~ word(Person.at.A.Computer, 4, sep="-"),
      Cond=="ExpBlock1" ~ word(Person.at.B.Computer, 4, sep="-"),
      Cond=="ExpBlock2" ~ word(Person.at.C.Computer, 4, sep="-"),
      TRUE ~ NA_character_),
    Concept = case_when(
      Cond=="ExpBlock1" ~ ExpBlock1.Concept,
      Cond=="ExpBlock2" ~ ExpBlock2.Concept,
      TRUE ~ NA_character_),
    Goal = case_when(  
      Cond=="ExpBlock1"  ~ ExpBlock1.Condition,
      Cond=="ExpBlock2"  ~ ExpBlock2.Condition,
      TRUE ~ NA_character_))
