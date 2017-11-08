# Docker container for generating Growth-rate inhibition (GR) values and fitted curve metrics in RStudio

This docker container provides a platform for processing and analyzing cancer cell line drug-response assays generated by the HMS LINCS Data and Signatures Generation Center. The platform is provided in the form of an RStudio implementation. We also provide an R script that demonstrates the use of the plaform in processing one of the cell count datasets released through the Lincs Data Portal. The processing starts with Level 2 data and ultimately produces Level 4 data.

The script averages cell count data over technical replicates (estimated by intra-cellular ATP levels measured by a CellTiter-Glo® assay) and fits the data to 3-parameter logistic dose-response curves using the growth-rate inhibition (GR) method
of [Hafner et al. 2016](http://lincs.hms.harvard.edu/hafner-natmethods-2016/).

See [here](http://www.grcalculator.org/grtutorial/?tab=AboutGR) for more details on the GR methodology and GR metrics.

The parameters that define the dose-response curves are given as well as other calculated
dose-response metrics (e.g. GR50, GR_AOC). The docker uses the "Breast Cancer Density" data
generated at the Harvard Medical School HMS LINCS Center as an example.

These data start with cell counts from
individual wells [(Level 2)](http://lincsportal.ccs.miami.edu/datasets-beta/#/view/LDS-1261). The script `Level2_to_Level3_and4.R` averages these counts
over technical replicates and gives a data frame equivalent to the [Level 3 data](http://lincsportal.ccs.miami.edu/datasets-beta/#/view/LDS-1262). It then calculates GR values (analogous to relative cell counts) for the averaged cell counts and fits the data to dose-response curves, giving a data frame of GR values and a data frame of fitted curve metrics equivalent to the [Level 4 data](http://lincsportal.ccs.miami.edu/datasets-beta/#/view/LDS-1263). Traditional metrics based on relative cell counts, such as IC50 and Emax, are calculated as well and reported for comparison.

---
### Installation of Docker

Ubuntu: follow [`the instructions`](https://docs.docker.com/engine/installation/linux/docker-ce/ubuntu/) to get Docker CE for Ubuntu.

Mac: follow [`the instructions`](https://store.docker.com/editions/community/docker-ce-desktop-mac) to install [`the Stable verion of Docker CE`](https://download.docker.com/mac/stable/Docker.dmg) on Mac.

Windows: follow [`the instructions`](https://docs.docker.com/toolbox/toolbox_install_windows/) to install [`Docker Tookbox`](https://download.docker.com/win/stable/DockerToolbox.exe) on Windows.

---
### Download and run the docker container

**Note: You may need to add *sudo* before the following commands on Linux or Mac**

To obtain the docker image and run the container,
```
docker pull ucbd2k/hms-cellcount:stable
```
To run the container, execute the following command:

```
docker run -d -p 8787:8787 ucbd2k/hms-cellcount:stable
```
---
If port 8787 is not available, you may need to try another port, for example `docker run -d -p 7777:8787 ucbd2k/hms-cellcount:stable`.

To start an RStudio session, open a web browser and type `http://localhost:8787` in the address bar. Enter `rstudio` for both username and password.

**Note: If `localhost` does not work (for example if you are using *Docker Toolbox* for older Mac or Windows systems), use the docker host ip address instead of `localhost`.** Determine the docker host ip with the `docker-machine ip default` command and substitute this ip address for `localhost`. 

---
### Execute the processing pipeline

After entering the RStudio environment, type the following command in the console:

```
source("Level2_to_Level3_and4.R")
```
You can also open the R code by clicking the file named `Level2_to_Level3_and4.R` from the files panel in the bottom-right of your window.
Once you see the code appears in the top-left window, you can click `Source` at the top of the window.

This script will average the cell count data over technical replicates, converting it from [Level 2](http://lincsportal.ccs.miami.edu/datasets-beta/#/view/LDS-1261) data to [Level 3](http://lincsportal.ccs.miami.edu/datasets-beta/#/view/LDS-1262) data. It will then fit (GR) dose-response curves to the averaged cell counts and calculate curve metrics, giving [Level 4](ttp://lincsportal.ccs.miami.edu/datasets-beta/#/view/LDS-1263) data. When it is done, the script will show the Level 3 data (averaged cell counts) and Level 4 data (GR values and fitted curve metrics).

### Note

The output from this script differs slightly from the released GR metrics data due to some minor modifications in the processing pipeline since the data release.

---
