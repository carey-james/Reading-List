# Load Libraries
library(ggplot2)
library(tidyverse)
library(broom)
library(dplyr)
library(sf)
library(maps)
library(devtools)

# Load Data
books_2022 <- read.table('../../2022/books.csv',
	sep='|',
	header=TRUE,
	quote='')
books_2023 <- read.table('../../2023/books.csv',
	sep='|',
	header=TRUE,
	quote='')

books <- rbind(books_2022, books_2023)

# Load Geographic data
world_map <- read_sf('TM_WORLD_BORDERS_SIMPL-0.3.shp')
# Drop Antartica
world_map <- world_map[-c(145),]

# Functions for generating the graphs

# Gender Differences
gender_plotter <- function(bk, lb){
	
	# Load Data
	gender_counts <- bk %>% count(Gender)

	# Plot Graph
	ggplot(data=gender_counts, aes(x='', y=n, fill=Gender)) +
		geom_bar(stat='identity', width=1, color='white') +
		coord_polar('y', start=0) +
		theme_void()

	# Save Graph
	ggsave(paste(lb,'gender.png'))
}

# Author Location
map_plotter <- function(bk,mp){
	# Load Data
	country_counts <- bk %>% count(Country)

	# Merge Data
	mp = mp %>% left_join(. , country_counts, by=c('NAME'='Country'))
	#mp$n[ is.na(mp$n)] = 0

	# Plot Graph
	ggplot(mp) +
		geom_sf(color = "white", aes(fill = n)) +
		theme_void() +
		theme(legend.position = "none") +
		scale_fill_viridis_c(option = "E")

}

# Tufte Plotter
tufte_plotter <- function(bk){
	# Load Data
	source_url("https://raw.githubusercontent.com/sjmurdoch/fancyaxis/master/fancyaxis.R")
	bk$DATE <- as.Date(bk$Date.Finished,format = "%m/%d/%y")
	x <- bk$DATE
	y <- bk$Pages
	ggplot(x, y, main="", axes=FALSE, pch=16, cex=0.8,
    	xlab="Date", ylab="Pages", 
    	xlim=c(min(x)-10, max(x)), ylim=c(min(y)/1.5, max(y)))
	axis(1, tick=F)
	axis(2, tick=F, las=2)
	axisstripchart(faithful$waiting, 1)
	axisstripchart(faithful$eruptions, 2)
}


# Create Graphics
#gender_plotter(books_2022,'2022')
#gender_plotter(books_2023,'2023')
#map_plotter(books_2022,world_map)
tufte_plotter(books_2022)
