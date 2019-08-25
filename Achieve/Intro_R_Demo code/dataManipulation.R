#dplyr
install.packages("dplyr", dependencies = TRUE)
install.packages("hflights")

library(dplyr)
library(hflights)

head(hflights,3)


# base R: 
flights[flights$Month==1 & flights$DayofMonth==1, ]

# 
filter(hflights, Month==1 & DayofMonth==1)

head(filter(hflights, UniqueCarrier=="AA" | UniqueCarrier=="UA"),2) 
tail(filter(hflights, UniqueCarrier=="AA" | UniqueCarrier=="UA"),2)

filter(flights, UniqueCarrier %in% c("AA", "UA"))

# base R approach to select DepTime, ArrTime, and FlightNum columns
head(flights[, c("DepTime", "ArrTime", "FlightNum")])

# dplyr approach
print(select(flights, DepTime, ArrTime, FlightNum),n=6)


# use colon to select multiple contiguous columns, and use `contains` to match columns by name
# note: `starts_with`, `ends_with`, and `matches` (for regular expressions) can also be used to match columns by name
head(select(flights, Year:DayofMonth, contains("Taxi"), contains("Delay")))


# nesting method to select UniqueCarrier and DepDelay columns and filter for delays over 60 minutes
head(filter(select(flights, UniqueCarrier, DepDelay), DepDelay > 60))

flights %>%
  select(UniqueCarrier, DepDelay) %>%
  filter(DepDelay > 60) %>%
  head()

# create two vectors and calculate Euclidian distance between them
x1 <- 1:5; x2 <- 2:6

# Usual 
sqrt(sum((x1-x2)^2))

# chaining method
(x1-x2)^2 %>% sum() %>% sqrt()

# base R approach to select UniqueCarrier and DepDelay columns and sort by DepDelay
head(flights[order(flights$DepDelay), c("UniqueCarrier", "DepDelay")])

# dplyr approach
flights %>%
  select(UniqueCarrier, DepDelay) %>%
  arrange(DepDelay) %>% # arrange(desc(DepDelay)) for descending order
  head()


# base R approach to create a new variable Speed (in mph)
flights$Speed <- flights$Distance / flights$AirTime*60
head(flights[, c("Distance", "AirTime", "Speed")])

# dplyr approach (prints the new variable but does not store it)
flights %>%
  select(Distance, AirTime) %>%
  mutate(Speed = Distance/AirTime*60) %>%
  head()
# store the new variable: flights <- flights %>% mutate(Speed = Distance/AirTime*60)

# base R approaches to calculate the average arrival delay to each destination
head(aggregate(ArrDelay ~ Dest, flights, mean))

# or head(with(flights, tapply(ArrDelay, Dest, mean, na.rm=TRUE)))

# dplyr approach: create a table grouped by Dest, and then summarise each group by taking the mean of ArrDelay
flights %>%
  group_by(Dest) %>%
  summarise(avg_delay = mean(ArrDelay, na.rm=TRUE)) %>%
  head()

# for each carrier, calculate the percentage of flights cancelled or diverted
flights %>%
  group_by(UniqueCarrier) %>%
  summarise_each(funs(mean), Cancelled, Diverted) %>%
  head()

# for each carrier, calculate the minimum and maximum arrival and departure delays
flights %>%
  group_by(UniqueCarrier) %>%
  summarise_each(funs(min(., na.rm=TRUE), max(., na.rm=TRUE)), matches("Delay")) %>%
  head()

# for each day of the year, count the total number of flights and sort in descending order
flights %>%
  group_by(Month, DayofMonth) %>%
  summarise(flight_count = n()) %>%
  arrange(desc(flight_count)) %>%
  head()

# rewrite more simply with the `tally` function
flights %>%
  group_by(Month, DayofMonth) %>%
  tally(sort = TRUE)

# for each destination, count the total number of flights and the number of distinct planes that flew there
flights %>%
  group_by(Dest) %>%
  summarise(flight_count = n(), plane_count = n_distinct(TailNum)) %>%
  head()

# for each destination, show the number of cancelled and not cancelled flights
flights %>%
  group_by(Dest) %>%
  select(Cancelled) %>%
  table() %>%
  head()

# for each carrier, calculate which two days of the year they had their longest departure delays
# note: smallest (not largest) value is ranked as 1, so you have to use `desc` to rank by largest value
flights %>%
  group_by(UniqueCarrier) %>%
  select(Month, DayofMonth, DepDelay) %>%
  filter(min_rank(desc(DepDelay)) <= 2) %>%
  arrange(UniqueCarrier, desc(DepDelay)) %>%
  head()





# for each carrier, calculate which two days of the year they had their longest departure delays --- rewrite previous with the `top_n` function
flights %>%
  group_by(UniqueCarrier) %>%
  select(Month, DayofMonth, DepDelay) %>%
  top_n(2) %>%
  arrange(UniqueCarrier, desc(DepDelay))

# for each month, calculate the number of flights and the change from the previous month
flights %>%
  group_by(Month) %>%
  summarise(flight_count = n()) %>%
  mutate(change = flight_count - lag(flight_count))

# rewrite previous with the `tally` function
flights %>%
  group_by(Month) %>%
  tally() %>%
  mutate(change = n - lag(n))

# randomly sample a fixed number of rows, without replacement
flights %>% sample_n(5)

# randomly sample a fraction of rows, with replacement
flights %>% sample_frac(0.25, replace=TRUE)

# base R approach to view the structure of an object
str(flights)

# dplyr approach: better formatting, and adapts to your screen width
glimpse(flights)

mtcars %>% group_by(cyl) %>% do(head(.,2))

# Another example
models <- mtcars %>% group_by(cyl) %>% do(lm = lm(mpg ~ wt, data = .))
models %>% summarise(rsq = summary(lm)$r.squared)
