# Load necessary libraries
require(graphics)
require(Matrix)

num_points <- 40

# Create a PDF file for the plot
pdf(file="plots/Experiment1.pdf", width=3.7, height=4.0, family="serif", pointsize=14)

# Reading data
data1 <- matrix(NA, nrow = num_points, ncol = 2)
for (i in 1:num_points) {
    file_name <- paste0("results/Experiment1_times", i, ".dat")
    data1[i, 1] <- as.matrix(scan(file_name))[, 1]
}
for (i in 1:num_points) {
    file_name <- paste0("results/Experiment1_timeSF.dat")
    data1[i, 2] <- as.matrix(scan(file_name))[, 1]
}
proportions <- matrix(NA, nrow = num_points, ncol = 1)
for (i in 1:num_points) {
    file_name <- paste0("results/Experiment1_proportions", i, ".dat")
    proportions[i, 1] <- as.matrix(scan(file_name))[, 1]
}

data <- as.matrix((data1 + 1500 )/ 1000)

# Read the x-axis tick labels from file
addedXSizes <- scan("results/Experiment1_addedXSize.dat")
totalSize <- scan("results/Experiment1_totalXSize.dat")
proportions <- proportions * 100

proportions_lab <- round(proportions, 1)

addedXSizes = addedXSizes/1000
addedXSizes <- round(addedXSizes, 1)

# Use indices for x-values to ensure equal spacing
x_values <- seq_along(proportions_lab)

# Plot the first column of data
plot(x_values, data[, 1],  
    type="o",           
    pch=19, 
    cex=0.4,
    col="cornflowerblue",    
    main="Increasing Proportion of Added X, Same Total Size",
    cex.main=0.7,          
    xlab="",     
    ylab="",         
    axes=FALSE,    
    bg="gray40",
    log="y",
    lwd=1.1, 
    lty=1,
    ylim = c(0.1, 100))

# Add the second column of data
lines(x_values, data[, 2], type = "o", col = "gray40", lty = 2, pch = 19, cex=0.2)

ticks = seq(2, num_points, 2)

# Custom x-axis
axis(1, at=x_values[ticks], labels=proportions_lab[ticks], las=1, cex.axis=0.4)

# Custom y-axis
axis(2, las=2, at=c(0.1, 0.5, 1, 5, 10), labels=c("0.1","0.5", "1", "5", "10"), cex.axis=0.4)



# Add labels and legend
mtext(2, text="Execution time (s)",line=2.7, cex=0.7) 
mtext(1, text=expression(paste(frac(abs(italic(" addedX ")), abs(italic(" totalX "))), "  (in %)")) ,line=3, cex=0.65) 
text(x = x_values[length(x_values)/5], y = 40, labels = bquote(paste(abs(italic(" totalX "))," = ", .(totalSize))), cex = 0.5)

legend("topright", legend = c("IncSliceLine", "SliceLine"), 
       col = c("cornflowerblue", "gray40"), lty = 1:2, pch = 19, cex=0.7)

# Box around plot
box()	              

# Close PDF device
dev.off()
