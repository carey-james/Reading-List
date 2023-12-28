# Load Libraries
library(ggplot2)
library(tidyverse)
library(hrbrthemes)

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

ggplot(data=books,
	aes(x=Year.Written),
	geom_histogram())