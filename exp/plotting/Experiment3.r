require(graphics)
require(Matrix)


for( i in 1:5){
  file_name1 <- paste0("plots/Experiment3_", i, ".pdf")
  pdf(file=file_name1,
    width=4.5, height=4.0, family="serif", pointsize=14)

  data0 = read.table("results/Experiment3SF_D.dat", sep=",")[,2:3]
  file_name2 <- paste0("results/Experiment3_D", i, ".dat")
  data2 = read.table(file_name2, sep=",")[,2:3]
  data1 = t(as.matrix(data0))
  data1 = rbind(data1, t(as.matrix(data2)))

  plot_colors <- c("cornflowerblue","#B0C4DE","#ED9464","#FFDAB9")

  print(ncol(data1))

  par(mgp = c(3, 0.5, 0))  # Second value (0.5) controls the position of the labels

  barplot( data1, 
          main = "Evaluated and Valid Slices in SliceFinder and incSliceLine",
          cex.main = 0.7,
          space = c(0, 0.3),
          xlab = "", 
          ylab = "",
          col=plot_colors,
          ylim = c(0,5000),
          log = "",
          axes = FALSE, 
          names.arg = c("1","2","3","4","5","6","7","8"),
          cex.names = 0.7,
          args.legend = list(x="topright", bty="n", bty="n", ncol=1),
          beside = TRUE
  )

  axis(2, las=1, cex.axis=0.8) 
  mtext(2,text="# Enumerated Slices",line=2, cex=0.7) 
  mtext(1,text="Lattice Level L",line=1.5, cex=0.7) 

  text(x = 30, y = 2400, labels = expression(paste(frac(abs(italic(" addedX ")), abs(italic(" totalX "))), " = 0.03")), cex = 0.5)
  text(x = 30, y = 1600, labels = expression(paste(abs(italic(" totalX ")), " = 32.6k")), cex = 0.5)

  # Add a legend
  legend("topright", legend = c("SF: Evaluated", "SF: Valid","incSL: Evaluated", "incSL: Valid" ), 
        fill = plot_colors, cex=0.65)

  box()	              # box around plot       
  dev.off() 

}
