# Brazilian-ECommerce-Public Dataset
### Aim/Objective
* To perform necessary data pre-processing operations on the dataset to infer and perform analysis on the data
### Executive Summary
* First, the necessary packages are installed and loaded to use required operators and function for data pre-processing. The two datasets of interest are then imported into R workspace to perform required operations.

* Before performing the pre-processing task, the two datasets are merged using left join condition in order to gather the details of only those orders which has delivery status.

* The summary of merged dataset is presented which indicates statistical and general information of all the variables.

* The required variables are converted into suitable data types such as factor, character, numeric, etc. as required

* Post datatype conversions, the NA values are identified and omitted to perform required operations.

* Although the dataset is in UNTIDY format considering the presence of date and time in the same variable, we are interested to find processing time of the order.

* Another variable named delivery_time_in_hours is mutated to display the delivery time

* The dataset is then TIDIED to separate order, month and day from the order purchased and order delivery variables.

* The histogram of the price variable is presented to understand the frequency distribution of price values. The data set is then filtered considering that more than 80 % of values in the dataset lies below 500.

* The box plot of the filtered price data indicates the presence of outliers using TUKEYS’s Method of Outlier Detection. The outliers observed are handled using the CAPPING method via a user-defined function which caps the values above 95percentile of the data.

* The histogram displayed after removing the outliers indicates that the data is right skewed and we need to NORMALIZE it.

* Lastly, data transformation using SQUARE ROOT METHOD is done to reduce the skewness of the price variable

### Data
* The dataset named “Brazilian E-Commerce Public Dataset by Olist”, has over 100,000 Orders with product, customer and reviews info.

* Source : https://www.kaggle.com/olistbr/brazilian-ecommerce

* We have only considered 2 files amongst these whole dataset as desired by the assignment requirements which are olist_orders_dataset and olist_order_item_dataset

* These two data files have the variables as Order_id, product_id and seller_id which are alphanumeric, order_item_id, price and freight_value which are numeric, order_status is character but will be converted into ordered factor, order_purchase_timestamp and order_delivered_customer_date are date time variables denoting the time of order and the time of delivery which are again in the character type but will be converted into date and time datatype.
 
