# Docker container for generating Growth-rate inhibition (GR) values and fitted curve metrics in RStudio

This docker container contains scripts for cancer cell line drug-response assays. The scripts average cell count data over technical
replicates (estimated by intra-cellular ATP levels measured by a CellTiter-Glo® assay) and fit the data to 3-parameter logistic dose-response curves using the growth-rate inhibition (GR) method
of [Hafner et al. 2016](http://lincs.hms.harvard.edu/hafner-natmethods-2016/).

See [here](http://www.grcalculator.org/grtutorial/?tab=AboutGR) for more details on the GR methodology and GR metrics.

The parameters that define the dose-response curves are given as well as other calculated
dose-response metrics (e.g. GR<sub>50</sub>, GR<sub>AOC</sub>). The docker uses the "Breast Cancer Density" data
generated at the Harvard Medical School HMS LINCS Center as an example.

These data start with cell counts from
individual wells [(Level 2)](http://lincsportal.ccs.miami.edu/datasets-beta/#/view/LDS-1261). The first script `Level2_to_Level3.R` averages these counts
over technical replicates and gives a data frame equivalent to the [Level 3 data](http://lincsportal.ccs.miami.edu/datasets-beta/#/view/LDS-1262). The second script `Level3_to_Level4.R` calculates GR values (analogous to relative cell counts) for the averaged cell counts and fits the data to dose-response curves, giving a data frame of GR values and a data frame of fitted curve metrics equivalent to the [Level 4 data](http://lincsportal.ccs.miami.edu/datasets-beta/#/view/LDS-1263). Traditional metrics based on relative cell counts, such as IC<sub>50</sub> and E<sub>max</sub>, are calculated as well and reported for comparison.

---
### Installation of Docker

Ubuntu: follow [`the instructions`](https://docs.docker.com/engine/installation/linux/docker-ce/ubuntu/) to get Docker CE for Ubuntu.

Mac: follow [`the instructions`](https://store.docker.com/editions/community/docker-ce-desktop-mac) to install [`the Stable verion of Docker CE`](https://download.docker.com/mac/stable/Docker.dmg) on Mac.

Windows: follow [`the instructions`](https://docs.docker.com/toolbox/toolbox_install_windows/) to install [`Docker Tookbox`](https://download.docker.com/win/stable/DockerToolbox.exe) on Windows.

---
### Download and run the docker container
To obtain the docker image and run the container,
```
[sudo] docker pull nickclark/hms-docker-test:stable
```
To run the container execute the following command:

```
[sudo] docker run -d -p <available port>:8787 nickclark/hms-docker-test:stable
```
Typically one can use port 8787 if not already used by another application. In that case the command is

```
[sudo] docker run -d -p 8787:8787 nickclark/hms-docker-test:stable
```
First make sure that port 8787 is free to use for the Rstudio, (Typically Rstudio dockers run on this port, if this port is free ignore the rest of this section). You can stop and kill any other docker containers on this port by

```
[sudo] docker stop <container ID> && docker rm <container ID>
```
To find the container ID, run this command:
```
[sudo] docker ps -a
```
---
To start an RStudio session, open a browser and type in the address bar ``<Host URL>:<available port as specified>``. Enter `rstudio` for both username and password. For example `http://localhost:8787` on Mac or Linux systems when 8787 port is used.

Host URL on Ubuntu and Mac is `localhost`, if accessed locally. On Windows, the IP is shown when Docker is launched by double-clicking the Docker Quickstart Terminal icon on desktop, or it can be obtained from the output of `docker ls` in the interactive shell window.

---
### Execute the processing pipeline

After entering the RStudio environment, type the following command in the console:

```
source("Level2_to_Level3.R")
```
You can also open the R code by clicking the file named `Level2_to_Level3.R` from the files panel in the bottom-right of your window.
Once you see the code appears in the top-left window, you can click `Source` at the top of the window.

This script will average the cell count data over technical replicates, converting it from [Level 2](http://lincsportal.ccs.miami.edu/datasets-beta/#/view/LDS-1261) data to [Level 3](http://lincsportal.ccs.miami.edu/datasets-beta/#/view/LDS-1262) data.

You can then fit (GR) dose-response curves to the averaged cell counts and calculate curve metrics, giving [Level 4](ttp://lincsportal.ccs.miami.edu/datasets-beta/#/view/LDS-1263) data. Simply run the command below or click the file named `Level3_to_Level4.R` and click `Source`.

```
source("Level3_to_Level4.R")
```
### Note

The output from this script differs from the published GR metrics. The published data was calculated using analogous [MATLAB scripts](https://github.com/datarail/gr_metrics/tree/master/SRC/MATLAB) and published over a year and a half ago. Since then, there have been updates to the scripts in both MATLAB and R.

---
