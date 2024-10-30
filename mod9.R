library(tidyverse)
library(usmap)

# load data
guns <- read.csv("Guns.csv")
str(guns)
head(guns)

# clean data.frame
guns <- guns %>% select(-rownames)
guns <- guns %>% select(-afam, -cauc, -male)
guns$totalCrime <- violent + murder + robbery
d

attach(guns)

# plot 1
ggplot(guns, aes(totalCrime, year, group=year,color=law)) +
  geom_point(position = position_jitter(w= 0.1, h=0.1)) +
  geom_line(col="grey20") +
  scale_shape_manual(values = 4)

# plot 2
ggplot(guns, aes(totalCrime, prisoners, color = income)) +
  geom_point() 
# subset the dat to remove higher values
guns2 <- guns[guns$totalCrime<2000 & prisoners < 1000,]
ggplot(guns2, aes(totalCrime, prisoners, color = income, alpha = 0.2)) +
  geom_point()          


# plot 3
crime1980 <- guns[year==1980,]
crime1980$state <- tolower(crime1980$state)
statesMap <- map_data("state")
mapData <- statesMap %>%
  left_join(crime1980, by = c("region" = "state"))

ggplot(mapData, aes(x = long, y = lat, group = group, fill = totalCrime)) +
  geom_polygon(color = "white") +
  coord_fixed(1.3) +  
  scale_fill_gradient(low = "lightblue", high = "navyblue", na.value = "grey") +
  labs(fill = "Total Crime") +
  theme_minimal() +
  theme(
    axis.text = element_blank(),
    axis.title = element_blank(),
    axis.ticks = element_blank()
  ) +
  ggtitle("U.S. States Shaded by Total Crime")       