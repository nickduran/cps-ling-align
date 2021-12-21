
variable_prep = function(df) {

  ## remove rows with NA semantic values
  # df = df %>% drop_na()   
  
  ## remove levels that are fewer than 20 turns
  df1 = df %>%
    group_by(Team, School, Block, Level, revisited) %>%
    filter(n() >= 20) %>%
    ungroup()
  
  ## remove extraordinarily long single utterances; why 70? Because this is 5 SDs above mean of utterance length
  df1 = df1 %>% filter(utterlen_aligner < 71 & utterlen_target < 71)
  
  # Convert # of turns to a running proportion score 
  df1 = df1 %>% group_by(Team, School, Block, Level, revisited) %>%
    mutate(ordering_prop = utter_order/max(utter_order)) %>%
    select(-utter_order) %>%
    ungroup()
  
  # Get z-scores for relevant variables
  df1 = df1 %>% 
    mutate(level_durationZ = (level_duration - mean(level_duration))/sd(level_duration),
           utterlen_targetZ = (utterlen_target - mean(utterlen_target))/sd(utterlen_target),
           utterlen_alignerZ = (utterlen_aligner - mean(utterlen_aligner))/sd(utterlen_aligner),
           relative_start_timeZ = (relative_start_time - mean(relative_start_time))/sd(relative_start_time)
    ) 
  
  ## create ordered factor for block (interested in linear trend)
  df1$Block.l <- factor(df1$Block, levels=c("Warmup", "ExpBlock1", "ExpBlock2"), ordered=TRUE)
  
  ## set factors
  cols <- c("aligner_role","Concept","revisited", "trophy")
  df1[cols] <- lapply(df1[cols], factor) 
  
  ## create random factor for within subject variance (making sure each unique subject is signified given their school and team)
  df1$subject_id = as.factor(with(df1, paste0(School, Team, aligner_score)))
  df1$team_id = as.factor(with(df1, paste0(School, Team)))
  
  return(df1)
}










