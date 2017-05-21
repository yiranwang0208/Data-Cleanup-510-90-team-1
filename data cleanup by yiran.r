dc<-read.csv(file="C:/Users/zy/Data-Cleanup-510-90-team-1/dirty_data.csv", header=TRUE, sep=",",stringsAsFactors=FALSE,strip.white=TRUE)
#"stringsAsFactors" prevent R from loading the data into factor format
#View(dc)
#dim(dc)			# Determine the number of rows and columns
#head(dc)
trim <- function (x) gsub("^\\s+|\\s+$", "", x)
## returns string w/o leading or trailing whitespace
dc$Street<-trim(dc$Street)
dc$Street.2<-trim(dc$Street.2)
dc$Strange.HTML<-gsub("[^[:ascii:]]|[[:punct:]]", "", dc$Strange.HTML, perl=TRUE)
dc$Street<-gsub("[^a-zA-Z0-9]", " ", dc$Street)
#For the first option, you need perl = TRUE to recognize the [[:ascii:]] character class.
#The ^ in option 1 means "not" (so, you can read it as "find anything that is not an ASCII character, that is a space, or that is a punctuation mark, and replace it with nothing).
#dc$Street<-str_replace_all(dc$Street, "\\?", "-")
dc$Street<-gsub("(?<=\\b)([a-z])", "\\U\\1", tolower(dc$Street), perl=TRUE)
dc$Street.2<-gsub("(?<=\\b)([a-z])", "\\U\\1", tolower(dc$Street.2), perl=TRUE)
#(?<=\\b)([a-z]) says look for a lowercase letter preceded by a word boundary (e.g., a space or beginning of a line). (?<=...) is called a "look-behind" assertion. \\U\\1 says replace that character with it's uppercase version. \\1 is a back reference to the first group surrounded by () in the pattern.

dc$Street<-gsub("Raod", "Road",dc$Street)
dc$Street.2<-gsub("Raod", "Road",dc$Street.2)
dc$Street<-gsub("Road", "Rd",dc$Street)
dc$Street.2<-gsub("Road", "Rd",dc$Street.2)
dc$Street<-gsub("Lane", "Ln",dc$Street)
dc$Street.2<-gsub("Lane", "Ln",dc$Street.2)
dc$Street<-gsub("Street", "St",dc$Street)
dc$Street.2<-gsub("Street", "St",dc$Street.2)
dc$Street<-gsub("Avenue", "Ave",dc$Street)
dc$Street.2<-gsub("Avenue", "Ave",dc$Street.2)
dc$Street<-gsub("Village", "Vlg",dc$Street)
dc$Street.2<-gsub("Village", "Vlg",dc$Street.2)

dc
write.csv(dc,"C:/Users/zy/Data-Cleanup-510-90-team-1/clean_data_b.csv",row.names=F)
