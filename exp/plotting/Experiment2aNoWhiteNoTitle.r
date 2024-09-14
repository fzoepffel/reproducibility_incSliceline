require(graphics)
require(Matrix)

numOfPoints <- 100

# Create a PDF file for the plot
pdf(file="plots/Experiment2aNoWhiteNoTitle.pdf",width=3.2, height=2.5,family="serif", pointsize=14)
par(mar = c(2.2, 2.0, 0.2, 0.2) + 0.1) 

# Reading data
data1 <- matrix(NA, nrow = numOfPoints, ncol = 2)
for (i in 1:numOfPoints) {
    file_name <- paste0("results/Experiment2_times", (i +10), ".dat")
    data1[i, 1] <- as.matrix(scan(file_name))[, 1]
}
for (i in 1:numOfPoints) {
    file_name <- paste0("results/Experiment2_timesSF", (i +10), ".dat")
    data1[i, 2] <- as.matrix(scan(file_name))[, 1]
}

data <- as.matrix(data1 / 1000)

# Read the x-axis tick labels from file
x_labels <- matrix(NA, nrow = 0, ncol = 1)
for(i in 1:10) {
    file_name = paste0("results/Experiment2_nrows", i, ".dat")
    x_labels1 <- as.matrix(scan(file_name))
    x_labels <- rbind(x_labels, x_labels1)
}

x_labels <- x_labels / 1000
x_labels <- round(x_labels, 1)

points <- seq(1, numOfPoints)
plot_colors <- c("cornflowerblue", "gray40", "black", "orange", "orangered")

lastX <- 100

# Adjust the mgp parameter to move tick values closer to the axes
par(mgp = c(3, 0.6, 0))

# Plot the first column of data
plot(tail(points, lastX), tail(data[, 1], lastX),  
    main="",
    cex.main=0.7,    
    type="o",           
    pch=19, 
    cex=0.1,
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
lines(points, data[, 2], type = "o", cex=0.1, col = plot_colors[2], lty = 1, pch = 19)

lastXPoints <- tail(points, lastX)
lastXData <- tail(x_labels, lastX)
y_ticks <- 10^seq(log10(0.1), log10(10), length.out = 7)

# Adjust the axis functions without the line argument, using the mgp settings from par
axis(2, las=2, at=y_ticks, labels=round(y_ticks, 1), cex.axis=0.6)
axis(1, las=1, at=lastXPoints[seq(1, length(lastXPoints), by=ceiling(length(lastXPoints)/10))], 
     labels=lastXData[seq(1, length(lastXData), by=ceiling(length(lastXData)/10)), ], cex.axis=0.6)

mtext(2, text="Execution time (s)", line=1.3, cex=0.6) 
mtext(1, text="Size Feature Mat. ((# rows)/1000)", line=1.3, cex=0.6) 

text(x = lastXPoints[floor(length(lastXPoints)/4)], y = 35, 
     labels = expression(paste(frac(abs(italic(" addedX ")), abs(italic(" totalX "))), " = 0.0005")), cex = 0.6)

# Add a legend
legend("topright", legend = c("IncSliceLine", "SliceLine"), 
       col = plot_colors[1:2], lty = 1:2, pch = 19, cex=0.6)

box()	              # box around plot       
dev.off()

# Save the x and y data to a CSV file
output_data <- data.frame(X_Labels = lastXData, Time_IncSliceLine = tail(data[, 1], lastX), Time_SliceLine = tail(data[, 2], lastX))
