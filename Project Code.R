#Required packages

library(dplyr)    # for pipe operator
library(ggplot2)  # for display of plots
library(readr)    # to import datasets
library(lattice)  # to display graphs
library(lubridate)# for operations on date and time variables
library(tidyr)    # used to tidy data
library(forecast) # used for Box-Cox transformation
library(validate) # to use functions on dataframes

#Importing and Reading the data set
data1 <- read_csv("C:/Users/Amar/Documents/GitHub/Brazilian-ECommerce-Public-Dataset/data/olist_order_items_dataset.csv")
data2 <- read_csv("C:/Users/Amar/Documents/GitHub/Brazilian-ECommerce-Public-Dataset/data/olist_orders_dataset.csv")

#Order Items Dataset
head(data1)

#Overall Orders Dataset
head(data2)

#Joining Data set
#Left join ensures that we only pickup the data which has delivery status

data <- left_join(data2, data1, by = "order_id")  
head(data, 10)

#Understand
#To understand datatypes presented in the dataset, we are using summary() function
summary(data)

#The "Order_Status" Variable is an Ordinal variable andis converted into factor and leveled accordingly
data$order_status <- data$order_status %>% factor(levels = c("unavailable", "created", "cancelled", "approved", "processing","invoiced", "shipped", "delivered"), ordered = TRUE) 
class(data$order_status) # Checking class of variable after conversion
levels(data$order_status) # levelling order_status variable

#TIDY dataset

data$order_purchase_timestamp <- data$order_purchase_timestamp %>% dmy_hm()
data$order_delivered_customer_date <- data$order_delivered_customer_date %>% dmy_hm()
str(data)

#Scanning for missing values
#Scan I
colSums(is.na(data))

sum(is.na(data))

new_data <- na.omit(data) # removing NA values and keeping only rows with complete cases
colSums(is.na(new_data)) # Checking for removed NA values

#Tidy & Manipulate Data I
mutate_data <- mutate(new_data, delivery_time_in_hours = (ymd_hms(order_delivered_customer_date) - ymd_hms(order_purchase_timestamp)))
mutate_data$delivery_time_in_days <- round(mutate_data$delivery_time_in_hours)
head(mutate_data$delivery_time_in_hours) %>% round(0)

#Tidy & Manipulate Data II
mutate_data <- mutate_data %>% separate (order_purchase_timestamp, into = c("Date", "Time"), sep = " ")
mutate_data <- mutate_data %>% separate (Date, into = c("Year","Month", "Day"), sep = "-")
mutate_data <- mutate_data %>% separate (order_delivered_customer_date, into = c("O_Date", "O_Time"), sep = " ")
mutate_data <- mutate_data %>% separate (O_Date, into = c("O_Year","O_Month", "O_Day"), sep = "-")
select(mutate_data,Year,Month, Day,O_Year, O_Month, O_Day) %>% head()

#Ploting the histogram of price variable
hist(mutate_data$price, xlab = "Price of the goods ordered", main = "Histogram of Price Data")

box_price <- mutate_data %>%   filter(price <= 500)
head(box_price$price,20)

#Scan II
#Based on below box plot, the TUKEY's Method of Outlier detection is used to detect the outliers
boxplot(box_price$price, main = "BoxPlot of Price", ylab = "Price" , col = "red" )
grid()

#Handling outliers

cap<- function (x){         ## Capping the dataset to handle outliers
  quantiles <- quantile(x,c(.05, 0.25, 0.75, 0.95))
  x[ x < quantiles[2] - 1.5*IQR(x) ] <- quantiles[1]
  x[x > quantiles[3] + 1.5*IQR(x) ] <-quantiles[4]
  x
}
box_price$price<- box_price$price %>% cap()
boxplot(box_price$price, main = "BoxPlot of Price after capping", ylab= "Price", col ="green") ## Box Plot of Required Dataset
grid()

#Before Transformation
#The below histogram plot of filtered price variable (value less than 500) shows that the data is right skewed. Thus, appropriate measures are taken to reduce skewness of the dataset
hist(box_price$price, xlab = "Price", main="Histogram after filtering Price <= 500")
grid()

#Post Transformation
#After trying several transformations such box-cox, log10, log, min max normalisation and z-score, we found Sqrt method as the most appropriate method for the transformation.
squareroottransform <- sqrt(box_price$price)
hist(squareroottransform, xlab = "Square Root (Price)", main = "Histogram Plot for Normalised Data using Sqrt Transformation")





