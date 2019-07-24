synthetic_gen <- function(background, peak){
  
  bg <- background
  pk <- peak
  
  library(ggplot2)
  
  # Initiating a new data.frame for the synthetic data
  syn <- data.frame(ka = c(1:180))
  syn$yearsBP <- NA
  for (i in 1:nrow(syn)){
    syn$yearsBP[i] <- syn$ka[i] * 1000
  }
  
  
  # Generating the synthetic data
  # method:
  # 1) Background noise = 5 +/- 4;
  #    The variation is based on the normal distribution
  #    using rnorm(1, mean=5, sd=2) function with as.integer()function
  #    which is: as.integer(rnorm(1, mean=5, sd=2))
  # 2) Peaks at interglacial periods:
  #    when ka -> (14, 18) OR (123, 127)
  # 3) Data at peaks = 30 +/- 5
  #    which is: as.integer(rnorm(1, mean=30, sd=2.5))
  syn$events <- NA
  
  for (i in 1:nrow(syn)){
    if(isTRUE(i>=14 && i<=18) || isTRUE(i>=123 && i<=127)){
      syn$events[i] <- as.integer(rnorm(1, mean=pk, sd=2.5))
    } else {
      syn$events[i] <- as.integer(rnorm(1, mean=bg, sd=2))
    }
  }
  
  # plot to see the synthetic data
  
  plot <- ggplot()+
    geom_line(data=syn, aes(x=syn$ka, y=syn$events))+
    scale_x_reverse(limits = c(180, 0),breaks = scales::pretty_breaks(n = 18)) +
    ggtitle("Synthetic data") +
    theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
          panel.background = element_blank(), axis.line = element_line(colour = "black"))+
    labs(y = "Events",
         x = "Ka")
  
  plot
  
  return(syn)
  
}


# save as csv