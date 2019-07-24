# synthetic_svz
Synthetic data simulation for the svz study

Please download the RMD file:
https://github.com/yeshancqcq/synthetic_svz/blob/master/synthetic%20dataset/synthetic.rmd
And open it in your RStudio to run simulations.

In this RMD file, you can run Monte Carlo Simulations to simulate the preservation of volcanic signals over time based on your own inputs.

Options include:
1. Type of the fitting methods between current and 180 ka which determines the probability of keeping/dropping a volcanic signal. Currently, 3 methods are availabe: linear, inverse proportional and natural log.
2. The terminal probability of keeping a record at 180 ka. You can change it between 0 and 1.
3. Number of runs in the Monte Carlo Simulation.
4. Mean number of volcanic events per 1000 years during glacial periods (background noise of the data).
5. Mean number of volcanic events per 1000 years during deglaciation periods (peaks)

Please install stringdist and ggplot2 before running it.
