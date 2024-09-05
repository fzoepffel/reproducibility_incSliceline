require(graphics)
require(Matrix)

proportions <- c(0.01, 0.03, 0.09, 0.30, 0.50, 0.99)

for( i in 1:6){
  file_name1 <- paste0("plots/Experiment5_BothDisabled", i, "NoWhiteNoTitle.pdf")
  pdf(file=file_name1,width=3.2, height=2.5, family="serif", pointsize=14)
  par(mar = c(1.7, 2.2, 0.2, 0.2) + 0.1) 

  data0 = read.table("results/Experiment5SF_D.dat", sep=",")[,2:3]
  file_name2 <- paste0("results/Experiment5_D_BothDisabled", i, ".dat")
  data2 = read.table(file_name2, sep=",")[,2:3]
  data1 = t(as.matrix(data0))
  data1 = rbind(data1, t(as.matrix(data2)))

  plot_colors <- c("cornflowerblue","#B0C4DE","#ED9464","#FFDAB9")

  prop <- proportions[i]

  print(ncol(data1))

  par(mgp = c(3, 0.1, 0)) # Second value (0.6) controls the position of the labels

  barplot(data1, 
          main = "",
          cex.main = 0.7,
          space = c(0, 0.3),
          xlab = "", 
          ylab = "",
          col=plot_colors,
          ylim = c(0,5500),
          log = "",
          axes = FALSE, 
          names.arg = c("1","2","3","4","5","6","7","8"),
          cex.names = 0.5,
          args.legend = list(x="topright", bty="n", ncol=1),
          beside = TRUE
  )
  par(mgp = c(3, 0.6, 0))
  axis(2, las=1, cex.axis=0.6) 
  mtext(2, text="# Enumerated Slices", line=1.5, cex=0.6) 
  mtext(1, text="Lattice Level L", line=0.7, cex=0.6) 

  # add prop to the paste in expression
  text(x = 30, y = 2600, labels = bquote(paste(frac(abs(italic(" addedX ")), abs(italic(" totalX "))), " = ", .(prop))), cex = 0.6)
  text(x = 30, y = 1800, labels = expression(paste(abs(italic(" totalX ")), " = 32.6k")), cex = 0.6)

  # Add a legend
  legend("topright", legend = c("SF: Evaluated", "SF: Valid","incSL: Evaluated", "incSL: Valid" ), 
         fill = plot_colors, cex=0.6)

  box()  # Box around plot       
  dev.off()

  # Save the data to a CSV file
  output_file <- paste0("results/allData/Experiment5_BothDisabled", i, "_AllData.csv")
  output_data <- as.data.frame(t(data1))  # Transpose the data back for saving
  colnames(output_data) <- c("SF_Evaluated", "SF_Valid", "incSL_Evaluated", "incSL_Valid")
  
}
