require(graphics)
require(Matrix)

pdf(file="plots/Experiment2.pdf",
    width=3.7, height=4.0, family="serif", pointsize=14)

data1 <- matrix(NA, nrow = 11, ncol = 2)
for (i in 1:11) {
    file_name <- paste0("results/Experiment2_times", i, ".dat")
    data1[i, 1] <- as.matrix(scan(file_name))[, 1]
}
for (i in 1:11) {
    file_name <- paste0("results/Experiment2_timesSF", i, ".dat")
    data1[i, 2] <- as.matrix(scan(file_name))[, 1]
}

data <- as.matrix(data1 / 1000)

# read the x-axis tick labels from file
x_labels <- scan("results/Experiment2_nrows.dat");
x_labels = x_labels/1000;
# reduce the number of digits after the decimal point
x_labels <- round(x_labels, 1)

points <- seq(1, 10)
plot_colors <- c("cornflowerblue","gray40","black","orange","orangered")

# Plot the first column of data
plot(points, data[2:11, 1],  
    main="Increasing Size of Feature Matrix, Same Proportions",
    cex.main=0.7,    
    type="o",           
    pch=19, 
    cex=1.1,
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
lines(points, data[2:11, 2], type = "o", col = plot_colors[2], lty = 2, pch = 19)

axis(2, las=2, at=c(0.1, 0.5, 1, 2, 5, 10), labels=c("0.1","0.5", "1", "2", "5", "10"), cex.axis=0.7) # horizontal y axis
axis(1, las=1, at=points, labels=x_labels[2:11], cex.axis=0.7) # vertical x axis
mtext(2, text="Execution time (s)",line=2.7, cex=0.7) 
mtext(1, text="Size Feature Mat. ((# rows)/1000)",line=2, cex=0.7) 

text(x = 2.8, y = 35, labels = expression(paste(frac(abs(italic(" addedX ")), abs(italic(" totalX "))), " = 0.03")), cex = 0.5)

# Add a legend
legend("topright", legend = c("IncSliceLine", "SliceLine"), 
       col = plot_colors[1:2], lty = 1:2, pch = 19, cex=0.7)

box()	              # box around plot       
dev.off() 
