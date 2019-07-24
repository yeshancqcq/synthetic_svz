mc_syn <- function(type, p, run, background, peak){
  
  require(stringdist)
  
  #df <- syn
  #p <- 0.1
  #run <- 100
  
  
  bg <- background
  pk <- peak
  #type <-"linear"
  
  # Initiating the output data frame
  output <- data.frame(ka = c(1:180))
  
  if(type %in% "linear"){
    
    for(mc in 1:run){
      # generate a new synthetic dataset
      df <- synthetic_gen(bg, pk)
      
      # calculate the number of events preserved in each time period
      output$nextrun <- NA
      df$prob <- NA
      
      # In the linear case, the fitting curve y = kx + b passes through (0,1) and (180, p)
      # Therefore:
      # b = 1 and 180k + 1 = p
      # solve: k = (p-1)/180
      # And the curve is: y = (p-1) * x / 180 + 1 where y is the prob and x is ka
      # And the number of preserved events is y * df$events[i]
      
      for (i in 1:nrow(output)){
        df$prob[i] <- (p-1) * df$ka[i] / 180 + 1
        output$nextrun[i] <- ((p-1) * output$ka[i] / 180 + 1) * df$events[i]
      }

      
      # set the column name
      names(output)[mc+1] <- paste("Simu",toString(mc), sep = " ", collapse = NULL)

    }
    # plot
    maint <- paste("Synthetic data simulation for", toString(run), "times. Fitting type:", type)
    subt <- paste("Assuming that", toString(p*100), "% of data are preserved at 180 ka. Background:", toString(bg), "events/ka; Peak:", toString(pk), "events/ka")
    last <- run + 1
    plot <- ggplot()
    for(i in 2:last){
      gg.data <- data.frame(Time=output[,1], Events=output[,i])
      plot<- plot+
        geom_line(data=gg.data, aes(x=Time, y=Events),size = 0.5, colour="#A67C94", alpha = 0.05) 
    }
    
    plot <- plot + scale_x_reverse(limits = c(180, 0.1),breaks = scales::pretty_breaks(n = 9)) +
      ggtitle(maint, subt) +
      theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
            panel.background = element_blank(), axis.line = element_line(colour = "black"))+
      scale_y_continuous(name = expression("Number of Volcanic Events per 1000 Years"), limits = c(0, 35))+
      labs(y = "Counts",
           x = "Time (Years BP)",
           colour = "Parameter")
    print(plot)
    
    # return data
    return(output)
    
  } else if (type %in% "inverse"){
    for(mc in 1:run){
      # generate a new synthetic dataset
      df <- synthetic_gen(bg, pk)
      
      # calculate the number of events preserved in each time period
      output$nextrun <- NA
      df$prob <- NA
      
      # In the linear case, the fitting curve y = k/(x + b) passes through (0,1) and (180, p)
      # Therefore:
      # b = -k and k/(180 + k) = p
      # solve: k = 180*p/(1 - p)
      # And the curve is: y = (180 * p / (1 - p))/ (x + (180 * p / (1 - p)))
      # where y is the prob and x is ka
      # And the number of preserved events is y * df$events[i]
      
      for (i in 1:nrow(output)){
        df$prob[i] <- (180 * p / (1 - p))/ (df$ka[i] + (180 * p / (1 - p)))
        output$nextrun[i] <- df$prob[i] * df$events[i]
      }
      
      
      # set the column name
      names(output)[mc+1] <- paste("Simu",toString(mc), sep = " ", collapse = NULL)
      
    }
    # plot
    maint <- paste("Synthetic data simulation for", toString(run), "times. Fitting type:", type, "proportional")
    subt <- paste("Assuming that", toString(p*100), "% of data are preserved at 180 ka. Background:", toString(bg), "events/ka; Peak:", toString(pk), "events/ka")
    last <- run + 1
    plot <- ggplot()
    for(i in 2:last){
      gg.data <- data.frame(Time=output[,1], Events=output[,i])
      plot<- plot+
        geom_line(data=gg.data, aes(x=Time, y=Events),size = 0.5, colour="#A67C94", alpha = 0.05) 
    }
    
    plot <- plot + scale_x_reverse(limits = c(180, 0.1),breaks = scales::pretty_breaks(n = 9)) +
      ggtitle(maint, subt) +
      theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
            panel.background = element_blank(), axis.line = element_line(colour = "black"))+
      scale_y_continuous(name = expression("Number of Volcanic Events per 1000 Years"), limits = c(0, 35))+
      labs(y = "Counts",
           x = "Time (Years BP)",
           colour = "Parameter")
    print(plot)
    
    # return data
    return(output)

  } else if (type %in% "log"){
    
    # for convenience in natural log calculation, we use probability of DROPPING instead of KEEPING
    # so we need to initiating a new var called p1
    
    p1 <- 1 - p
    
    for(mc in 1:run){
      # generate a new synthetic dataset
      df <- synthetic_gen(bg, pk)
      
      # calculate the number of events preserved in each time period
      output$nextrun <- NA
      df$prob <- NA
      
      # In the natural log case, the fitting curve y = ln(x+b)/k passes through (0,1) and (180, p1)
      # detailed calculation could be found on the github folder named naturalLog.png
      # And the curve is: y = ln(x+1)/(5.198/p1)
      # And the number of preserved events is (1-y) * df$events[i]
      
      for (i in 1:nrow(output)){
        df$prob[i] <- 1- (log(df$ka[i] + 1) / (5.198 / p1))
        output$nextrun[i] <- df$prob[i] * df$events[i]
      }
      
      
      # set the column name
      names(output)[mc+1] <- paste("Simu",toString(mc), sep = " ", collapse = NULL)
      
    }
    # plot
    maint <- paste("Synthetic data simulation for", toString(run), "times. Fitting type: natural", type)
    subt <- paste("Assuming that", toString(p*100), "% of data are preserved at 180 ka. Background:", toString(bg), "events/ka; Peak:", toString(pk), "events/ka")
    last <- run + 1
    plot <- ggplot()
    for(i in 2:last){
      gg.data <- data.frame(Time=output[,1], Events=output[,i])
      plot<- plot+
        geom_line(data=gg.data, aes(x=Time, y=Events),size = 0.5, colour="#A67C94", alpha = 0.05) 
    }
    
    plot <- plot + scale_x_reverse(limits = c(180, 0.1),breaks = scales::pretty_breaks(n = 9)) +
      ggtitle(maint, subt) +
      theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
            panel.background = element_blank(), axis.line = element_line(colour = "black"))+
      scale_y_continuous(name = expression("Number of Volcanic Events per 1000 Years"), limits = c(0, 35))+
      labs(y = "Counts",
           x = "Time (Years BP)",
           colour = "Parameter")
    print(plot)
    
    # return data
    return(output)
    
  } else {
    error <- "Fitting curve options: linear, log or inverse"
    print(error)
    return(NA)
  }
  
  
}