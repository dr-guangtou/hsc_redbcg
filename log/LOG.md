# redMapper BCGs in HSC Survey

----

## Sample:

    ``` python
    loc = '~/Dropbox/work/hsc/redmapper/1509/'
    catCHsc = '../1509/hsc_redmapper_cluster_1509.fits'
    catMHsc = '../1509/hsc_redmapper_member_1509.fits'
    ```

----

## Organize the IPython notebook:
    * Organize the available IPython notebook, put under `notebook` folder
        - `redMapperRaDec.ipynb`: Make RA, DEC plot of redMapper clusters
        - `convolveMask.ipynb`: Test segmentation in SEP and convolve mask
        - `hscFilterRedshift.ipynb`: Redshift v.s. effective wavelength of HSC filters.
        - `speczFrac.ipynb`: Redshift completeness of SDSS+GAMA survey
            * Input: `hsc_gama_galaxies2.fits`
        - `wideMatch.ipynb`: Filter the input catalog using a Accept and Rejection mask
            * Input: acpMask and rejMask in `.wkb` format
            * Input: Any SDSS or GAMA fits catalog
        - `frameSearch.ipynb`: Find the single frames that overlap with a region
            * Input: HSC single frame catalog from the database
                    - `..gama_compare/database_dr15a/hsc_dr15a_wide_frame.fits`
        - `coaddSrcCat.ipynb`: Given cutout images, visualize the cModel results.
            * Now you can do this using `coaddShowCModel.py` to do this.
        - `gamaMag2Flux.ipynb`: Convert between HSC flux and magnitude, can use `maggies` as unit
            * Also correct galactic extinction.
            * Input: `gama_compare/hsc_gama_dr15a_matched.fits`
            * Output: `gama_compare/hsc_gama_dr15a_matched_short.fits`
            * Output: `gama_compare/hsc_gama_dr15a_matched_flux_use.fits`
        - `gamaCompare.ipynb`: Compare the RA, DEC distributions, and photometry between SDSS/GAMA and HSC photometry:
            * Inputs:
              ``` python
              g09_wkb = 'ssp385_wide_g09_tract_all.wkb'
              g09_hsc = 'hsc_gama_g09_hsc_match.fits'
              g09_match = 'hsc_gama_dr15a_g09_matched.fits'
              g09_not_match = 'hsc_gama_dr15a_g09_not_matched.fits'
              g09_red = 'redmapper/hsc_redmapper_g09.fits'

              g15_wkb = 'ssp385_wide_g15_tract_all.wkb'
              g15_hsc = 'hsc_gama_g15_hsc_match.fits'
              g15_match = 'hsc_gama_dr15a_g15_matched.fits'
              g15_not_match = 'hsc_gama_dr15a_g15_not_matched.fits'
              g15_red = 'redmapper/hsc_redmapper_g15.fits'

              w12_wkb = 'ssp385_wide_w12_tract_all.wkb'
              w12_hsc = 'hsc_gama_w12_hsc_match.fits'
              w12_match = 'hsc_gama_dr15a_w12_matched.fits'
              w12_not_match = 'hsc_gama_dr15a_w12_not_matched.fits'
              w12_red = 'redmapper/hsc_redmapper_w12.fits'

              gama_match = 'hsc_gama_dr15a_matched.fits'
              gama_nomatch = 'hsc_gama_dr15a_not_matched.fits'
              ```
        - `gamaSEDMass.ipynb`: Summarize the HSC iSEDFit stellar mass results
            * Inputs:
              ``` python
              sed_model = 'a_fsps_miles_chab'
              #sed_model = 'b_bc03_stelib_chab'

              z1Fits = 'sed/hsc_sed_z1' + sed_model + '_match.fits'
              z2Fits = 'sed/hsc_sed_z2' + sed_model + '_match.fits'
              z3Fits = 'sed/hsc_sed_z3' + sed_model + '_match.fits'
              ```
            * Including:
                1. The reshift-mass distributions;
                2. Mass comparisons between HSC, SDSS, and GAMA
                3. Stellar mass distributions
                4. Stellar mass "functions"
        - `xmm_massive.ipynb`:
            * The notebook that summarize the results before the 2015-08
              Princeton collaboration meeting.


## 2015-12-05

    * `redMapperRaDec.ipynb`:
        - Update the RA, DEC plots
        - Estimate the:
            1. Magnitude gap between BCG and second brightest galaxy (`bcgGap`)
            2. BCG Dominance: Magnitude difference between the BCG and the mean magnitude of the 2nd to 6th brightest galaxies (`bcgDom`)
            3. BCG's luminosity fraction compared to the sum of the 2nd to 6th brightest galaxies (`bcgFrac5`)
            4. BCG's luminosity fraction compared to all the identified members (except the BCG) (`bcgFracA`)
            * **NOTE**: In all 5 bands, there are non-BCG galaxies with `P_CEN_1`
    * `hscFilterRedshift.ipynb`: Update the redshift-filter plot.


## 2015-12-06

* Improve `batchPrep.py`; `batchSky.py`; `batchSbp.py`

* Allow `coaddCutoutSky.py`, `coaddCutoutSbp.py`, and their batch-mode scripts to allow external masks

* Start with `ds9Reg2Mask.py`

* Organize `coaddCutoutPrep.py`
    - Clean up
    - Add segmentation map
    - Accept external region files

* Fix the direction of the image by add `origin='lower'`

## 2015-12-07

* Keep improving all useful python code
* Better `coaddCutoutPrep.py`

* Start to work on improving the SBP part
* Make `batchForceSbp.py` ready
* Gradually clean up and beautify the codes

* Started to run batch mode on Master, met two problems

### Cutout preparation on Master:

#### redMapper:

* Under: `/data3a/work/song/redmapper`
  - **6** input catalogs: `hsc_redmapper_cluster_z[1-4]_1509.fits`
  - Have all **5** bands data

* I-band preparation:

``` bash
## default rerun
batchPrep.py redBCG hsc_redmapper_cluster_z${PBS_ARRAYID}_1509.fits \
    -i 'ID_CLUSTER' -r default
## smallR1 rerun
batchPrep.py redBCG hsc_redmapper_cluster_z${PBS_ARRAYID}_1509.fits \
    -i 'ID_CLUSTER' -r smallR1
## largeR1 rerun
batchPrep.py redBCG hsc_redmapper_cluster_z${PBS_ARRAYID}_1509.fits \
    -i 'ID_CLUSTER' -r largeR1
```

* I-band sky estimate:

``` bash
## default rerun
batchSky.py redBCG hsc_redmapper_cluster_z${PBS_ARRAYID}_1509.fits \
    -i 'ID_CLUSTER' -f HSC-I -r default
## smallR1 rerun
batchSky.py redBCG hsc_redmapper_cluster_z${PBS_ARRAYID}_1509.fits \
    -i 'ID_CLUSTER' -f HSC-I -r smallR1
## largeR1 rerun
batchSky.py redBCG hsc_redmapper_cluster_z${PBS_ARRAYID}_1509.fits \
    -i 'ID_CLUSTER' -f HSC-I -r largeR1
```

* Sky estimates for other bands
  - Use `HSC-G` as example:

``` bash
## default rerun
batchSky.py redBCG hsc_redmapper_cluster_z${PBS_ARRAYID}_1509.fits \
    -i 'ID_CLUSTER' -f HSC-G -mf HSC-I -r default
## smallR1 rerun
batchSky.py redBCG hsc_redmapper_cluster_z${PBS_ARRAYID}_1509.fits \
    -i 'ID_CLUSTER' -f HSC-G -mf HSC-I -r smallR1
## largeR1 rerun
batchSky.py redBCG hsc_redmapper_cluster_z${PBS_ARRAYID}_1509.fits \
    -i 'ID_CLUSTER' -f HSC-G -mf HSC-I -r largeR1
```

#### nonBCG massive galaxies:

* Under: `/data3a/work/song/nonbcg`
  - **4** input catalogs: `massive_nonBCG_test_[1-4].fits`
  - Have **4** bands data: **HSC-G/R/I/Z**

* I-band preparation:
  - Only generate `default` and `largeR1` reruns now

``` bash
## default rerun
batchPrep.py nonBCG massive_nonBCG_test_${PBS_ARRAYID}.fits -i 'ISEDFIT_ID' \
    -r default -r HSC-I
## largeR1 rerun
batchPrep.py nonBCG massive_nonBCG_test_${PBS_ARRAYID}.fits -i 'ISEDFIT_ID' \
    -r largeR1 -r HSC-I
```

* I-band sky estimates

``` bash
## default rerun
batchSky.py nonBCG massive_nonBCG_test_${PBS_ARRAYID}.fits -i 'ISEDFIT_ID' \
    -r default -f HSC-I
## default rerun
batchSky.py nonBCG massive_nonBCG_test_${PBS_ARRAYID}.fits -i 'ISEDFIT_ID' \
    -r largeR1 -f HSC-I
```

* **TODO**: I-band smallR1 rerun, and sky for other bands will be generated later


## 2015-12-08

* Problems on Master:
  1. The Torque will not give a node "ulimit -l unlimited", Pyraf will fail.
  2. There are serious memory issues with the code:
      - Try to use `gc.collect()` improve, but did not work well
      - The main problem is to close the figure after saving them using `plt.save(fig)`; and `del` some large image arrays after uisng them.  
      - **TODO**: Will go back to check other codes.  
  3. Further improve the SBP part of the code.  
      - **TODO**: Under batch mode, the code should not `raise Exception()` inside the loop; Should keep logging all the situations.  **Better Logging**


* Rsync backup:
  1. `redmapper` and `nonbcg` to W520:`/home/hs/astro2/hsc/master/` [DONE]
  2. `redmapper` and `nonbcg` to MBP:`/Users/songhuang/astro3/hscs/` [DONE]


### redMapper:

* I-band SBP (default)
    - Manually handled, generated separately;
    - Logs can be found: `hsc_redmapper_cluster_z[1-6]_1509_default_sbp.log`
        - **NOTE**: When produced, the `batchSbp.py` did not correctly log the `CEN_MASK` ones as failed.  This has been fix; And the `CEN_MASK` cases can be found in the log files for `batchForceSbp.py`

``` bash
## default rerun
batchSbp.py redBCG hsc_redmapper_cluster_z[1/2/3/4/5/6]_1509.fits \
    -i 'ID_CLUSTER' -r default -f HSC-I --plmask --step 0.1
```

#### Failed ones:

* 24 failed cases:

```
WARNING:root:### Can not find INPUT BINARY for : redBCG_33_HSC-R_full
WARNING:root:### Can not find INPUT BINARY for : redBCG_1846_HSC-R_full
WARNING:root:### Can not find INPUT BINARY for : redBCG_5197_HSC-R_full
WARNING:root:### Can not find INPUT BINARY for : redBCG_6497_HSC-R_full
WARNING:root:### Can not find INPUT BINARY for : redBCG_7572_HSC-R_full
WARNING:root:### Can not find INPUT BINARY for : redBCG_8441_HSC-R_full
WARNING:root:### Can not find INPUT BINARY for : redBCG_9724_HSC-R_full
WARNING:root:### Can not find INPUT BINARY for : redBCG_10793_HSC-R_full
WARNING:root:### Can not find INPUT BINARY for : redBCG_11330_HSC-R_full
WARNING:root:### Can not find INPUT BINARY for : redBCG_15726_HSC-R_full
WARNING:root:### Can not find INPUT BINARY for : redBCG_15947_HSC-R_full
WARNING:root:### Can not find INPUT BINARY for : redBCG_16054_HSC-R_full
WARNING:root:### Can not find INPUT BINARY for : redBCG_16643_HSC-R_full
WARNING:root:### Can not find INPUT BINARY for : redBCG_21087_HSC-R_full
WARNING:root:### Can not find INPUT BINARY for : redBCG_21677_HSC-R_full
WARNING:root:### Can not find INPUT BINARY for : redBCG_22120_HSC-R_full
WARNING:root:### Can not find INPUT BINARY for : redBCG_23868_HSC-R_full
WARNING:root:### Can not find INPUT BINARY for : redBCG_24930_HSC-R_full
WARNING:root:### Can not find INPUT BINARY for : redBCG_25765_HSC-R_full
WARNING:root:### Can not find INPUT BINARY for : redBCG_28129_HSC-R_full
WARNING:root:### Can not find INPUT BINARY for : redBCG_29826_HSC-R_full
WARNING:root:### Can not find INPUT BINARY for : redBCG_36194_HSC-R_full
WARNING:root:### Can not find INPUT BINARY for : redBCG_48732_HSC-R_full
WARNING:root:### Can not find INPUT BINARY for : redBCG_73887_HSC-R_full
```


* I-band Force SBP
    - Should be much faster, so use the master catalog

``` bash
## largeR1 rerun
batchForceSbp.py redBCG hsc_redmapper_cluster_1509.fits HSC-I \
    -i 'ID_CLUSTER' -r largeR1 --plmask \
    -mf HSC-I -rf HSC-I -rr default -rm 3
## smallR1 rerun
batchForceSbp.py redBCG hsc_redmapper_cluster_1509.fits HSC-I \
    -i 'ID_CLUSTER' -r smallR1 --plmask \
    -mf HSC-I -rf HSC-I -rr default -rm 3
```

* Force SBP for other bands
    - Should be much faster, so use the master catalog
    - Only use `HSC-G` as example

``` bash
## default rerun: G, R, Z, Y finished
batchForceSbp.py redBCG hsc_redmapper_cluster_1509.fits HSC-G \
    -i 'ID_CLUSTER' -r default --plmask \
    -mf HSC-I -rf HSC-I -rr default -rm 3
## largeR1 rerun: G, R, Z, Y finished
batchForceSbp.py redBCG hsc_redmapper_cluster_1509.fits HSC-G \
    -i 'ID_CLUSTER' -r largeR1 --plmask \
    -mf HSC-I -rf HSC-I -rr default -rm 3
## smallR1 rerun: G, R, Z, Y finished
batchForceSbp.py redBCG hsc_redmapper_cluster_1509.fits HSC-Y \
    -i 'ID_CLUSTER' -r smallR1 --plmask \
    -mf HSC-I -rf HSC-I -rr default -rm 3
```

### nonBCG Massives:

* I-band SBP (default)
    - Manually handled, generated separately;
    - Logs can be found: `massive_nonBCG_test_[1-4]_default_sbp.log`
    - **On-Going**

``` bash
## default rerun
batchSbp.py nonBCG massive_nonBCG_test_[1-4].fits --id 'ISEDFIT_ID' \
    --plmask --step 0.1 -r default -f HSC-I
```

* I-band Force SBP
    - Should be much faster, so use the master catalog

``` bash
## largeR1 rerun : 1, 2, 3, 4 finished
batchForceSbp.py nonBCG massive_nonBCG_test_1.fits HSC-I \
    -i 'ISEDFIT_ID' -r largeR1 --plmask \
    -mf HSC-I -rf HSC-I -rr default -rm 3
```

* Force SBP for other bands
    - Should be much faster, so use the master catalog
    - Only use `HSC-G` as example

``` bash
## largeR1 rerun :
## G 1, 2, 3, 4 finished;
## R 1, 2, 3, 4 finished;
## Z 1, 2, 3, finished;
batchForceSbp.py nonBCG massive_nonBCG_test_1.fits HSC-G \
    -i 'ISEDFIT_ID' -r default --plmask \
    -mf HSC-I -rf HSC-I -rr default -rm 3
```

### Failed cases:
    * 21 failed ones

``` bash
WARNING:root:### Can not find INPUT BINARY for : nonBCG_5875_HSC-I_full
WARNING:root:### Can not find INPUT BINARY for : nonBCG_5755_HSC-I_full
WARNING:root:### Can not find INPUT BINARY for : nonBCG_4748_HSC-I_full
WARNING:root:### Can not find INPUT BINARY for : nonBCG_5761_HSC-I_full
WARNING:root:### Can not find INPUT BINARY for : nonBCG_5518_HSC-I_full
WARNING:root:### Can not find INPUT BINARY for : nonBCG_4877_HSC-I_full
WARNING:root:### Can not find INPUT BINARY for : nonBCG_5770_HSC-I_full
WARNING:root:### Can not find INPUT BINARY for : nonBCG_5016_HSC-I_full
WARNING:root:### Can not find INPUT BINARY for : nonBCG_4817_HSC-I_full
WARNING:root:### Can not find INPUT BINARY for : nonBCG_5230_HSC-I_full
WARNING:root:### Can not find INPUT BINARY for : nonBCG_5233_HSC-I_full
WARNING:root:### Can not find INPUT BINARY for : nonBCG_5876_HSC-I_full
WARNING:root:### Can not find INPUT BINARY for : nonBCG_5418_HSC-I_full
WARNING:root:### Can not find INPUT BINARY for : nonBCG_5270_HSC-I_full
WARNING:root:### Can not find INPUT BINARY for : nonBCG_5096_HSC-I_full
WARNING:root:### Can not find INPUT BINARY for : nonBCG_5678_HSC-I_full
WARNING:root:### Can not find INPUT BINARY for : nonBCG_5556_HSC-I_full
WARNING:root:### Can not find INPUT BINARY for : nonBCG_5666_HSC-I_full
WARNING:root:### Can not find INPUT BINARY for : nonBCG_4745_HSC-I_full
WARNING:root:### Can not find INPUT BINARY for : nonBCG_4713_HSC-I_full
WARNING:root:### Can not find INPUT BINARY for : nonBCG_5675_HSC-I_full
```

## 2015-12-11

### New GAMA Massive Galaxy Sample

    * Based on `hsc_sed_z2a_fsps_miles_chab_match.fits`: 0.2 < z < 0.4
    * `MSTAR >= 11.2`: **5029** Galaxies.
    * Save the table to `gama_z0.2_0.4_m11.2.fits` under `gama_compare/nonbcg` (11 Mb)

    * There was an old `non-cluster` catalog for `0.1 < z < 0.4` GAMA galaxies.
        - `MSTAR >= 11.2 && Z >= 0.25 && Z <= 0.40` --> **3747** galaxies.
        - Save to `gama_z0.25_0.4_m11.2.fits` under `gama_compare/nonbcg` (7.9 Mb)
        - Backup to `~/hsc_redbcg/data` in Dropbox

    * Write a small scripts to split the table.
        - `fitsSplitTable.py` --> `..../hscUtils/`
    * Split the input `gama_z0.25_0.4_m11.2.fits` into 8 tables, each with ~500 galaxies.
        - Upload them to Master.

    * Clean up `coaddBatchCutout.py`, `coaddImageCutout.py`, `batchCut.py`;
    * Clean up `coaddColorImage.py`, `batchColor.py`, `hscUtils.py`

## 2015-12-12

### Start to generate cutout for `gama1` sample

    * Under `/lustre/Subaru/SSP/rerun/song/gama/`
    * `nonbcg_151212_1.submit` --> gama_cut_HSC-I
    * `nonbcg_151212_2.submit` --> gama_cut_HSC-G


## 2015-12-15

### GAMA01 sample:

* The sample is cut and prepared as usual;
* Instead of generating 3 separated reruns; we generate 2 additional masks in `HSC-I/default` rerun.
* Sky backgrounds are also estimated in the usual way.

#### 1-D Surface Brightness Profile:

    ```
    # Finished
    batchSbp.py gama gama_z0.25_0.4_m11.2_nonbcg_1.fits -i 'ISEDFIT_ID' -r default -f HSC-I --plmask --multiEllipse
    batchSbp.py gama gama_z0.25_0.4_m11.2_nonbcg_2.fits -i 'ISEDFIT_ID' -r default -f HSC-I --plmask --multiEllipse
    batchSbp.py gama gama_z0.25_0.4_m11.2_nonbcg_3.fits -i 'ISEDFIT_ID' -r default -f HSC-I --plmask --multiEllipse
    batchSbp.py gama gama_z0.25_0.4_m11.2_nonbcg_4.fits -i 'ISEDFIT_ID' -r default -f HSC-I --plmask --multiEllipse
    batchSbp.py gama gama_z0.25_0.4_m11.2_nonbcg_5.fits -i 'ISEDFIT_ID' -r default -f HSC-I --plmask --multiEllipse
    batchSbp.py gama gama_z0.25_0.4_m11.2_nonbcg_6.fits -i 'ISEDFIT_ID' -r default -f HSC-I --plmask --multiEllipse
    batchSbp.py gama gama_z0.25_0.4_m11.2_nonbcg_7.fits -i 'ISEDFIT_ID' -r default -f HSC-I --plmask --multiEllipse
    batchSbp.py gama gama_z0.25_0.4_m11.2_nonbcg_8.fits -i 'ISEDFIT_ID' -r default -f HSC-I --plmask --multiEllipse
    ```

    * **3583** galaxies with useful profiles.

#### 1-D Force Photometry:

* Update `batchForceSbp.py` with forced runs using `msksmall.fits` and `msklarge.fits`

    - HSC-G:
    ```
    # Running
    batchForceSbp.py gama gama_z0.25_0.4_m11.2_nonbcg_1.fits HSC-G -i 'ISEDFIT_ID' \
        -r default -mf HSC-I -rf HSC-I -rr default -rm 3 --multiMask --plmask
    batchForceSbp.py gama gama_z0.25_0.4_m11.2_nonbcg_2.fits HSC-G -i 'ISEDFIT_ID' \
        -r default -mf HSC-I -rf HSC-I -rr default -rm 3 --multiMask --plmask
    batchForceSbp.py gama gama_z0.25_0.4_m11.2_nonbcg_3.fits HSC-G -i 'ISEDFIT_ID' \
        -r default -mf HSC-I -rf HSC-I -rr default -rm 3 --multiMask --plmask
    batchForceSbp.py gama gama_z0.25_0.4_m11.2_nonbcg_4.fits HSC-G -i 'ISEDFIT_ID' \
        -r default -mf HSC-I -rf HSC-I -rr default -rm 3 --multiMask --plmask
    batchForceSbp.py gama gama_z0.25_0.4_m11.2_nonbcg_5.fits HSC-G -i 'ISEDFIT_ID' \
        -r default -mf HSC-I -rf HSC-I -rr default -rm 3 --multiMask --plmask
    batchForceSbp.py gama gama_z0.25_0.4_m11.2_nonbcg_6.fits HSC-G -i 'ISEDFIT_ID' \
        -r default -mf HSC-I -rf HSC-I -rr default -rm 3 --multiMask --plmask
    batchForceSbp.py gama gama_z0.25_0.4_m11.2_nonbcg_7.fits HSC-G -i 'ISEDFIT_ID' \
        -r default -mf HSC-I -rf HSC-I -rr default -rm 3 --multiMask --plmask
    batchForceSbp.py gama gama_z0.25_0.4_m11.2_nonbcg_8.fits HSC-G -i 'ISEDFIT_ID' \
        -r default -mf HSC-I -rf HSC-I -rr default -rm 3 --multiMask --plmask
    ```

    - HSC-R:

### GAMA2 Sample:

    * There was an old `non-cluster` catalog for `0.1 < z < 0.4` GAMA galaxies.
        - `MSTAR >= 11.2 && Z >= 0.1 && Z <= 0.25` --> **1700** galaxies.
        - Save to `gama_z0.10_0.25_m11.2.fits` under `gama_compare/nonbcg` (3.6 Mb)
        - Backup to `~/hsc_redbcg/data` in Dropbox

    * Upload the sample to Master, under `/data3a/work/song/gama2`:
        - New screen: `gama2`

    * Start to generate cutouts:
        - `HSC-I`: `nonbcg_151215_1.submit`
        - `HSC-G`: `nonbcg_151215_2.submit`
        - `HSC-R`: `nonbcg_151215_3.submit`



-----

### Issues:

* The corrected SBP and CoG is still need to be tested
* Sometime `zscale` resacaling can fail, leave a black image on the output figure. (e.g. redBCG_15251)
* The PA correction is still not perfect (e.g. redBCG_1053)
