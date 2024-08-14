require(graphics)
require(Matrix)

pdf(file="plots/Experiment1.pdf",
    width=3.7, height=4.0, family="serif", pointsize=14)

data1 <- matrix(NA, nrow = 10, ncol = 2)
for (i in 1:10) {
    file_name <- paste0("results/Experiment1_times", i, ".dat")
    data1[i, 1] <- as.matrix(scan(file_name))[, 1]
}
for (i in 1:10) {
    file_name <- paste0("results/Experiment1_timeSF.dat")
    data1[i, 2] <- as.matrix(scan(file_name))[, 1]
}
proportions <- matrix(NA, nrow = 10, ncol = 1)
for (i in 1:10) {
    file_name <- paste0("results/Experiment1_proportions",i,".dat")
    proportions[i, 1] <- as.matrix(scan(file_name))[, 1]
}

data <- as.matrix(data1 / 1000)

# read the x-axis tick labels from file
addedXSizes <- scan("results/Experiment1_addedXSize.dat");
totalSize <- scan("results/Experiment1_totalXSize.dat");
proportions <- proportions * 100

proportions_lab <- round(proportions,2)

print(proportions)

addedXSizes = addedXSizes/1000;
# reduce the number of digits after the decimal point
addedXSizes <- round(addedXSizes, 1)

points <- addedXSizes
plot_colors <- c("cornflowerblue","gray40","black","orange","orangered")

# Plot the first column of data
plot(proportions, data[, 1],  
    type="o",           
    pch=19, 
    cex=1.1,
    col=plot_colors[1],    
    main="Increasing Proportion of Added X, Same Total Size",
    cex.main=0.7,          
    xlab="",     
    ylab="",         
    axes=FALSE,    
    bg=plot_colors[3],
    log="xy",
    lwd=1.1, 
    lty=1,
    ylim = c(0.1, 100))

# Add the second column of data
lines(proportions, data[, 2], type = "o", col = plot_colors[2], lty = 2, pch = 19)

axis(2, las=2, at=c(0.1, 0.5, 1, 5, 10), labels=c("0.1","0.5", "1", "5", "10"), cex.axis=0.7) # horizontal y axis
axis(1, las=1, at=proportions, labels=proportions_lab, cex.axis=0.7) # vertical x axis
mtext(2, text="Execution time (s)",line=2.7, cex=0.7) 
mtext(1,text=expression(paste(frac(abs(italic(" addedX ")), abs(italic(" totalX "))), "  (in %)")) ,line=3, cex=0.65) 
text(x = 0.3, y = 40, labels = bquote(paste(abs(italic(" totalX "))," = ", .(totalSize))), cex = 0.5)

# Add a legend
legend("topright", legend = c("IncSliceLine", "SliceLine"), 
       col = plot_colors[1:2], lty = 1:2, pch = 19, cex=0.7)

box()	              # box around plot       
dev.off() 
