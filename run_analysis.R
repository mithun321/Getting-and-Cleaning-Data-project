# X set combine

train = read.table("train/X_train.txt", header = FALSE)

trainData = as.matrix(train)

test = read.table("test/X_test.txt", header = FALSE)

testData = as.matrix(test)



# y set combine


train = read.table("train/y_train.txt", header = FALSE)
data = as.matrix(train)
l = length(train[[1]])

row.names(data) = 1:l
row.names(trainData) = 1:l
ytrain = data

test = read.table("test/y_test.txt", header = FALSE)
l = length(test[[1]])
data = as.matrix(test)

row.names(data) = 1:l
row.names(testData) = 1:l
ytest = data


X = rbind(trainData, testData)
y = rbind(ytrain, ytest)

# Subject set combine


train = read.csv("train/subject_train.txt", header = FALSE)
l = length(train[[1]])
t = train[1,]
data = t

for(i in 2:l){
  t = train[i,]
  t = as.character(t)
  t = strsplit(t, " ")
  t = t[[1]]
  t = t[t!=""]
  t = as.numeric(t)
  data = rbind(data, t)
}

row.names(data) = 1:l
subjecttrain = data

test = read.csv("test/subject_test.txt", header = FALSE)
l = length(test[[1]])
t = test[1,]
data = t

for(i in 2:l){
  t = test[i,]
  t = as.character(t)
  t = strsplit(t, " ")
  t = t[[1]]
  t = t[t!=""]
  t = as.numeric(t)
  data = rbind(data, t)
}

row.names(data) = 1:l
subjecttest = data

subject = rbind(subjecttrain, subjecttest)

l = length(y[,1])

row.names(X) = 1:l
row.names(y) = 1:l
row.names(subject) = 1:l

 rm(data)
 rm(subjecttest)
 rm(subjecttrain)
 rm(test)
 rm(train)
 rm(trainData)
 rm(testData)
 rm(ytest)
 rm(ytrain)
 rm(i)
 rm(l)
 rm(t)

# Convert to data.frame

colnames(y) = "y"
y = data.frame(y)

colnames(subject) = "subject"
subject = data.frame(subject)

data = read.table("features.txt", header = FALSE)
name = as.character(data[,2])
colnames(X) = name
X = data.frame(X)
rm(data)
names(X) = name
rm(name)

# activity names for y
data = read.table("activity_labels.txt", header = FALSE)
names(data) = tolower(names(data))
data$v1 = as.numeric(data$v1)

activity = rep("null", length(y$y))

for(i in 1:(dim(data)[1])){
  place = (y$y == data$v1[i])
  activity[place] = as.character(data$v2[i])
}

activity = as.matrix(activity)

colnames(activity) = "activity"

activity = data.frame(activity)

rm(data)
rm(i)
rm(place)

# Extracts only the measurements on the mean and standard deviation

n = names(X)
trimX = X[,grepl("mean\\(\\)|std\\(\\)", n)]

rm(n)

# preparing output
data = cbind(subject, trimX, activity)

write.csv(data, "tidydata.txt",  row.names=FALSE)
# preparing second data
n = names(data)
#n = n[2:(length(n)-1)]
group = aggregate(data[[2]], 
          by=list(data$subject,data$activity), FUN=mean, na.rm=TRUE)
l = length(group[[1]])
group$var = rep(n[2], l)

for(i in 3:(length(n)-1)){
  d = aggregate(data[[i]], 
                    by=list(data$subject,data$activity), FUN=mean, na.rm=TRUE)
  d$var = rep(n[i], l)
  group = rbind(group, d)
}

names(group) = c("subject", "activity", "Average", "variable.name")

rm(d)
rm(i)
rm(n)
rm(l)

write.csv(group, "group_average.txt",  row.names=FALSE)

combined = cbind(subject, X, y)

write.csv(combined, "combined.txt",  row.names=FALSE)
