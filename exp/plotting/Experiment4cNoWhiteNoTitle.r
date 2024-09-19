require(graphics)
require(Matrix)

numOfPoints <- 100
lastX <- 10

# Create a PDF file for the plot
pdf(file="plots/Experiment4_Prop30NoWhiteNoTitle.pdf", width=3.2, height=2.5, family="serif", pointsize=14)
par(mar = c(2.2, 2.0, 0.2, 0.2) + 0.1) 

# Reading data
data1 <- matrix(NA, nrow = numOfPoints, ncol = 5)
for (i in (numOfPoints - lastX + 1):(numOfPoints)) {
    file_name <- paste0("results/Experiment4_times_AllDisabled_Prop30_", (i + 10), ".dat")
    data1[i, 1] <- as.matrix(scan(file_name))[, 1]
}
for (i in (numOfPoints - lastX + 1):(numOfPoints)) {
    file_name <- paste0("results/Experiment4_times_NoneDisabled_Prop30_", (i + 10), ".dat")
    data1[i, 2] <- as.matrix(scan(file_name))[, 1]
}
for (i in (numOfPoints - lastX + 1):(numOfPoints)) {
    file_name <- paste0("results/Experiment4_times_OnlyScore_Prop30_", (i + 10), ".dat")
    data1[i, 3] <- as.matrix(scan(file_name))[, 1]
}
for (i in (numOfPoints - lastX + 1):(numOfPoints)) {
    file_name <- paste0("results/Experiment4_times_OnlySlice_Prop30_", (i + 10), ".dat")
    data1[i, 4] <- as.matrix(scan(file_name))[, 1]
}
for (i in (numOfPoints - lastX + 1):(numOfPoints)) {
    file_name <- paste0("results/Experiment4_timesSF_", (i + 10), ".dat")
    data1[i, 5] <- as.matrix(scan(file_name))[, 1]
}
for (i in (numOfPoints - lastX +1):(numOfPoints)) {
    file_name <- paste0("results/Experiment4_times_OnlyMaxScore_Prop1_", (i +10), ".dat")
    data1[i, 6] <- as.matrix(scan(file_name))[, 1]
}

data <- as.matrix(data1 / 1000)

# Read the x-axis tick labels from file
x_labels <- matrix(NA, nrow = 0, ncol = 1)
for (i in ((numOfPoints - lastX + 10)/10):10) {
    file_name <- paste0("results/Experiment4_nrows_Prop30_", i, ".dat")
    x_labels1 <- as.matrix(scan(file_name))
    x_labels <- rbind(x_labels, x_labels1)
}

x_labels <- x_labels / 1000
x_labels <- round(x_labels, 1)

points <- seq(1, numOfPoints)
plot_colors <- c("#d62728", "#ff7f0e","#2ca02c", "cornflowerblue", "gray40", "black")

par(mgp = c(3, 0.6, 0))

# Plot the first column of data
plot(tail(points, lastX), tail(data[, 1], lastX),  
    main="",
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
lines(points, data[, 2], type = "o", cex=0.4, col = plot_colors[2], lty = 1, pch = 19)
lines(points, data[, 3], type = "o", cex=0.4, col = plot_colors[3], lty = 1, pch = 19)
lines(points, data[, 4], type = "o", cex=0.4, col = plot_colors[4], lty = 1, pch = 19)
lines(points, data[, 5], type = "o", cex=0.4, col = plot_colors[5], lty = 1, pch = 19)
lines(points, data[, 6], type = "o", cex=0.4, col = plot_colors[6], lty = 1, pch = 19)

lastXPoints <- tail(points, lastX)
lastXData <- tail(x_labels, lastX)
y_ticks <- 10^seq(log10(0.1), log10(10), length.out = 7)

axis(2, las=2, at=y_ticks, labels=round(y_ticks, 1), cex.axis=0.6)
axis(1, las=1, at=lastXPoints[seq(1, length(lastXPoints), by=ceiling(length(lastXPoints)/10))], 
     labels=lastXData[seq(1, length(lastXData), by=ceiling(length(lastXData)/10))], cex.axis=0.6)

mtext(2, text="Execution time (s)", line=1.3, cex=0.6) 
mtext(1, text="Size Feature Mat. ((# rows)/1000)", line=1.3, cex=0.6) 

text(x = lastXPoints[floor(length(lastXPoints)/3)*2], y = 35, 
     labels = expression(paste(frac(abs(italic(" addedX ")), abs(italic(" totalX "))), " = 0.5")), cex = 0.6)

# Add a legend
legend("topleft", legend = c("No Pruning", "Full Pruning", "Size Pruning", "Score Pruning", "SliceLine"), 
       col = plot_colors[1:5], lty = 1:2, pch = 19, cex=0.6)

box()	              # box around plot       
dev.off()

# Save the data to a CSV file
output_data <- data.frame(X_Labels = lastXData, 
                          No_Pruning = tail(data[, 1], lastX), 
                          Full_Pruning = tail(data[, 2], lastX), 
                          Size_Pruning = tail(data[, 3], lastX), 
                          Score_Pruning = tail(data[, 4], lastX), 
                          SliceLine = tail(data[, 5], lastX))
