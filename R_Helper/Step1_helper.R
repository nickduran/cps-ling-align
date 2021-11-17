cleanup = function(df) {
  df = df %>% rename(semantic = "cosine_semanticL") %>% mutate(condition_info = gsub("_", "-", condition_info))
  
  
  
  ######   ######   ######   ######   ###### 
  ###### Breaking up ALIGN "condition_info" to create variables for School, Team, etc.; doing a bit of renaming for consistency
  ######   ######   ######   ######   ###### 

  
  
  df1 = df %>% 
    mutate(School = word(condition_info, 1, sep="-"), 
           Team = word(condition_info, 2, sep="-"), 
           Cond = word(condition_info, 3, sep="-"), 
           leveltxt = word(condition_info, 4, sep="-"), 
           levelroundtxt = word(condition_info, 5, sep="-")) %>%
    
    mutate(Level = gsub(".txt", "", leveltxt), Revisited = gsub(".txt", "", levelroundtxt)) %>% 
    
    select(-leveltxt, -condition_info, -levelroundtxt) %>%
    
    select(School, Team, Cond, Level, Revisited, everything()) %>%
    
    rename(utterancelength1 = utterance_length1, utterancelength2 = utterance_length2, utter_order=time) %>% 
    
    mutate(Cond = gsub("WU", "Warmup", Cond))
  
  df1$Revisited[is.na(df1$Revisited)] <- "0"
  df1$Revisited = as.integer(df1$Revisited)
  
  
  
  ######   ######   ######   ######   ######  
  ##### Incorrect participant labeling from REV - need to switch to hand-coded gold standard
  ######   ######   ######   ######   ###### 
  
  

  ## remember, this is the master sheet for all levels (should include all of ALIGN plus extras)
  getswitched = read.csv('../Accompanying_Data/Step1_FilesToIntegrate/SWITCH_PARTICIPANTS.csv', sep=",") %>% rename(Cond = Block) %>% mutate(Cond = gsub("WU", "Warmup", Cond))

  df1 = df1 %>% mutate(partner_direction = gsub(":", "", partner_direction), firstp = word(partner_direction, 1, sep=">"), secondp = word(partner_direction, 2, sep=">")) %>%
    select(-partner_direction)
  
  df2 = c()
  for (i in 1:nrow(getswitched)) {
    getfile = paste(getswitched$School[i], getswitched$Team[i], getswitched$Cond[i], sep="_")
    # print(getfile)
    
    df1.block = filter(df1, School==getswitched$School[i] & Team==getswitched$Team[i] & Cond==getswitched$Cond[i]) %>%
      
      mutate(firstp_new = ifelse(firstp==getswitched$TEXT_ID_at_Top_or_Left[i], getswitched$ACTUAL_ID_at_Top_or_Left[i],
                                 ifelse(firstp==getswitched$TEXT_ID_at_Middle[i], getswitched$ACTUAL_ID_at_Middle[i],
                                        ifelse(firstp==getswitched$TEXT_ID_at_Bottom_or_Right[i], getswitched$ACTUAL_ID_at_Bottom_or_Right[i],"PZ"))),
             secondp_new = ifelse(secondp==getswitched$TEXT_ID_at_Top_or_Left[i], getswitched$ACTUAL_ID_at_Top_or_Left[i],
                                  ifelse(secondp==getswitched$TEXT_ID_at_Middle[i], getswitched$ACTUAL_ID_at_Middle[i],
                                         ifelse(secondp==getswitched$TEXT_ID_at_Bottom_or_Right[i], getswitched$ACTUAL_ID_at_Bottom_or_Right[i],"PZ"))))
    
    df2 = rbind(df2, df1.block)  
  }                               
  
  df2 = df2 %>% mutate(partner_direction = paste(firstp_new, ":>", secondp_new, ":", sep="")) %>% select(-firstp_new, -secondp_new, -firstp, -secondp) %>%
    select(c(1:5, partner_direction, everything()))
  # fixed = filter(df, School=="ASU", Team=="T87", Level=="CanOpener")
  

    
  ######   ######   ######   ######   ######  
  #### Part A: Add which participant is the controller
  ######   ######   ######   ######   ######  

  # For Warmup, controller is "Person at A Computer." 
  # For ExpBlock1, controller is "Person at B Computer." 
  # For ExpBlock2, controller is "Person at C Computer." 

  
  
  
  teams = read.csv('../Accompanying_Data/Step1_FilesToIntegrate/CPS2_Teams.csv', sep=",") 
  teams$Warmup = "Warmup"
  teams$ExpBlock1 = "ExpBlock1"
  teams$ExpBlock2 = "ExpBlock2"
  teams = teams %>% pivot_longer(Warmup:ExpBlock2, names_to = "Cond") %>% select(-value) %>% 
    mutate(
      Controller = case_when(
        Cond=="Warmup" ~ word(Person.at.A.Computer, 4, sep="-"),
        Cond=="ExpBlock1" ~ word(Person.at.B.Computer, 4, sep="-"),
        Cond=="ExpBlock2" ~ word(Person.at.C.Computer, 4, sep="-"),
        TRUE ~ NA_character_)) %>% 
    select(Team, School, Cond, Controller)
  
  df3 = left_join(teams, df2)
  ## now, just get rid of the rows for where we have no data at all
  df3 = df3[!is.na(df3$utter_order),]
  
  ######   ######   ######   ######   ###### 
  ##### PART B: Now, knowing which partner is the controller, and knowing who the speaker and aligner are, just making it a little clearer
  ######   ######   ######   ######   ###### 
  
  df4 = df3 %>% 
    mutate(speaker_target = str_remove_all(partner_direction, ":") %>% word(1, sep=">"),
           aligner_score = str_remove_all(partner_direction, ":") %>% word(2, sep=">")) %>%
    rename(utterlen_aligner = "utterancelength2", utterlen_target = "utterancelength1",
           Block = Cond) %>%
    # add the controller/contributor distinction
    mutate(aligner_role = case_when(
      aligner_score == Controller ~ "controller",
      aligner_score != Controller ~ "contributer",
      TRUE ~ NA_character_)) %>%
    # select(-Concept, -Goal, -partner_direction) ### <<< I have no idea why I'm really doing this, guess adding it back with the Levels_PP_Logs_Lab_Before_Split_by_Trophy.csv file
    select(-partner_direction) ### <<< I have no idea why I'm really doing this, guess adding it back with the Levels_PP_Logs_Lab_Before_Split_by_Trophy.csv file
  
  
  
  
  ######   ######   ######   ######   ###### 
  ##### Adding a bunch of new variables from one of the master sheets where relevant info was recorded but not included in the above
  # gold_trophy
  # silver_trophy
  # level duration
  # relative_start_time
  # Revisited
  # Concept
  # Goal
  ######   ######   ######   ######   ###### 
  
  
  
  
  trophies = read.csv('../Accompanying_Data/Step1_FilesToIntegrate/Levels_PP_Logs_Lab_Before_Split_by_Trophy.csv', sep=",") 
  trophies2 = trophies %>% 
    mutate(School = word(team, 1, sep="-"), Team = word(team, 2, sep="-")) %>% select(-team, -school) %>%
    rename(Block = block, Concept = concept, Level = level, Goal = manipulation, Revisited = level_attempt) %>%

    mutate(Level = gsub(" ", "", Level)) %>%
    mutate(Block = gsub("WU", "Warmup", Block)) %>%
  
    select(Team, School, Block, Level, Revisited, Concept, Goal, relative_start_time, level_duration, gold_trophy, silver_trophy)
    
  df5 = left_join(df4, trophies2)  
  
  
  
  
  
  ######   ######   ######   ######   ###### 
  ####### LEVEL INFO: ADD VARIABLES/MODIFICATIONS USED IN THE SPLIT-LEVEL EXPERT RATING DATA ANALYSIS - CHEN
  ######   ######   ######   ######   ###### 
  
  
  
  
  df6 = df5 %>%
    ## convert WU levels to the appropriate concepts 
    mutate(Concept = case_when(
      Level=="CanOpener" ~ "EcT", 
      Level=="AnnoyingLever" ~ "PoT",
      Level=="DoubleHoppy" ~ "EcT",
      Level=="SpiderWeb" ~ "EcT",
      Level=="Yippie!" ~ "EcT",
      TRUE ~ Concept)) %>% 

    mutate(trophy = case_when(
      gold_trophy == 1 ~ "gold",
      silver_trophy == 1 ~ "silver",
      gold_trophy == 0 & silver_trophy == 0 ~ "none",
      TRUE ~ NA_character_)) %>%
    select(-gold_trophy, -silver_trophy)
  
  
  
  ######   ######   ######   ######   ###### 
  ###### Final clean up that was doing in the stats prep side of things, but can be generalized here
  ######   ######   ######   ######   ######  
  
  
  ## remove "PZ" label (researcher) and "NA" labels introduced for participants
  df7 = df6 %>% filter(!is.na(aligner_score) & aligner_score!="PZ" & !is.na(speaker_target) & speaker_target!="PZ")
  
  ## recode "Revisited" as binary (an initial or reattempt)
  df7 = df7 %>% 
    mutate(revisited = ifelse(Revisited >= 1, "reattempt", "initial")) 
  
  df7$Goal[df7$Goal == "NaN"] <- "None"
  
  
  return(df7)
  
  
  
}