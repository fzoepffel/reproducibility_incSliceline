require(graphics)
require(Matrix)

proportions <- c(0.0005, 0.03, 0.09, 0.30, 0.887, 0.9995)

for( i in 1:6){
  file_name1 <- paste0("plots/Experiment3_", i, ".pdf")
  pdf(file=file_name1, width=4.5, height=4.0, family="serif", pointsize=14)

  data0 = read.table("results/Experiment3SF_D.dat", sep=",")[,2:3]
  file_name2 <- paste0("results/Experiment3_D", i, ".dat")
  data2 = read.table(file_name2, sep=",")[,2:3]
  data1 = t(as.matrix(data0))
  data1 = rbind(data1, t(as.matrix(data2)))

  plot_colors <- c("cornflowerblue","#B0C4DE","#ED9464","#FFDAB9")

  prop <- proportions[i]

  print(ncol(data1))

  par(mgp = c(3, 0.6, 0))  # Second value (0.5) controls the position of the labels

  title <- paste0("Evaluated and Valid Slices, Proportion = ", prop)

  barplot(data1, 
          main = title,
          cex.main = 0.7,
          space = c(0, 0.3),
          xlab = "", 
          ylab = "",
          col=plot_colors,
          ylim = c(0,16000),
          log = "",
          axes = FALSE, 
          names.arg = c("1","2","3","4","5","6","7","8"),
          cex.names = 0.5,
          args.legend = list(x="topright", bty="n", bty="n", ncol=1),
          beside = TRUE
  )

  axis(2, las=1, cex.axis=0.5) 
  mtext(2, text="# Enumerated Slices", line=1.4, cex=0.5) 
  mtext(1, text="Lattice Level L", line=1.2, cex=0.5) 

  # Add prop to the paste in expression
  text(x = 29, y = 8000, labels = bquote(paste(frac(abs(italic(" addedX ")), abs(italic(" totalX "))), " = ", .(prop))), cex = 0.5)
  text(x = 29, y = 6000, labels = expression(paste(abs(italic(" totalX ")), " = 32.6k")), cex = 0.5)

  # Add a legend
  legend("topright", legend = c("SF: Evaluated", "SF: Valid","incSL: Evaluated", "incSL: Valid" ), 
         fill = plot_colors, cex=0.5)

  box()  # Box around plot       
  dev.off() 

  # Save the data to a CSV file
  output_file <- paste0("results/allData/Experiment3_", i, "_AllData.csv")
  output_data <- as.data.frame(t(data1))  # Transpose the data back for saving
  colnames(output_data) <- c("SF_Evaluated", "SF_Valid", "incSL_Evaluated", "incSL_Valid")
  write.table(output_data, file = output_file, sep = ",", row.names = FALSE, col.names = TRUE)
}
