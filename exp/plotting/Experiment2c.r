require(graphics)
require(Matrix)

numOfPoints <- 100

pdf(file="plots/Experiment2c.pdf",
    width=3.7, height=4.0, family="serif", pointsize=14)

data1 <- matrix(NA, nrow = (numOfPoints), ncol = 2)
for (i in 1:(numOfPoints)) {
    file_name <- paste0("results/Experiment2_times", (i +10), ".dat")
    data1[i, 1] <- as.matrix(scan(file_name))[, 1]
}
for (i in 1:(numOfPoints)) {
    file_name <- paste0("results/Experiment2_timesSF", (i +10), ".dat")
    data1[i, 2] <- as.matrix(scan(file_name))[, 1]
}

data <- as.matrix((data1) / 1000)

# read the x-axis tick labels from file
x_labels <- matrix(NA, nrow = 0, ncol = 1)
for(i in 1:10) {
    file_name = paste0("results/Experiment2_nrows", i, ".dat")
    x_labels1 <- as.matrix(scan(file_name));
    x_labels <- rbind(x_labels, x_labels1)
}

x_labels = x_labels/1000;
# reduce the number of digits after the decimal point
x_labels <- round(x_labels, 1)

points <- seq(1, numOfPoints)
plot_colors <- c("cornflowerblue","gray40","black","orange","orangered")

# remove the 11th, 21st, 31st, ..., 91st row from data and points 
# as these are slower as they are the first runs of the experiments
#data <- data[-seq(1, 91, 10),]
#points <- points[-seq(1, 91, 10)]

lastX <- 10;

# only keep the 

# Plot the first column of data
plot(tail(points, lastX), tail(data[, 1], lastX),  
    main="10x Increasing Input Size, Same Proportions",
    cex.main=0.7,    
    type="o",           
    pch=19, 
    cex=0.4,
    col=plot_colors[1],                
    xlab="",     
    ylab="",         
    axes=FALSE,    
    bg=plot_colors[3],
    log="y",
    lwd=1.1, 
    lty=1,
    ylim = c(0.1, 100))

# Add the second column of data
lines(points, data[, 2], type = "o", cex=0.4, col = plot_colors[2], lty = 2, pch = 19)

lastXPoints <- tail(points, lastX)
lastXData <- tail(x_labels, lastX)

axis(2, las=2, at=c(0.1, 0.5, 1, 2, 5, 10), labels=c("0.1","0.5", "1", "2", "5", "10"), cex.axis=0.7) # horizontal y axis
axis(1, las=1, at=lastXPoints[seq(1, length(lastXPoints), by=ceiling(length(lastXPoints)/10))], labels=lastXData[seq(1, length(lastXData), by=ceiling(length(lastXData)/10)), ], cex.axis=0.5) # vertical x axis
mtext(2, text="Execution time (s)",line=2.7, cex=0.7) 
mtext(1, text="Size Feature Mat. ((# rows)/1000)",line=2, cex=0.7) 

text(x = lastXPoints[floor(length(lastXPoints)/3)] , y = 35, labels = expression(paste(frac(abs(italic(" addedX ")), abs(italic(" totalX "))), " = 0.03")), cex = 0.5)

# Add a legend
legend("topright", legend = c("IncSliceLine", "SliceLine"), 
       col = plot_colors[1:2], lty = 1:2, pch = 19, cex=0.7)

box()	              # box around plot       
dev.off() 
