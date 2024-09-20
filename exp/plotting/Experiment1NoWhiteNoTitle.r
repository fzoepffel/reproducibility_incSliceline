
require(graphics)
require(Matrix)

num_points <- 20

pdf(file="plots/Experiment1NoWhiteNoTitle.pdf", width=3.0, height=2.5, family="serif", pointsize=14)

par(mar = c(2.9, 2.0, 0.2, 0.2) + 0.1) 

data1 <- matrix(NA, nrow = num_points, ncol = 3)
for (i in 1:num_points) {
    file_name <- paste0("results/Experiment1_times", i, ".dat")
    data1[i, 1] <- as.matrix(scan(file_name))[, 1]
}
for (i in 1:num_points) {
    file_name <- paste0("results/Experiment1_timeSF.dat")
    data1[i, 2] <- as.matrix(scan(file_name))[, 1]
}
for (i in 1:num_points) {
    file_name <- paste0("results/Experiment1_encoded_times", i, ".dat")
    data1[i, 3] <- as.matrix(scan(file_name))[, 1]
}
proportions <- matrix(NA, nrow = num_points, ncol = 1)
for (i in 1:num_points) {
    file_name <- paste0("results/Experiment1_proportions", i, ".dat")
    proportions[i, 1] <- as.matrix(scan(file_name))[, 1]
}

data <- as.matrix((data1 + 1500 )/ 1000)

addedXSizes <- scan("results/Experiment1_addedXSize.dat")
totalSize <- scan("results/Experiment1_totalXSize.dat")
proportions <- proportions * 100

proportions_lab <- round(proportions, 1)

addedXSizes = addedXSizes/1000
addedXSizes <- round(addedXSizes, 1)

x_values <- seq_along(proportions_lab)
par(mgp = c(3, 0.6, 0))

plot(x_values, data[, 1],  
    type="o",           
    pch=19, 
    cex=0.4,
    col="cornflowerblue",    
    main="",           
    xlab="",     
    ylab="",         
    axes=FALSE,    
    bg="gray40",
    log="y",
    lwd=1.1, 
    lty=1,
    ylim = c(0.5, 500))

lines(x_values, data[, 2], type = "o", col = "gray40", lty = 1, pch = 19, cex=0.4)
lines(x_values, data[, 3], type = "o", col = "black", lty = 1, pch = 19, cex=0.4)

ticks = seq(2, num_points, 2)

axis(1, at=x_values[ticks], labels=proportions_lab[ticks], las=1, cex.axis=0.6)

y_ticks <- 10^seq(log10(1), log10(10), length.out = 7)
axis(2, las=2, at=y_ticks, labels=round(y_ticks, 1), cex.axis=0.6)

mtext(2, text="Execution time (s)",line=1.3, cex=0.6) 
mtext(1, text=expression(paste(frac(abs(italic(" addedX ")), abs(italic(" totalX "))), "  (in %)")) ,line=2, cex=0.6) 
text(x = x_values[length(x_values)/5], y = 40, labels = bquote(paste(abs(italic(" totalX "))," = ", .(totalSize))), cex = 0.6)

legend("topright", legend = c("IncSL Decoded", "incSL Encoded", "SliceLine"), 
       col = c("cornflowerblue", "black", "gray40"), lty = 1, pch = 19, cex=0.6)

box()	              

dev.off()

output_data <- data.frame(Proportion = proportions_lab, Time_IncSliceLine = data[, 1], Time_SliceLine = data[, 2])
