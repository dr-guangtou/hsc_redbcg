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

#### Generating cutout images:
    * `nonbcg_151212_1.submit` --> `gama_cut_HSC-I`
    * `nonbcg_151212_2.submit` --> `gama_cut_HSC-G`
    * `nonbcg_151212_3.submit` --> `gama_cut_HSC-R`

#### Prepare the cutouts:
    * Now only generating 1-rerun, but with 3 different masks
    * `nonbcg_151213_1.submit` --> `gama_prep_HSC-I`
    * `nonbcg_151213_2.submit` --> `gama_prep_HSC-G`
    * `nonbcg_151213_3.submit` --> `gama_prep_HSC-R`

#### Estimate sky background:
    * `nonbcg_151214_1.submit` --> `gama_sky_HSC-I`
    * `nonbcg_151214_2.submit` --> `gama_sky_HSC-G`
    * `nonbcg_151214_3.submit` --> `gama_sky_HSC-R`


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
    # Finished
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
    ```
    # Finished
    batchForceSbp.py gama gama_z0.25_0.4_m11.2_nonbcg_1.fits HSC-R -i 'ISEDFIT_ID' \
        -r default -mf HSC-I -rf HSC-I -rr default -rm 3 --multiMask --plmask
    batchForceSbp.py gama gama_z0.25_0.4_m11.2_nonbcg_2.fits HSC-R -i 'ISEDFIT_ID' \
        -r default -mf HSC-I -rf HSC-I -rr default -rm 3 --multiMask --plmask
    batchForceSbp.py gama gama_z0.25_0.4_m11.2_nonbcg_3.fits HSC-R -i 'ISEDFIT_ID' \
        -r default -mf HSC-I -rf HSC-I -rr default -rm 3 --multiMask --plmask
    batchForceSbp.py gama gama_z0.25_0.4_m11.2_nonbcg_4.fits HSC-R -i 'ISEDFIT_ID' \
        -r default -mf HSC-I -rf HSC-I -rr default -rm 3 --multiMask --plmask
    batchForceSbp.py gama gama_z0.25_0.4_m11.2_nonbcg_5.fits HSC-R -i 'ISEDFIT_ID' \
        -r default -mf HSC-I -rf HSC-I -rr default -rm 3 --multiMask --plmask
    batchForceSbp.py gama gama_z0.25_0.4_m11.2_nonbcg_6.fits HSC-R -i 'ISEDFIT_ID' \
        -r default -mf HSC-I -rf HSC-I -rr default -rm 3 --multiMask --plmask
    batchForceSbp.py gama gama_z0.25_0.4_m11.2_nonbcg_7.fits HSC-R -i 'ISEDFIT_ID' \
        -r default -mf HSC-I -rf HSC-I -rr default -rm 3 --multiMask --plmask
    batchForceSbp.py gama gama_z0.25_0.4_m11.2_nonbcg_8.fits HSC-R -i 'ISEDFIT_ID' \
        -r default -mf HSC-I -rf HSC-I -rr default -rm 3 --multiMask --plmask
    ```

    * Backup the `gama01`:
        - Thinkpad: `astro2/hsc/master` -- Finished

### GAMA2 Sample:

    * There was an old `non-cluster` catalog for `0.1 < z < 0.4` GAMA galaxies.
        - `MSTAR >= 11.2 && Z >= 0.1 && Z <= 0.25` --> **1700** galaxies.
        - Save to `gama_z0.10_0.25_m11.2.fits` under `gama_compare/nonbcg` (3.6 Mb)
        - Backup to `~/hsc_redbcg/data` in Dropbox

    * Upload the sample to Master, under `/data3a/work/song/gama2`:
        - New screen: `gama2`

    * Start to generate cutouts:
        - `HSC-I`: `nonbcg_151215_1.submit` -- Finished **1699**
        - `HSC-G`: `nonbcg_151215_2.submit` -- Finished **1699**
        - `HSC-R`: `nonbcg_151215_3.submit` -- Finished **1699**

    * Start to prep cutouts:
        - `HSC-I`: `nonbcg_151216_1.submit` -- Finished  
        - `HSC-G`: `nonbcg_151216_2.submit` -- Finished
        - `HSC-R`: `nonbcg_151216_3.submit` -- Finished

    * Start to estimate sky:
        - `HSC-I`: `nonbcg_151216_4.submit` -- Finished
        - `HSC-G`: `nonbcg_151216_5.submit` -- Finished
        - `HSC-R`: `nonbcg_151216_6.submit` -- Finished

    * 1-D profiles in I-band:

    ```
    # Finished
    batchSbp.py gama gama_z0.1_0.25_m11.2_nonbcg_1.fits -i 'ISEDFIT_ID' \
        -r default -f HSC-I --plmask --multiEllipse
    batchSbp.py gama gama_z0.1_0.25_m11.2_nonbcg_4.fits -i 'ISEDFIT_ID' \
        -r default -f HSC-I --plmask --multiEllipse
    batchSbp.py gama gama_z0.1_0.25_m11.2_nonbcg_2.fits -i 'ISEDFIT_ID' \
        -r default -f HSC-I --plmask --multiEllipse
    batchSbp.py gama gama_z0.1_0.25_m11.2_nonbcg_3.fits -i 'ISEDFIT_ID' \
        -r default -f HSC-I --plmask --multiEllipse
    ```

    * 1-D profiles in G and R-band

    - HSC-G band
    ```
    # Finished
    batchForceSbp.py gama gama_z0.1_0.25_m11.2_nonbcg_2.fits HSC-G -i 'ISEDFIT_ID' \
        -r default -mf HSC-I -rf HSC-I -rr default -rm 3 --multiMask --plmask
    batchForceSbp.py gama gama_z0.1_0.25_m11.2_nonbcg_3.fits HSC-G -i 'ISEDFIT_ID' \
        -r default -mf HSC-I -rf HSC-I -rr default -rm 3 --multiMask --plmask
    batchForceSbp.py gama gama_z0.1_0.25_m11.2_nonbcg_4.fits HSC-G -i 'ISEDFIT_ID' \
        -r default -mf HSC-I -rf HSC-I -rr default -rm 3 --multiMask --plmask
    # Running
    batchForceSbp.py gama gama_z0.1_0.25_m11.2_nonbcg_2.fits HSC-G -i 'ISEDFIT_ID' \
        -r default -mf HSC-I -rf HSC-I -rr default -rm 3 --multiMask --plmask
    ```

    - HSC-R band
    ```
    # Finished
    batchForceSbp.py gama gama_z0.1_0.25_m11.2_nonbcg_2.fits HSC-R -i 'ISEDFIT_ID' \
        -r default -mf HSC-I -rf HSC-I -rr default -rm 3 --multiMask --plmask
    batchForceSbp.py gama gama_z0.1_0.25_m11.2_nonbcg_3.fits HSC-R -i 'ISEDFIT_ID' \
        -r default -mf HSC-I -rf HSC-I -rr default -rm 3 --multiMask --plmask
    batchForceSbp.py gama gama_z0.1_0.25_m11.2_nonbcg_4.fits HSC-R -i 'ISEDFIT_ID' \
        -r default -mf HSC-I -rf HSC-I -rr default -rm 3 --multiMask --plmask
    # Running
    batchForceSbp.py gama gama_z0.1_0.25_m11.2_nonbcg_2.fits HSC-R -i 'ISEDFIT_ID' \
        -r default -mf HSC-I -rf HSC-I -rr default -rm 3 --multiMask --plmask
    ```


### Re-reducing the redMapper data
    * Sky background should be the same
    * Preparation is different, we don't need the multi-rerun now.

    * `/data3a/work/song/redmapper`: Delete all the `smallR1` and `largeR1` reruns
    * New preparation with multiMask option:
        - `red_151216_1.submit` -- `red_prep_I_new` -- Done
    ```
    batchPrep.py redBCG hsc_redmapper_cluster_z${PBS_ARRAYID}_1509.fits \
        -i 'ID_CLUSTER' -r default -f HSC-I --multiMask
    ```

    * New 1-D profiles in I-band:
    ```
    # Finished
    batchSbp.py redBCG hsc_redmapper_cluster_z1_1509.fits \
        -i 'ID_CLUSTER' -r default -f HSC-I --plmask --multiEllipse
    batchSbp.py redBCG hsc_redmapper_cluster_z2_1509.fits \
        -i 'ID_CLUSTER' -r default -f HSC-I --plmask --multiEllipse
    batchSbp.py redBCG hsc_redmapper_cluster_z3_1509.fits \
        -i 'ID_CLUSTER' -r default -f HSC-I --plmask --multiEllipse
    batchSbp.py redBCG hsc_redmapper_cluster_z4_1509.fits \
        -i 'ID_CLUSTER' -r default -f HSC-I --plmask --multiEllipse
    batchSbp.py redBCG hsc_redmapper_cluster_z5_1509.fits \
        -i 'ID_CLUSTER' -r default -f HSC-I --plmask --multiEllipse
    batchSbp.py redBCG hsc_redmapper_cluster_z6_1509.fits \
        -i 'ID_CLUSTER' -r default -f HSC-I --plmask --multiEllipse
    ```

    * New 1-D profiles in other bands:
    ```
    # Done
    batchForceSbp.py redBCG hsc_redmapper_cluster_1509.fits HSC-G \
        -i 'ID_CLUSTER' -r default -mf HSC-I -rf HSC-I -rr default -rm 3 \
        --multiMask --plmask
    batchForceSbp.py redBCG hsc_redmapper_cluster_1509.fits HSC-R \
        -i 'ID_CLUSTER' -r default -mf HSC-I -rf HSC-I -rr default -rm 3 \
        --multiMask --plmask
    batchForceSbp.py redBCG hsc_redmapper_cluster_1509.fits HSC-Z \
        -i 'ID_CLUSTER' -r default -mf HSC-I -rf HSC-I -rr default -rm 3 \
        --multiMask --plmask
    batchForceSbp.py redBCG hsc_redmapper_cluster_1509.fits HSC-Y \
        -i 'ID_CLUSTER' -r default -mf HSC-I -rf HSC-I -rr default -rm 3 \
        --multiMask --plmask
    ```

    * Backup:
        - Thinkpad: `astro2/hsc/master`: `rsync -avz --delete` -- Finished
        - Mac: `astro3/hscs/`: `rsync -avz --delete` -- Finished

----

# 2015-12-18

    * Summarize the current results, and update figures; Discussion with Alexie.  


## GAMA 3 Datasets: 0.1 < z < 0.4 & 11.0 < logM < 11.2
    * Complete the GAMA sample down to 10^11.0; see if the number is reasonable.
        - `0.2 < z < 0.4` and `11.0 < logM* < 11.2`: **2717** (Roughly Ok...)
        - Delete the `nonbcg` data on Master
        - Save as `gama_z0.2_0.4_m11.0_11.2_nonbcg.fits`
        - Split it into 6 smaller chunks, upload to Maser under `/data3a/work/song/gama3`

### Generate cutout:

    * HSC-I band: `nonbcg_151218_1.submit` : 39801@Master
        ``` bash
        batchCut.py /lustre/Subaru/SSP/rerun/yasuda/SSP3.8.5_20150725 \
        gama_z0.1_0.4_m11.0_11.2_nonbcg_${PBS_ARRAYID}.fits -f HSC-I \
        --src --makeDir --noColor --prefix gama \
        --id ISEDFIT_ID --ra RA --dec DEC --redshift Z
        ```
    * HSC-G band: `nonbcg_151218_2.submit` : 39802@Master
    * HSC-R band: `nonbcg_151218_3.submit` : 39803@Master
    * The size of dataset is **416** GB


---- 

# 2015-12-21

## GAMA 3 Dataset: 0.2 < z < 0.4 & 11.0 < logM < 11.2 

### Prepare the data: 

    * HSC-I band: `nonbcg_151221_1.submit` : 40915@Master 
        ``` bash 
        batchPrep.py gama gama_z0.2_0.4_m11.0_11.2_nonbcg_${PBS_ARRAYID}.fits -i \ 
            'ISEDFIT_ID' -r default --multiMask -f HSC-I
        ```
        - Finished, failed for GAMA_4010

### Sky Estimate: 

    * HSC-I band: `nonbcg_151221_2.submit` : 41048@Master 
        ``` bash 
        batchSky.py gama gama_z0.1_0.25_m11.2_nonbcg_${PBS_ARRAYID}.fits \ 
            -i 'ISEDFIT_ID' -r default -f HSC-I
        ```
        - Finished
    * HSC-G band: `nonbcg_151221_3.submit` : 41050@Master  
        ``` bash 
        batchSky.py gama gama_z0.2_0.4_m11.0_11.2_nonbcg_${PBS_ARRAYID}.fits \
            -i 'ISEDFIT_ID' -r default -f HSC-G -mf HSC-I
        ```
    * HSC-R band: `nonbcg_151221_4.submit` : 41051@Master 
    * There is a small bug of `batchSky.py`, fixed it, and redo the G and R-band Sky
        - `nonbcg_151221_4.submit` : HSC-G
        - `nonbcg_151221_5.submit` : HSC-R
        - Finished

### I-band SBP: 

    ``` bash 
    # Finished:
    batchSbp.py gama gama_z0.2_0.4_m11.0_11.2_nonbcg_1.fits -i 'ISEDFIT_ID' \
        -r default -f HSC-I --plmask --multiEllipse
    batchSbp.py gama gama_z0.2_0.4_m11.0_11.2_nonbcg_2.fits -i 'ISEDFIT_ID' \
        -r default -f HSC-I --plmask --multiEllipse
    batchSbp.py gama gama_z0.2_0.4_m11.0_11.2_nonbcg_3.fits -i 'ISEDFIT_ID' \
        -r default -f HSC-I --plmask --multiEllipse
    batchSbp.py gama gama_z0.2_0.4_m11.0_11.2_nonbcg_4.fits -i 'ISEDFIT_ID' \
        -r default -f HSC-I --plmask --multiEllipse
    batchSbp.py gama gama_z0.2_0.4_m11.0_11.2_nonbcg_5.fits -i 'ISEDFIT_ID' \
        -r default -f HSC-I --plmask --multiEllipse
    batchSbp.py gama gama_z0.2_0.4_m11.0_11.2_nonbcg_6.fits -i 'ISEDFIT_ID' \
        -r default -f HSC-I --plmask --multiEllipse
    ```

### Other Bands: 

    * HSC-G band: 
    ```bash 
    # Running:
    batchForceSbp.py gama gama_z0.2_0.4_m11.0_11.2_nonbcg_3.fits HSC-G \
        -i 'ISEDFIT_ID' -r default -mf HSC-I -rf HSC-I -rr default -rm 3 \
        --multiMask --plmask
    # Finished
    batchForceSbp.py gama gama_z0.2_0.4_m11.0_11.2_nonbcg_1.fits HSC-G \
        -i 'ISEDFIT_ID' -r default -mf HSC-I -rf HSC-I -rr default -rm 3 \
        --multiMask --plmask
    batchForceSbp.py gama gama_z0.2_0.4_m11.0_11.2_nonbcg_2.fits HSC-G \
        -i 'ISEDFIT_ID' -r default -mf HSC-I -rf HSC-I -rr default -rm 3 \
        --multiMask --plmask
    batchForceSbp.py gama gama_z0.2_0.4_m11.0_11.2_nonbcg_4.fits HSC-G \
        -i 'ISEDFIT_ID' -r default -mf HSC-I -rf HSC-I -rr default -rm 3 \
        --multiMask --plmask
    batchForceSbp.py gama gama_z0.2_0.4_m11.0_11.2_nonbcg_5.fits HSC-G \
        -i 'ISEDFIT_ID' -r default -mf HSC-I -rf HSC-I -rr default -rm 3 \
        --multiMask --plmask
    batchForceSbp.py gama gama_z0.2_0.4_m11.0_11.2_nonbcg_6.fits HSC-G \
        -i 'ISEDFIT_ID' -r default -mf HSC-I -rf HSC-I -rr default -rm 3 \
        --multiMask --plmask
    ```

    * HSC-R band: 
    ```bash 
    # Finished
    batchForceSbp.py gama gama_z0.2_0.4_m11.0_11.2_nonbcg_1.fits HSC-R \
        -i 'ISEDFIT_ID' -r default -mf HSC-I -rf HSC-I -rr default -rm 3 \
        --multiMask --plmask
    batchForceSbp.py gama gama_z0.2_0.4_m11.0_11.2_nonbcg_2.fits HSC-R \
        -i 'ISEDFIT_ID' -r default -mf HSC-I -rf HSC-I -rr default -rm 3 \
        --multiMask --plmask
    batchForceSbp.py gama gama_z0.2_0.4_m11.0_11.2_nonbcg_3.fits HSC-R \
        -i 'ISEDFIT_ID' -r default -mf HSC-I -rf HSC-I -rr default -rm 3 \
        --multiMask --plmask
    batchForceSbp.py gama gama_z0.2_0.4_m11.0_11.2_nonbcg_4.fits HSC-R \
        -i 'ISEDFIT_ID' -r default -mf HSC-I -rf HSC-I -rr default -rm 3 \
        --multiMask --plmask
    batchForceSbp.py gama gama_z0.2_0.4_m11.0_11.2_nonbcg_5.fits HSC-R \
        -i 'ISEDFIT_ID' -r default -mf HSC-I -rf HSC-I -rr default -rm 3 \
        --multiMask --plmask
    batchForceSbp.py gama gama_z0.2_0.4_m11.0_11.2_nonbcg_6.fits HSC-R \
        -i 'ISEDFIT_ID' -r default -mf HSC-I -rf HSC-I -rr default -rm 3 \
        --multiMask --plmask
    ```


## SED Fitting For BCGs and Cluster Members

    * Have a code to convert magnitudes into fluxes: `fitsMag2Flux.py`
    * Flux catalog for all available BCGs: 
        - `hsc_redmapper_bcg_wide15a_3arcsec_match_flux_cmodel.fits`
        - Separate into 3 redshift bins: 
            1. 0.1 < z < 0.2 : `hsc_bcg_sed_z1.fits` 
            2. 0.2 < z < 0.4 : `hsc_bcg_sed_z2.fits` 
            3. 0.4 < z < 0.6 : `hsc_bcg_sed_z3.fits` 
    * Flux catalog for their members (**Includes BCGs**):
        - `hsc_redmapper_mem_wide15a_2arcsec_match_flux_cmodel.fits`
        - Separate into 3 redshift bins: 
            1. 0.1 < z < 0.2 : `hsc_mem_sed_z1.fits` 
            2. 0.2 < z < 0.4 : `hsc_mem_sed_z2.fits` 
            3. 0.4 < z < 0.6 : `hsc_mem_sed_z3.fits` 
        - **UPDATES**, start a IPython notebook to remove the BCGs, update the ID, 
            and `P_CEN_MEM` value of the members: 
            * `hsc_redmapper_mem_wide15a_2arcsec_match_flux_cmodel_new.fits`
    * Uploads these catalogs to ROSE
        - Make sure the redshifts are monotonic 

----

# 2015-12-22

## SED Fitting For BCGs and Cluster Members
    
    * Generate SED catalogs using just the cModel magnitude error:
        1. 0.1 < z < 0.2 : `hsc_bcg_sed_z1_old.fits` 
        2. 0.2 < z < 0.4 : `hsc_bcg_sed_z2_old.fits` 
        3. 0.4 < z < 0.6 : `hsc_bcg_sed_z3_old.fits` 
        4. 0.1 < z < 0.2 : `hsc_mem_sed_z1_old.fits` 
        5. 0.2 < z < 0.4 : `hsc_mem_sed_z2_old.fits` 
        6. 0.4 < z < 0.6 : `hsc_mem_sed_z3_old.fits` 

    * A few things to adjust: 
        - Reduce `ndraw` number in the parameter file: `ndraw=1000` is enough.
        - Use `outprefix` to separate results for different datasets
        - Reduce the `galchunk` number to 1000

    * After a few tests, it is noticed that: 
        - The `ndraw` number does not affect the best estimates results
        - The invariance value of the flux has lttle effect on the final stellar mass 
        - The new version and old version have different MSTAR due to the difference of
          their fluxes (The old version did not correct Galactic extinction!!)

    * Matches between Old and New BCG catalogs in GAMA fields: 
        - New catalog: `hsc_redmapper_bcg_wide15a_2arcsec_match.fits`
        - Old catalog: `hsc_redmapper_cluster_gama_1509_mass.fits`
        - If matching using HSC `ID`, there are 12 clusters are not recovered; 
        - While matching using `RA_BCG` and `DEC_BCG`, all clusters can be recovered!

    * **Generate New GAMA Flux Catalog**: 
        - `hsc_gama_dr15a_matched_flux_use.fits` under `gama_compare/gama_sed`
        - Separate into 3 redshift bins: 
            1. 0.03 < z < 0.2: `hsc_gama_sed_z1.fits`, **19739** galaxies 
            2. 0.2  < z < 0.4: `hsc_gama_sed_z2.fits`, **12869** galaxies 
            2. 0.4  < z < 0.7: `hsc_gama_sed_z3.fits`, **6417** galaxies 
        - Clear the SED fitting folders on ROSE - Done 
        - Upload new catalogs to ROSE - Done 
    
    * Update the redshift information for BCGs and Members: 
        - For BCGs, first merge the catalog with the GAMA ones
        - GAMA catalog: `hsc_redmapper_cluster_gama_1509_mass.fits`
        - Only use the columns related to GAMA and the `z_use` column. 
        - 0.2 arcsec matches using `RA_BCG` and `DEC_BCG` recover all. 
        - Save it to `hsc_redmapper_bcg_wide15a_3arcsec_match_zUse.fits`
        - Update the IPython notebook to update the redshift information: 
            * z_use > z_spec > z_lambda
            * Overwrite the original table 
        - `fitsMag2Flux.py hsc_redmapper_bcg_wide15a_3arcsec_match_zUse.fits --redCol z_use`
            * `hsc_redmapper_bcg_wide15a_3arcsec_match_zUse_flux_cmodel.fits`
        - Separate the BCG catalog into 3 redshift bins as usual:
            * 0.0 < z < 0.2: `hsc_bcg_sed_z1.fits`, **20**
            * 0.2 < z < 0.4: `hsc_bcg_sed_z2.fits`, **153**
            * 0.4 < z < 0.6: `hsc_bcg_sed_z3.fits`, **92**
        - For members, firt merge the `hsc_gama_dr15a_matched.fits` catalog with the
          member catalog:
            * 0.2 arcsec matches using the HSC RA, Dec results in **1813** matches. 
            * Organize it, save to `hsc_redmapper_mem_wide15a_2arcsec_match_zUse.fits`
        - Update the IPython notebook, also update the redshift information. 
            * Only keep the ones with `abs(z_use - z_use_bcg) <= 0.08 & (modelmag_r_mem -
              modelmag_r_bcg) <= 2.0`
            * This leaves **7930** member galaxies in the sample. 
            * Update the catalog: `hsc_redmapper_mem_wide15a_2arcsec_match_zUse.fits`
        - `fitsMag2Flux.py hsc_redmapper_mem_wide15a_2arcsec_match_zUse.fits --redCol z_use`
            * `hsc_redmapper_mem_wide15a_2arcsec_match_zUse_flux_cmodel.fits`
        -  Go back to the IPython notebook, update `P_CEN_MEM` and `ID_MEM`, then select
           the ones with `P_MEM >= 0.2`: 
            * Leaves **6515** galaxies in the sample
            * `hsc_redmapper_mem_wide15a_2arcsec_match_zUse_flux_cmodel_new.fits`
        - Separate the Members catalog into 3 redshift bins: 
            * 0.0 < z < 0.2: `hsc_mem_sed_z1.fits`, **452**
            * 0.2 < z < 0.4: `hsc_mem_sed_z2.fits`, **3403**
            * 0.4 < z < 0.6: `hsc_mem_sed_z3.fits`, **2657**
        - Upload the BCG and MEM catalogs to ROSE - Done 
            

    * On ROSE, separate the grid making part of the code: 
        - z1a: `make_grid_z1a.pro` - Done 
        - z1b: `make_grid_z1b.pro` - Done 
        - z1c: `make_grid_z1c.pro` - Done 
        - z2a: `make_grid_z2a.pro` - Done 
        - z2b: `make_grid_z2b.pro` - Done 
        - z2c: `make_grid_z2c.pro` - Done 
        - z3a: `make_grid_z3a.pro` - Done 
        - z3b: `make_grid_z3b.pro` - Done 
        - z3c: `make_grid_z3c.pro` - Done 

    * Model z1a: 
        - Copy FITS data from sample - Done 
        - BCGs: 
            1. `hsc_bcg_sed_z1.pro` - Done 
            2. `run_bcg_z1.pro` - Done 
            3. Run ...


    * Model z1a: 
        - `hsc_bcg_sed_z1a_old`: `hsc_bcg_sed_z1_old.pro` - Finished
        - `hsc_bcg_sed_z1a`: `hsc_bcg_sed_z1.pro` - Finished
        - `hsc_mem_sed_z1a`: `hsc_mem_sed_z1.pro` - 


        - `hsc_sed_z1a`: 


----

## TODO List:

    * Check whether the `fluxscale` aperture correction has been applied to GAMA stellar mass
        - `log10 M*,total = <logmstar> + log10(<fluxscale>) - 2 log10(h/0.7)`
        - `M_X,total = <absmag_X> - 2.5 log10(<fluxscale>) + 5 log10(h/0.7)`
    * On the figures, the mean and median statistics should have error bars.  

    * SED fitting for all BCGs, and cluster members.
        - Have a scripts to automatically prepare the iSEDFit ready catalog.
        - Different iSEDFit model grids; Mostly adjust the dust extinction prior


    * Find a way to remove the uncertain SBP, especially for the BCGs

    * SED Fitting results --> Should include KCorrect results.

    * After getting the new SED fitting results, should compare with the old mass limit
      sample, and find the missing ones for a new dataset: `gama5`


-----

### Issues:

    * The corrected SBP and CoG is still need to be tested
    * Sometime `zscale` resacaling can fail, leave a black image on the output figure. (e.g. `redBCG_15251`)
    * The PA correction is still not perfect (e.g. `redBCG_1053`)
