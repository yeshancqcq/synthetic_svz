# synthetic_svz
Synthetic data simulation for the SVZ volcano-glacier interaction study

Emily Mixon & Shan Ye

Please download the RMD file:
https://github.com/yeshancqcq/synthetic_svz/blob/master/synthetic%20dataset/synthetic.rmd 
or
https://github.com/yeshancqcq/synthetic_svz/blob/master/synthetic%20dataset/synthetic_sp.rmd (for separated Ar and 14C real world data)

And open it in your RStudio to run simulations.

In this RMD file, you can run Monte Carlo Simulations to simulate the preservation of volcanic signals over time based on your own inputs.

Options include:
1. Type of the fitting methods between current and 180 ka which determines the probability of keeping/dropping a volcanic signal. Currently, 3 methods are availabe: linear, inverse proportional and natural log.
2. The terminal probability of keeping a record at 180 ka. You can change it between 0 and 1.
3. Number of runs in the Monte Carlo Simulation.
4. Mean number of volcanic events per 1000 years during glacial periods (background noise of the data).
5. The standard deviation that defines the normal distribution of number of events at each time period to generate the uncertanty of the background noise.
6. Mean number of volcanic events per 1000 years during deglaciation periods (peaks)
7. The standard deviation that defines the normal distribution of number of events at each time period to generate the uncertanty of the signals.
8. Uncertainty of the argon dating.
9. Manually define deglaciation periods (Recommended: 123 - 127 ka and 14 - 18 ka)
10. Whether to add the secondary signal following major signals (as observed in real-world data)
11. The gap between major signals and corresponding secondary signals (recommended: 5 ka).
12. Whether to plot real world data from SVZ and Cascades along with the generated data.

Please install stringdist and ggplot2 before running it.

Real world data are saved in the realData folder. If you want to use this function, you need to download data in this folder a d save them in a folder with the same name (realData) on your local machine. Then, in the line of setwd in the last block of the rmd file, change the directory to one level above this folder. 
