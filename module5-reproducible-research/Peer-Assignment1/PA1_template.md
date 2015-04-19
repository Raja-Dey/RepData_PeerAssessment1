# Module5-Reproducible-Research-Peer-Assignment1
Raja dey  
Sunday, April 18, 2015  

### Settings

```r
echo = TRUE  # Makes the code visible
```

### Loading and processing the data

```r
unzip("activity.zip")
data <- read.csv("activity.csv", colClasses = c("integer", "Date", "factor"))
#data$month <- as.numeric(format(data$date, "%m"))
data_noNA <- na.omit(data)
rownames(data_noNA) <- 1:nrow(data_noNA)
head(data_noNA)
```

```
##   steps       date interval
## 1     0 2012-10-02        0
## 2     0 2012-10-02        5
## 3     0 2012-10-02       10
## 4     0 2012-10-02       15
## 5     0 2012-10-02       20
## 6     0 2012-10-02       25
```

```r
dim(data_noNA)
```

```
## [1] 15264     3
```

### What is mean total number of steps taken per day?
For this part of the assignment, you can ignore the missing values in the dataset.

* Calculate the total number of steps taken per day
* Make a histogram of the total number of steps taken each day

```r
DailyTotalSteps <- aggregate(steps ~ date, data_noNA, sum)
DailyTotalSteps$month <- as.numeric(format(DailyTotalSteps$date, "%m"))
head(DailyTotalSteps)
```

```
##         date steps month
## 1 2012-10-02   126    10
## 2 2012-10-03 11352    10
## 3 2012-10-04 12116    10
## 4 2012-10-05 13294    10
## 5 2012-10-06 15420    10
## 6 2012-10-07 11015    10
```

```r
library(ggplot2)
ggplot(DailyTotalSteps, aes(date, steps)) + geom_bar(stat = "identity", colour = "magenta", fill = "magenta", width = 0.6) + facet_grid(. ~ month, scales = "free") + labs(title = "Histogram of Total Number of Steps Taken Each Day", x = "Date", y = "Total number of steps")
```

![](PA1_template_files/figure-html/unnamed-chunk-3-1.png) 

Calculate and report the mean and median of the total number of steps taken per day 

* Mean total number of steps taken per day:

```r
mean(DailyTotalSteps$steps)
```

```
## [1] 10766.19
```
* Median total number of steps taken per day:

```r
median(DailyTotalSteps$steps)
```

```
## [1] 10765
```

### What is the average daily activity pattern?
* Make a time series plot (i.e. type = "l") of the 5-minute interval (x-axis) and the average number of steps taken, averaged across all days (y-axis)


```r
Interval_avgSteps <- aggregate(data_noNA$steps, list(interval = as.numeric(as.character(data_noNA$interval))), FUN = "mean")
names(Interval_avgSteps)[2] <- "IntervalMeanSteps"

ggplot(Interval_avgSteps, aes(interval, IntervalMeanSteps)) + geom_line(color = "magenta", size = 0.7) + labs(title = "Time Series Plot of the 5-minute Interval", x = "5-minute intervals in a day", y = "Average number of steps in each 5-min interval")
```

![](PA1_template_files/figure-html/unnamed-chunk-6-1.png) 

* Which 5-minute interval, on average across all the days in the dataset, contains the maximum number of steps?

```r
Interval_avgSteps[Interval_avgSteps$IntervalMeanSteps == max(Interval_avgSteps$IntervalMeanSteps), ]
```

```
##     interval IntervalMeanSteps
## 104      835          206.1698
```

### Imputing missing values
* Calculate and report the total number of missing values in the dataset (i.e. the total number of rows with NAs)


```r
sum(is.na(data))
```

```
## [1] 2304
```

* Devise a strategy for filling in all of the missing values in the dataset. The strategy does not need to be sophisticated. For example, you could use the mean/median for that day, or the mean for that 5-minute interval, etc.

My strategy is to use the mean for that 5-minute interval to fill each NA value in the steps column.

* Create a new dataset that is equal to the original dataset but with the missing data filled in.


```r
fillData <- data 
for (i in 1:nrow(fillData)) {
    if (is.na(fillData$steps[i])) {
        fillData$steps[i] <- Interval_avgSteps[which(fillData$interval[i] == Interval_avgSteps$interval), ]$IntervalMeanSteps
    }
}
fillData$month <- as.numeric(format(fillData$date, "%m"))
head(fillData)
```

```
##       steps       date interval month
## 1 1.7169811 2012-10-01        0    10
## 2 0.3396226 2012-10-01        5    10
## 3 0.1320755 2012-10-01       10    10
## 4 0.1509434 2012-10-01       15    10
## 5 0.0754717 2012-10-01       20    10
## 6 2.0943396 2012-10-01       25    10
```

```r
sum(is.na(fillData))
```

```
## [1] 0
```

* Make a histogram of the total number of steps taken each day and Calculate and report the mean and median total number of steps taken per day. 


```r
ggplot(fillData, aes(date, steps)) + geom_bar(stat = "identity",
                                             colour = "magenta",
                                             fill = "magenta",
                                             width = 0.6) + facet_grid(. ~ month, scales = "free") + labs(title = "Histogram of Total Number of Steps Taken Each Day (Filled Data)", x = "Date", y = "Total number of steps")
```

![](PA1_template_files/figure-html/unnamed-chunk-10-1.png) 

* Do these values differ from the estimates from the first part of the assignment? What is the impact of imputing missing data on the estimates of the total daily number of steps?

New total number of steps taken per day:

```r
newDailyTotalSteps <- aggregate(steps ~ date, fillData, sum)
newDailyTotalSteps$month <- as.numeric(format(newDailyTotalSteps$date, "%m"))
head(newDailyTotalSteps)
```

```
##         date    steps month
## 1 2012-10-01 10766.19    10
## 2 2012-10-02   126.00    10
## 3 2012-10-03 11352.00    10
## 4 2012-10-04 12116.00    10
## 5 2012-10-05 13294.00    10
## 6 2012-10-06 15420.00    10
```

* New mean total number of steps taken per day:

```r
newMean <- mean(newDailyTotalSteps$steps)
newMean
```

```
## [1] 10766.19
```
* New median total number of steps taken per day:

```r
newMedian <- median(newDailyTotalSteps$steps)
newMedian
```

```
## [1] 10766.19
```

Compare them with the two before imputing missing data:

```r
oldMean <- mean(DailyTotalSteps$steps)
oldMedian <- median(DailyTotalSteps$steps)
Difference_Mean <- newMean - oldMean
round(Difference_Mean)
```

```
## [1] 0
```

```r
Difference_Median <- newMedian - oldMedian
round(Difference_Median)
```

```
## [1] 1
```
So, after imputing the missing data, the new mean of total steps taken per day is the same as that of the old mean; the new median of total steps taken per day is one greater than that of the old median.

### Are there differences in activity patterns between weekdays and weekends?

* Create a new factor variable in the dataset with two levels - "weekday" and "weekend" indicating whether a given date is a weekday or weekend day.


```r
head(fillData)
```

```
##       steps       date interval month
## 1 1.7169811 2012-10-01        0    10
## 2 0.3396226 2012-10-01        5    10
## 3 0.1320755 2012-10-01       10    10
## 4 0.1509434 2012-10-01       15    10
## 5 0.0754717 2012-10-01       20    10
## 6 2.0943396 2012-10-01       25    10
```

```r
fillData$weekdays <- factor(format(fillData$date, "%A"))
levels(fillData$weekdays)
```

```
## [1] "Friday"    "Monday"    "Saturday"  "Sunday"    "Thursday"  "Tuesday"  
## [7] "Wednesday"
```

```r
levels(fillData$weekdays) <- list(weekday = c("Monday", "Tuesday",
                                             "Wednesday", 
                                             "Thursday", "Friday"),
                                 weekend = c("Saturday", "Sunday"))
levels(fillData$weekdays)
```

```
## [1] "weekday" "weekend"
```

```r
table(fillData$weekdays)
```

```
## 
## weekday weekend 
##   12960    4608
```

* Make a panel plot containing a time series plot (i.e. type = "l") of the 5-minute interval (x-axis) and the average number of steps taken, averaged across all weekday days or weekend days (y-axis).


```r
NewInterval_avgSteps <- aggregate(fillData$steps, 
                      list(interval = as.numeric(as.character(fillData$interval)), 
                           weekdays = fillData$weekdays),
                      FUN = "mean")
names(NewInterval_avgSteps)[3] <- "NewIntervalMeanSteps"
library(lattice)
xyplot(NewInterval_avgSteps$NewIntervalMeanSteps ~ NewInterval_avgSteps$interval | NewInterval_avgSteps$weekdays, 
       layout = c(1, 2), type = "l", col = "magenta", main="Differences in activity patterns between weekdays and weekends", 
       xlab = "5-min intervals in a day (Filled Data)", ylab = "Average Number of steps")
```

![](PA1_template_files/figure-html/unnamed-chunk-16-1.png) 

