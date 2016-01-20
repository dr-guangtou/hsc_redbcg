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
    # Finished
    batchForceSbp.py gama gama_z0.2_0.4_m11.0_11.2_nonbcg_1.fits HSC-G \
        -i 'ISEDFIT_ID' -r default -mf HSC-I -rf HSC-I -rr default -rm 3 \
        --multiMask --plmask
    batchForceSbp.py gama gama_z0.2_0.4_m11.0_11.2_nonbcg_2.fits HSC-G \
        -i 'ISEDFIT_ID' -r default -mf HSC-I -rf HSC-I -rr default -rm 3 \
        --multiMask --plmask
    batchForceSbp.py gama gama_z0.2_0.4_m11.0_11.2_nonbcg_3.fits HSC-G \
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

## Summarize the 1-D profiles (Updates):

    * Under `/data3a/work/song/gama3` - Finished
    ``` bash
    coaddCutoutSbpSummary.py gama_z0.2_0.4_m11.0_11.2_nonbcg.fits gama \
        --id ISEDFIT_ID --verbose
    ```

    * Under `/data3a/work/song/gama2` - Finished
    ``` bash
    coaddCutoutSbpSummary.py gama_z0.1_0.25_m11.2_nonbcg.fits gama \
        --id ISEDFIT_ID --verbose
    ```

    * Under `/data3a/work/song/redmapper` - Finished
    ``` bash
    coaddCutoutSbpSummary.py hsc_redmapper_bcg_wide15a_3arcsec_match_zUse_mass1a.fits \
        redBCG --id ID_CLUSTER --zCol z_use --verbose
    ```

    * Under `/lustre/Subaru/SSP/rerun/song/gama1` - Running
    ``` bash
    coaddCutoutSbpSummary.py gama_z0.25_0.4_m11.2_nonbcg.fits gama \
        --id ISEDFIT_ID --verbose
    ```

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
            1. `hsc_bcg_sed_z1a.pro` - Done
            2. `run_bcg_z1a.pro` - Done
            3. Run - Finished
        - Mems:
            1. `hsc_mem_sed_z1a.pro` - Done
            2. `run_mem_z1a.pro` - Done
            3. Run - Finished
        - GAMA:
            1. `hsc_gama_sed_z1a.pro` - Done
            2. `run_gama_z1a.pro` - Done
            3. Run - Finished

    * Model z2a:
        - Copy FITS data from sample - Done  
        - BCGs:
            1. `hsc_bcg_sed_z2a.pro` - Done
            2. `run_bcg_z2a.pro` - Done
            3. Run - Finished
        - Mems:
            1. `hsc_mem_sed_z2a.pro` - Done
            2. `run_mem_z2a.pro` - Done
            3. Run - Finished
        - GAMA:
            1. `hsc_gama_sed_z2a.pro` -
            2. `run_gama_z2a.pro` -
            3. Run - Finished

    * Model z3a:
        - Copy FITS data from sample - Done  
        - BCGs:
            1. `hsc_bcg_sed_z3a.pro` - Done
            2. `run_bcg_z3a.pro` - Done
            3. Run - Finished
        - Mems:
            1. `hsc_mem_sed_z3a.pro` - Done
            2. `run_mem_z3a.pro` - Done
            3. Run - Finished
        - GAMA:
            1. `hsc_gama_sed_z3a.pro` - Done  
            2. `run_gama_z3a.pro` - Done
            3. Run - Finished

    * Merge the catalogs for BCGs using model1a:
        - Also combined the KCORRECT catalogs
        - `hsc_bcg_mass_model1a.fits`
        - **NOTICED that there are cases where ISEDFIT failed**
        - Match with `hsc_redmapper_bcg_wide15a_3arcsec_match_zUse.fits`
            * `MSTAR >= 10.0` --> Leaves **262** BCGs
            * Save to `hsc_redmapper_bcg_wide15a_3arcsec_match_zUse_mass1a.fits`
            * Upload to MASTER - Done

----

# 2015-12-23

## New SED Fitting for GAMA sample:

    * Copy all results for `model 1a` to Mac -- Done

    * Model z1c:
        - Copy FITS data from sample - Done
        - BCGs:
            1. `hsc_bcg_sed_z1c.pro` - Done
            2. `run_bcg_z1c.pro` - Done
            3. Run - Finished
        - Mems:
            1. `hsc_mem_sed_z1c.pro` - Done
            2. `run_mem_z1c.pro` - Done
            3. Run - Finished
        - GAMA:
            1. `hsc_gama_sed_z1c.pro` - Done
            2. `run_gama_z1c.pro` - Done
            3. Run - Finished

    * Model z2c:
        - Copy FITS data from sample - Done
        - BCGs:
            1. `hsc_bcg_sed_z2c.pro` - Done
            2. `run_bcg_z2c.pro` - Done
            3. Run - Finished
        - Mems:
            1. `hsc_mem_sed_z2c.pro` - Done
            2. `run_mem_z2c.pro` - Done
            3. Run - Finished
        - GAMA:
            1. `hsc_gama_sed_z2c.pro` - Done
            2. `run_gama_z2c.pro` - Done
            3. Run - Finished

    * Model z3c:
        - Copy FITS data from sample - Done
        - BCGs:
            1. `hsc_bcg_sed_z3c.pro` - Done
            2. `run_bcg_z3c.pro` - Done
            3. Run - Finished
        - Mems:
            1. `hsc_mem_sed_z3c.pro` - Done
            2. `run_mem_z3c.pro` - Done
            3. Run - Finished
        - GAMA:
            1. `hsc_gama_sed_z3c.pro` - Done
            2. `run_gama_z3c.pro` - Done
            3. Run - Finished

    * Model z1b:
        - Copy FITS data from sample - Done
        - BCGs:
            1. `hsc_bcg_sed_z1b.pro` - Done
            2. `run_bcg_z1b.pro` - Done
            3. Run - Finished
        - Mems:
            1. `hsc_mem_sed_z1b.pro` - Done
            2. `run_mem_z1b.pro` - Done
            3. Run - Finished
        - GAMA:
            1. `hsc_gama_sed_z1b.pro` - Done
            2. `run_gama_z1b.pro` - Done
            3. Run - Finished

    * Model z2b:
        - Copy FITS data from sample - Done
        - BCGs:
            1. `hsc_bcg_sed_z2b.pro` - Done
            2. `run_bcg_z2b.pro` - Done
            3. Run - Finished
        - Mems:
            1. `hsc_mem_sed_z2b.pro` - Done
            2. `run_mem_z2b.pro` - Done
            3. Run - Finished
        - GAMA:
            1. `hsc_gama_sed_z2b.pro` - Done
            2. `run_gama_z2b.pro` - Done
            3. Run - Finished

    * Model z3b:
        - Copy FITS data from sample - Done
        - BCGs:
            1. `hsc_bcg_sed_z3b.pro` - Done
            2. `run_bcg_z3b.pro` - Done
            3. Run - Finished
        - Mems:
            1. `hsc_mem_sed_z3b.pro` - Done
            2. `run_mem_z3b.pro` - Done
            3. Run - Finished
        - GAMA:
            1. `hsc_gama_sed_z3b.pro` - Done
            2. `run_gama_z3b.pro` - Done
            3. Run - Finished

     * Copy the BCG and Member results for `model b` and `model c` to Mac
     * Copy the GAMA results for `model c` to Mac

## redMapper Member Galaxy Photometry:

### Select Cluster Members:

    * Combined the `hsc_mem_z1a` catalogs, including the Kcorrect ones:
        - Combined into : `hsc_mem_mass_model1a.fits` **6512**
        - Merge with `hsc_redmapper_mem_wide15a_2arcsec_match_zUse_flux_cmodel_new.fits`
        - 0.2 arcsec matches using `RA_MEM, DEC_MEM` and `RA, DEC`
        - Save the catalog: `hsc_redmapper_mem_wide15a_3arcsec_match_mass.fits`
        - Select the useful ones: `z_use > 0.2 && z_use < 0.4 && MSTAR >= 11.0`
        - This leaves **1670** galaxies.
        - Save the catalog: `redmapper_z0.2_0.4_m11.2_member.fits`  
            * Separate into 4 chunks: `redmapper_z0.2_0.4_m11.2_member_[1/2/3/4].fits`
    * Upload the `redmapper_z0.2_0.4_m11.2_member_[1/2/3/4].fits` to Master
        - Under `/data3a/work/song/redmem`

### Generate cutout:

    * HSC-I band: `redmem_151223_1.submit` : @41688[].master Running
        ``` bash
        batchCut.py /lustre/Subaru/SSP/rerun/yasuda/SSP3.8.5_20150725 \
            redmapper_z0.2_0.4_m11.0_member_${PBS_ARRAYID}.fits -f HSC-I \
            --src --makeDir --noColor --prefix redMem \
            --id ISEDFIT_ID --ra RA --dec DEC --redshift Z
        ```
        - Finished with **1669** galaxies
    * HSC-G band: `redmem_151223_2.submit` : @41689[].master Running
        - Finished with **1669** galaxies
    * HSC-R band: `redmem_151223_3.submit` : @41690[].master Running
        - Finished with **1669** galaxies

### Prepare for Photometry:

    * HSC-I band: `redmem_151224_1.submit`
        ``` bash
        batchPrep.py redMem redmapper_z0.2_0.4_m11.0_member_${PBS_ARRAYID}.fits \
            -i 'ISEDFIT_ID' -r default --multiMask -f HSC-I
        ```
        - Finished with no problem

### Estimate the Sky Background

    * HSC-I band: `redmem_151224_2.submit`  
        ``` bash
        batchSky.py redMem redmapper_z0.2_0.4_m11.0_member_${PBS_ARRAYID}.fits \
            -i 'ISEDFIT_ID' -r default -f HSC-I
        ```

    * HSC-G band: `redmem_151224_3.submit`
        ``` bash
        batchSky.py redMem redmapper_z0.2_0.4_m11.0_member_${PBS_ARRAYID}.fits \
            -i 'ISEDFIT_ID' -r default -f HSC-G -mf HSC-I
        ```

    * HSC-R band: `redmem_151224_4.submit`
        ``` bash
        batchSky.py redMem redmapper_z0.2_0.4_m11.0_member_${PBS_ARRAYID}.fits \
            -i 'ISEDFIT_ID' -r default -f HSC-R -mf HSC-I
        ```

### I-band SBP:

    ``` bash
    # Finished
    batchSbp.py redMem redmapper_z0.2_0.4_m11.0_member_1.fits -i 'ISEDFIT_ID' \
        -r default -f HSC-I --plmask --multiEllipse
    batchSbp.py redMem redmapper_z0.2_0.4_m11.0_member_2.fits -i 'ISEDFIT_ID' \
        -r default -f HSC-I --plmask --multiEllipse
    batchSbp.py redMem redmapper_z0.2_0.4_m11.0_member_3.fits -i 'ISEDFIT_ID' \
        -r default -f HSC-I --plmask --multiEllipse
    batchSbp.py redMem redmapper_z0.2_0.4_m11.0_member_4.fits -i 'ISEDFIT_ID' \
        -r default -f HSC-I --plmask --multiEllipse
    ```

### G-band Forced SBP:

    ``` bash
    # Running
    batchForceSbp.py redMem redmapper_z0.2_0.4_m11.0_member_1.fits HSC-G \
        -i 'ISEDFIT_ID' -r default -mf HSC-I -rf HSC-I -rr default -rm 3 \
        --multiMask --plmask
    batchForceSbp.py redMem redmapper_z0.2_0.4_m11.0_member_2.fits HSC-G \
        -i 'ISEDFIT_ID' -r default -mf HSC-I -rf HSC-I -rr default -rm 3 \
        --multiMask --plmask
    batchForceSbp.py redMem redmapper_z0.2_0.4_m11.0_member_3.fits HSC-G \
        -i 'ISEDFIT_ID' -r default -mf HSC-I -rf HSC-I -rr default -rm 3 \
        --multiMask --plmask
    batchForceSbp.py redMem redmapper_z0.2_0.4_m11.0_member_4.fits HSC-G \
        -i 'ISEDFIT_ID' -r default -mf HSC-I -rf HSC-I -rr default -rm 3 \
        --multiMask --plmask
    ```

### R-band Forced SBP:

    ``` bash
    # Running
    batchForceSbp.py redMem redmapper_z0.2_0.4_m11.0_member_1.fits HSC-R \
        -i 'ISEDFIT_ID' -r default -mf HSC-I -rf HSC-I -rr default -rm 3 \
        --multiMask --plmask
    batchForceSbp.py redMem redmapper_z0.2_0.4_m11.0_member_2.fits HSC-R \
        -i 'ISEDFIT_ID' -r default -mf HSC-I -rf HSC-I -rr default -rm 3 \
        --multiMask --plmask
    batchForceSbp.py redMem redmapper_z0.2_0.4_m11.0_member_3.fits HSC-R \
        -i 'ISEDFIT_ID' -r default -mf HSC-I -rf HSC-I -rr default -rm 3 \
        --multiMask --plmask
    batchForceSbp.py redMem redmapper_z0.2_0.4_m11.0_member_4.fits HSC-R \
        -i 'ISEDFIT_ID' -r default -mf HSC-I -rf HSC-I -rr default -rm 3 \
        --multiMask --plmask
    ```

### Summarize the SBP profiles:

    * Under `/data3a/work/song/redmem` - Running
    ``` bash
    coaddCutoutSbpSummary.py redmapper_z0.2_0.4_m11.0_member.fits redMem \
        --id ISEDFIT_ID --verbose
    ```

## Organize GAMA and redMapper SBP:

    * Learn how to match two samples on various parameters:
    * Learn the behaviours of `scipy.interp1d`
        - Set `bounds_error=False` will avoid having errors when the radius is larger than the common one.  And, should use a finer grid to ensure the interpolation is accurate.

----

# 2016-01-02

## HSC-Z band SBP for GAMA and redMem galaxies:

### GAMA1:

    * Under `/lustre/Subaru/SSP/rerun/song/gama1`

#### Preparation:
    * Edit: `nonbcg_160102_1.submit`
    ```
    batchCut.py /lustre/Subaru/SSP/rerun/yasuda/SSP3.8.5_20150725 \
        gama_z0.25_0.4_m11.2_nonbcg_${PBS_ARRAYID}.fits -f HSC-Z \
        --src --makeDir --noColor --prefix gama \
        --id ISEDFIT_ID --ra RA --dec DEC --redshift Z
    ```
    * Submit job...finished:
      - 42666[].master

#### Sky: 
    * Edit: `gama1_160102_2.submit`
    ```
    batchSky.py gama gama_z0.25_0.4_m11.2_nonbcg_${PBS_ARRAYID}.fits \
        -i 'ISEDFIT_ID' -r default -f HSC-Z -mf HSC-I
    ```
    * Submit job...finished:
      - 42700[].master

#### Forced SBP:

    * Run from shell: **8 chunks** in total
    ```
    # Finished
    batchForceSbp.py gama gama_z0.25_0.4_m11.2_nonbcg_1.fits HSC-Z \
        -i 'ISEDFIT_ID' -r default -mf HSC-I -rf HSC-I -rr default \
        -rm 3 --multiMask --plmask
    batchForceSbp.py gama gama_z025_0.4_m11.2_nonbcg_2.fits HSC-Z \
        -i 'ISEDFIT_ID' -r default -mf HSC-I -rf HSC-I -rr default \
        -rm 3 --multiMask --plmask 
    batchForceSbp.py gama gama_z0.25_0.4_m11.2_nonbcg_3.fits HSC-Z \
        -i 'ISEDFIT_ID' -r default -mf HSC-I -rf HSC-I -rr default \
        -rm 3 --multiMask --plmask
    batchForceSbp.py gama gama_z0.25_0.4_m11.2_nonbcg_4.fits HSC-Z \
        -i 'ISEDFIT_ID' -r default -mf HSC-I -rf HSC-I -rr default \
        -rm 3 --multiMask --plmask
    batchForceSbp.py gama gama_z0.25_0.4_m11.2_nonbcg_5.fits HSC-Z \
        -i 'ISEDFIT_ID' -r default -mf HSC-I -rf HSC-I -rr default \
        -rm 3 --multiMask --plmask
    batchForceSbp.py gama gama_z0.25_0.4_m11.2_nonbcg_6.fits HSC-Z \
        -i 'ISEDFIT_ID' -r default -mf HSC-I -rf HSC-I -rr default \
        -rm 3 --multiMask --plmask
    batchForceSbp.py gama gama_z0.25_0.4_m11.2_nonbcg_7.fits HSC-Z \
        -i 'ISEDFIT_ID' -r default -mf HSC-I -rf HSC-I -rr default \
        -rm 3 --multiMask --plmask
    batchForceSbp.py gama gama_z0.25_0.4_m11.2_nonbcg_8.fits HSC-Z \
        -i 'ISEDFIT_ID' -r default -mf HSC-I -rf HSC-I -rr default \
        -rm 3 --multiMask --plmask
    ```

### GAMA2:

    * Under `/data3a/work/song/gama2`

#### Preparation:
    * Edit: `gama2_160102_1.submit`
    ```
    batchCut.py /lustre/Subaru/SSP/rerun/yasuda/SSP3.8.5_20150725 \
        gama_z0.1_0.25_m11.2_nonbcg_${PBS_ARRAYID}.fits -f HSC-Z \
        --src --makeDir --noColor --prefix gama \
        --id ISEDFIT_ID --ra RA --dec DEC --redshift Z
    ```
    * Submit job...finished:
      - 42670[].master

#### Sky: 
    * Edit: `gama2_160102_2.submit`
    ```
    batchSky.py gama gama_z0.1_0.25_m11.2_nonbcg_${PBS_ARRAYID}.fits \
        -i 'ISEDFIT_ID' -r default -f HSC-Z -mf HSC-I
    ```
    * Submit job...running:
      - 42699[].master

#### Forced SBP:

    * Run from shell: **4 chunks** in total
    ```
    # Finished:
    batchForceSbp.py gama gama_z0.1_0.25_m11.2_nonbcg_1.fits HSC-Z \
        -i 'ISEDFIT_ID' -r default -mf HSC-I -rf HSC-I -rr default \
        -rm 3 --multiMask --plmask
    batchForceSbp.py gama gama_z0.1_0.25_m11.2_nonbcg_2.fits HSC-Z \
        -i 'ISEDFIT_ID' -r default -mf HSC-I -rf HSC-I -rr default \
        -rm 3 --multiMask --plmask 
    batchForceSbp.py gama gama_z0.1_0.25_m11.2_nonbcg_4.fits HSC-Z \
        -i 'ISEDFIT_ID' -r default -mf HSC-I -rf HSC-I -rr default \
        -rm 3 --multiMask --plmask
    batchForceSbp.py gama gama_z0.1_0.25_m11.2_nonbcg_3.fits HSC-Z \
        -i 'ISEDFIT_ID' -r default -mf HSC-I -rf HSC-I -rr default \
        -rm 3 --multiMask --plmask
    ```


### GAMA3:
    * Under `/data3a/work/song/gama3`

#### Preparation:
    * Edit: `gama3_160102_1.submit`
    ```
    batchCut.py /lustre/Subaru/SSP/rerun/yasuda/SSP3.8.5_20150725 \
        gama_z0.2_0.4_m11.0_11.2_nonbcg_${PBS_ARRAYID}.fits -f HSC-Z \
        --src --makeDir --noColor --prefix gama \
        --id ISEDFIT_ID --ra RA --dec DEC --redshift Z
    ```
    * Submit job...finished:
      - 42671[].master

#### Sky: 
    * Edit: `gama3_160102_2.submit`
    ```
    batchSky.py gama gama_z0.2_0.4_m11.0_11.2_nonbcg_${PBS_ARRAYID}.fits \
        -i 'ISEDFIT_ID' -r default -f HSC-Z -mf HSC-I
    ```
    * Submit job...finished
        - 42698[].master

#### Forced SBP:

    * Run from shell: **6 chunks** in total
    ```
    # Finished
    batchForceSbp.py gama gama_z0.2_0.4_m11.0_11.2_nonbcg_1.fits HSC-Z \
        -i 'ISEDFIT_ID' -r default -mf HSC-I -rf HSC-I -rr default \
        -rm 3 --multiMask --plmask
    batchForceSbp.py gama gama_z0.2_0.4_m11.0_11.2_nonbcg_2.fits HSC-Z \
        -i 'ISEDFIT_ID' -r default -mf HSC-I -rf HSC-I -rr default \
        -rm 3 --multiMask --plmask
    batchForceSbp.py gama gama_z0.2_0.4_m11.0_11.2_nonbcg_6.fits HSC-Z \
        -i 'ISEDFIT_ID' -r default -mf HSC-I -rf HSC-I -rr default \
        -rm 3 --multiMask --plmask
    batchForceSbp.py gama gama_z0.2_0.4_m11.0_11.2_nonbcg_3.fits HSC-Z \
        -i 'ISEDFIT_ID' -r default -mf HSC-I -rf HSC-I -rr default \
        -rm 3 --multiMask --plmask
    batchForceSbp.py gama gama_z0.2_0.4_m11.0_11.2_nonbcg_4.fits HSC-Z \
        -i 'ISEDFIT_ID' -r default -mf HSC-I -rf HSC-I -rr default \
        -rm 3 --multiMask --plmask
    batchForceSbp.py gama gama_z0.2_0.4_m11.0_11.2_nonbcg_5.fits HSC-Z \
        -i 'ISEDFIT_ID' -r default -mf HSC-I -rf HSC-I -rr default \
        -rm 3 --multiMask --plmask
    ```


### redMem:
    * Under `/data3a/work/song/redmem`

#### Preparation:
    * Edit: `redmem_160102_1.submit`
    ```
    batchCut.py /lustre/Subaru/SSP/rerun/yasuda/SSP3.8.5_20150725 \
        redmapper_z0.2_0.4_m11.0_member_${PBS_ARRAYID}.fits -f HSC-Z \
        --src --makeDir --noColor --prefix redMem \
        --id ISEDFIT_ID --ra RA --dec DEC --redshift Z  
    ```
    * Submit job...Finished:
      - 42678[].master

#### Sky: 
    * Edit: `redmem_160102_2.submit`
    ```
    batchSky.py redMem redmapper_z0.2_0.4_m11.0_member_${PBS_ARRAYID}.fits \
        -i 'ISEDFIT_ID' -r default -f HSC-Z -mf HSC-I
    ```
    * Submit job...Finished

#### Forced SBP:

    * Run from shell: **4 chunks** in total
    ```
    # Finished
    batchForceSbp.py redMem redmapper_z0.2_0.4_m11.0_member_1.fits HSC-Z \
        -i 'ISEDFIT_ID' -r default -mf HSC-I -rf HSC-I -rr default -rm 3 \ 
        --multiMask --plmask
    batchForceSbp.py redMem redmapper_z0.2_0.4_m11.0_member_2.fits HSC-Z \
        -i 'ISEDFIT_ID' -r default -mf HSC-I -rf HSC-I -rr default -rm 3 \ 
        --multiMask --plmask
    batchForceSbp.py redMem redmapper_z0.2_0.4_m11.0_member_3.fits HSC-Z \
        -i 'ISEDFIT_ID' -r default -mf HSC-I -rf HSC-I -rr default -rm 3 \ 
        --multiMask --plmask
    batchForceSbp.py redMem redmapper_z0.2_0.4_m11.0_member_4.fits HSC-Z \
        -i 'ISEDFIT_ID' -r default -mf HSC-I -rf HSC-I -rr default -rm 3 \ 
        --multiMask --plmask
    ```

----

# 2016-01-04


## Stellar mass from SED fitting:

    * Copy the `model b` SED fitting results for GAMA galaxies to Mac. 

### There is a problem: 

    * SED fitting results from different redshift bins can have the same ISEDFIT number
        - After combining the catalog, should make an `INDEX` column
        - Or can simply match using RA, DEC, as they should have exactly same value. 
    * This does not affect `GAMA1`, `GAMA2`, `redMem`,`GAMA3` for now....
        - **BUT should keep this in mind for later**

### Combined catalogs: 

    * `hsc_bcg_mass_model1a.fits` and `hsc_mem_mass_model1a.fits` are available 

    * Stellar mass catalog for each dataset
        * Steps: 
            1. Rename the `ISEDFIT_ID` columns in all K-correct catalogs to `ISEDFIT_ID_2`
            2. Unselect `Z`, `MAGGIES`, and `IVARMAGGIES` columns in all K-correct catalogs
            3. Match between the SED and K-correct catalogs for three redshift bins. 
            4. Concatenate the merged catalogs for three redshift bins 
            5. Unselect `ISEDFIT_ID_2` column; And make a `INDEX` column
            6. Rename the catalog; Sort up using `Z` column
    
        1. BCG: `model b: bc03_stelib_chab_calzetti` 
            - `hsc_bcg_mass_model1b.fits`:  Done
        2. BCG: `model c: fsps_v2.4_miles_chab_calzetti` 
            - `hsc_bcg_mass_model1c.fits`:  Done
        3. GAMA: `model a: fsps_v2.4_miles_chab_calzetti` 
            - `hsc_gama_mass_model1a.fits`:  Done
        4. GAMA: `model b: bc03_stelib_chab_calzetti`
            - `hsc_gama_mass_model1b.fits`:  Done
        5. GAMA: `model c: fsps_v2.4_miles_chab_calzetti` 
            - `hsc_gama_mass_model1c.fits`:  Done
        6. redMem: `model b: bc03_stelib_chab_calzetti` 
            - `hsc_mem_mass_model1b.fits`:  Done 
        7. redMem: `model c: fsps_v2.4_miles_chab_calzetti` 
            - `hsc_mem_mass_model1c.fits`:  Done

    * Using `model a` as reference, create a table to compare stellar mass estimates 
        - Modify the `model b` catalog, only keep useful columns, and add a suffix `_b`
        - Modify the `model c` catalog, only keep useful columns, and add a suffix `_c`
        - Match with `model a` catalog using RA, DEC

        1. BCG: `hsc_bcg_mass_compare.fits`: Done
        2. MEM: `hsc_mem_mass_compare.fits`: Done
        3. GAMA: `hsc_gama_mass_compare.fits`: Done

    * In summary: 
        1. The BC03 model has systematically smaller stellar mass 
        2. A fraction of massive galaxies have smaller mass in `model c` compared to
           `model a`

----

# 2016-01-06

    * Update the `coaddCutoutSbpSummary.py` to include more interpolated profiles. 

## Re-reducing the SBP of redMapper BCGs

    * Use the new SED fitting results to include more BCGs 
        - `hsc_redmapper_bcg_wide15a_3arcsec_match_zUse_mass1a.fits`

    * Commands: 
    ```
    # Finished
    batchSbp.py redBCG hsc_redmapper_bcg_wide15a_3arcsec_match_zUse_mass1a.fits \
        -i 'ID_CLUSTER' -r default -f HSC-I --plmask --multiEllipse
    batchForceSbp.py redBCG hsc_redmapper_bcg_wide15a_3arcsec_match_zUse_mass1a.fits HSC-G \
        -i 'ID_CLUSTER' -r default -mf HSC-I -rf HSC-I -rr default -rm 3 \
        --multiMask --plmask
    batchForceSbp.py redBCG hsc_redmapper_bcg_wide15a_3arcsec_match_zUse_mass1a.fits HSC-R \
        -i 'ID_CLUSTER' -r default -mf HSC-I -rf HSC-I -rr default -rm 3 \
        --multiMask --plmask
    batchForceSbp.py redBCG hsc_redmapper_bcg_wide15a_3arcsec_match_zUse_mass1a.fits HSC-Z \
        -i 'ID_CLUSTER' -r default -mf HSC-I -rf HSC-I -rr default -rm 3 \
        --multiMask --plmask
    batchForceSbp.py redBCG hsc_redmapper_bcg_wide15a_3arcsec_match_zUse_mass1a.fits HSC-Y \
        -i 'ID_CLUSTER' -r default -mf HSC-I -rf HSC-I -rr default -rm 3 \
        --multiMask --plmask
    ```

----

# 2016-01-07

## Organize the catalogs: 

    * Rename `~/work/hscs/gama_compare` to `~/work/hscs/gama_massive`
    * Rsync backup `gama_compare` folder to `~/astro3/hscs/gama_massive`
    * On Master: rsync `gama1` from `lustre/Subaru/SSP/rerun/song` to `/data3a/work/song`
    * On W520: start rsync recent updates of all reruns. 

### Collecting input catalog for different reruns: 

    - Put all catalogs for sample into `massive_sample` folder, copy to Mac 
        * `~/work/hscs/gama_compare/gama_sed`
    - These catalogs are:
        * `redBCG`: `redmapper_bcg_hscmatch.fits` **265** 
            - Make `ID_USE`: `"redbcg_" + toString(ID_CLUSTER)`
            - Keep everything
        * `redMem`: `redmapper_z0.2_0.4_m11.0_member.fits` **1670** 
            - Make `ID_USE`: `"redmem_" + toString(ISEDFIT_ID)`
            - Deselect the ISEDFIT related columns
        * `gama1`:  `gama_z0.25_0.4_m11.2_nonbcg.fits` **3747** 
            - Make `ID_USE`: `"gama1_" + toString(ISEDFIT_ID)`
            - Deselect the ISEDFIT related columns
        * `gama2`:  `gama_z0.1_0.25_m11.2_nonbcg.fits` **1700**
            - Make `ID_USE`: `"gama2_" + toString(ISEDFIT_ID)`
            - Deselect the ISEDFIT related columns
        * `gama3`:  `gama_z0.2_0.4_m11.0_11.2_nonbcg.fits` **2718**
            - Make `ID_USE`: `"gama3_" + toString(ISEDFIT_ID)`
            - Deselect the ISEDFIT related columns

### Mass comparison

    1. `hsc_bcg_mass_compare.fits`: **265** Galaxies  
        - Replace the N-elements arrays with N-columns - Done  
        - Match to `redmapper_bcg_hscmatch.fits`
        - Save to `redmapper_bcg_hscmatch_mass.fits`
        - **3** BCGs have strangely low MSTAR: **1846, 2347, 21677**
        - **2** BCGs don't have SED fitting results: **8441, 29792**
            * Exclude them from the sample for now!
            * Save to `redmapper_bcg_hscmatch_mass_use.fits` **260**
    2. `hsc_mem_mass_compare.fits`
        - Replace the N-elements arrays with N-columns - Done
        - Match to `redmapper_z0.2_0.4_m11.0_member.fits`
        - Save to `redmapper_mem_hscmatch_mass.fits`
    3. `hsc_gama_mass_compare.fits`
        - Replace the N-elements arrays with N-columns - Done
        - Match to `gama_z0.25_0.4_m11.2_nonbcg.fits`
            * Save to `gama1_mass.fits`
        - Match to `gama_z0.1_0.25_m11.2_nonbcg.fits`
            * Save to `gama2_mass.fits`
        - Match to `gama_z0.2_0.4_m11.0_11.2_nonbcg.fits`
            * Save to `gama3_mass.fits`
        - Merge the three GAMA catalogs into a single one: 
            * Save to `gama_massive_mass_160107.fits`

### Missing objects based on the new SED fitting results: 

    * In the new GAMA SED fitting results: `hsc_gama_mass_compare.fits`
        - `Z >= 0.1 && Z <= 0.55 && MSTAR >= 11.0` --> **13495** galaxies 
        - Save to `gama_z0.1_0.55_m11.0_hscmatch_mass.fits`
        - Match to `gama_massive_mass_160107.fits`, save the missing ones 
            * There are **5980** galaxies
            * Among them, there are **2888** galaxies with `Z >= 0.2 && Z <= 0.5`
            * Match these galaxies with the input catalog
            * Save to `gama4_mass.fits`

    * Transfer the new sample catalogs to `/home/song/work/massive_sample/` on `Master`


## Organizing the available SBPs on Master: 

    * **WARNING**: It appears that sometimes the forceSbp leaves problematic SBPs
        - e.g. '21302'

### 1. `redmapper`: `redbcg`

    ``` bash 
    coaddCutoutSbpSummary.py redmapper_bcg_hscmatch_mass_use.fits redBCG \
        --id ID_CLUSTER --sample redbcg --suffix modA_muI1 \
        --sumFolder sbp_modA_muI1 --verbose --plot \
        --logm MSTAR --sbpRef lumI1
    ```
        - LOG file: `sbp_modA_muI1.log`
        - Finished
        - **243** profiles
        - Problematic ones:
            * Not available: **48732, 73887, 11330, 5197, 36194, 29826, 23868, 10793,
              6497, 22120, 21087, 16054, 24930, 9724, 2014**
            * Multimask fail: **2667, 28725, 54313, 24624, 14671, 7557, 6470, 3292, 21390**
                - Leave these profiles to `trouble`
                - Still have **234** profiles
        - Copy related data to `~/work/hscs/gama_massive/sbp/redbcg`

    * Using the `_full_img_ellip_default_3.png` and `_full_ellip_default_compare.png` to vet the BCGs. 
        - Problematci ones: **14039x, 51588x**
        - Contaminated one (?): **10982, 13402x, 15786x, 20008, 21537x, 24214x, 24732x, 25561x,
          29828x, 31536, 33239x, 38310, 40835x, 47746x, 5442, 7574x, 8954x**
        - Disk galaxy: **1236, 16474, 20190x, 2799**: 
        - The "x" ones are put to `trouble`
        - Leaves **219** SBPs
        
### 2. `redmapper`: `redmem`

    ``` bash 
    coaddCutoutSbpSummary.py redmapper_mem_hscmatch_mass.fits redMem \
        --id ISEDFIT_ID --sample redbcg --suffix modA_muI1 \
        --sumFolder sbp_modA_muI1 --verbose --plot \
        --logm MSTAR --sbpRef lumI1
    ```
        - Finished 
        - **1578** profiles
        - Copy related data to `~/work/hscs/gama_massive/sbp/redmem`

### 3. `gama2` 

    ``` bash 
    coaddCutoutSbpSummary.py gama2_mass.fits gama \
        --id ISEDFIT_ID --sample gama2 --suffix modA_muI1 \
        --sumFolder sbp_modA_muI1 --verbose --plot \
        --logm MSTAR --sbpRef lumI1
    ```
        - Finished
        - **1537** profiles
        - Copy related data to `~/work/hscs/gama_massive/sbp/gama2`

### 4. `gama3` 

    ``` bash 
    coaddCutoutSbpSummary.py gama3_mass.fits gama \
        --id ISEDFIT_ID --sample gama3 --suffix modA_muI1 \
        --sumFolder sbp_modA_muI1 --verbose --plot \
        --logm MSTAR --sbpRef lumI1
    ```
        - Finished
        - **2526** profiles 
        - Copy related data to `~/work/hscs/gama_massive/sbp/gama2`

### 5. `gama1` 

    ``` bash 
    coaddCutoutSbpSummary.py gama1_mass.fits gama \
        --id ISEDFIT_ID --sample gama1 --suffix modA_muI1 \
        --sumFolder sbp_modA_muI1 --verbose --plot \
        --logm MSTAR --sbpRef lumI1
    ```
        - Finished 
        - **3583** profiles
        - Copy related data to `~/work/hscs/gama_massive/sbp/gama1`

----

# 2016-01-08

## Data volume: 

    * GAMA1 : **792** GB 
    * GAMA2 : **694** GB 
    * GAMA3 : **635** GB 
    * redBCG : **84** GB 
    * redMEM : **302** GB

## Organizing catalogs and SBPs: 

    * Merging the 3 GAMA datasets together: `/Users/songhuang/work/hscs/gama_massive/sbp`
        - Catalog: `gama_massive_160107_sbpsum_modA_muI1.fits`
        - Data: under `sbp_modA_muI1`

    * Organize BCG catalog
        - Match: `redmapper_bcg_hscmatch_mass_use_sbpsum_modA_muI1.fits` with 
                 `hsc_redmapper_cluster_gama_1509_mass.fits` for GAMA information
                 (`fluxscale_gama`) 
            * Keep every rows; Save to `redbcg_mass.fits`
            * Save the **219** useful ones with SBPs; Save to `redbcg_mass_use.fits`

    * Understand the iSEDFit K-correction
        - For both GAMA and redBCG sample, the `SYNTH_ABSMAG_I` and `ABSMAG_I` have very
          good consistency; It is true for other band too.
        - From Kcorrect document: 
            ```
            These K-correction and photometric redshift routines will also return absolute
            magnitudes (and inverse variances of the same). To do so it assumes Ωm = 0.3
            and ΩΛ = 0.7 (though these can be set differently on input). **Absolute
            magnitudes are reported minus 5log10(h)** (where Ho = h*100 km/s/Mpc), with h=1
            (ie, to use H0=72 km/s/Mpc one has add 5log10(.72) to the output of the code). 
            ```

----

# 2016-01-09

    * GALFIT related code: 
        - `batchGalfit.py`
        - `coaddCutoutGalfitSimple.py`
        - Test it on local data: 
            ``` bash 
            batchGalfit.py redBCG bcg_test.fits --id ID --verbose --ser2Comp --ser3Comp \
                --skyGrad --useF1 --run1 --root '../'
            ```
        - Test it on Master:

    * Prepare figures for the collaboration meeting: 
        - See: `/Users/songhuang/Dropbox/work/submit/hsc_redbcg/note/massiveSbp_160107.ipynb`

----

# 2016-01-10

    * GALFIT Run on Master 
        - redBCG: 1Ser+2Ser+3Ser, noF1, deleteAfter: `running`
        - redMem: 1Ser+2Ser, noF1, deleteAfter: `running`
        - GAMA1: 1Ser+2Ser, noF1, deleteAfter: `running`
        - GAMA2: 1Ser+2Ser, noF1, deleteAfter: `running`
        - GAMA3: 1Ser+2Ser, noF1, deleteAfter: `running`

    * `massiveSbp_160107.ipynb`

## Luminosity subsamples: 
    
    * For `gama`, `mem`, `bcg` datasets: 
        - `L1a`: lum_100; modelC,  0.2 < z < 0.4; 11.1 < logL < 11.3
        - `L1b`: lum_120; modelC,  0.2 < z < 0.4; 11.1 < logL < 11.3
        - `L2a`: lum_100; modelC,  0.2 < z < 0.4; 11.3 < logL < 11.5
        - `L2b`: lum_120; modelC,  0.2 < z < 0.4; 11.3 < logL < 11.5
        - `L3a`: lum_100; modelC,  0.2 < z < 0.4; 11.5 < logL < 11.7
        - `L3b`: lum_120; modelC,  0.2 < z < 0.4; 11.5 < logL < 11.7
        - `CL1a`: lum_10, modelC,  0.2 < z < 0.4; 10.8 < logLC < 11.0
        - `CL1b`: lum_10, modelA,  0.2 < z < 0.4; 10.8 < logLC < 11.0
        - `CL2a`: lum_10, modelC,  0.2 < z < 0.4; 11.0 < logLC < 11.2
        - `CL2b`: lum_10, modelA,  0.2 < z < 0.4; 11.0 < logLC < 11.2

    * For BCGs, there are subsamples with '_pcen' suffix that also has 
      `P_CEN_1 > 0.8`

## Stellar Mass subsamples: 
    
    * For `gama`, `mem`, `bcg` datasets: 
        - `M1a`: lum_100; modelC,  0.2 < z < 0.4; 11.4 < logM < 11.6
        - `M1b`: lum_120; modelC,  0.2 < z < 0.4; 11.4 < logM < 11.6
        - `M1c`: lum_100; modelA,  0.2 < z < 0.4; 11.4 < logM < 11.6
        - `M2a`: lum_100; modelC,  0.2 < z < 0.4; 11.6 < logM < 11.8
        - `M2b`: lum_120; modelC,  0.2 < z < 0.4; 11.6 < logM < 11.8
        - `M2c`: lum_100; modelA,  0.2 < z < 0.4; 11.6 < logM < 11.8
        - `M3a`: lum_100; modelC,  0.2 < z < 0.4; 11.8 < logM < 12.1
        - `M3b`: lum_120; modelC,  0.2 < z < 0.4; 11.8 < logM < 12.1
        - `M3c`: lum_100; modelA,  0.2 < z < 0.4; 11.8 < logM < 12.1

        - `CM1a`: lum_10; modelC,  0.2 < z < 0.4; 10.9 < logM < 11.1
        - `CM1b`: lum_10; modelA,  0.2 < z < 0.4; 10.9 < logM < 11.1
        - `CM2a`: lum_10; modelC,  0.2 < z < 0.4; 11.1 < logM < 11.3
        - `CM2b`: lum_10; modelA,  0.2 < z < 0.4; 11.1 < logM < 11.3
        - `CM3a`: lum_10; modelC,  0.2 < z < 0.4; 11.3 < logM < 11.5
        - `CM3b`: lum_10; modelA,  0.2 < z < 0.4; 11.3 < logM < 11.5

    * For BCGs, there are subsamples with '_pcen' suffix that also has 
      `P_CEN_1 > 0.8`

----

# 2016-01-20

    * Save all the sub-samples from the above IPython notebook into individual FITS files

## Generating **gri** color pictures for GAMA galaxies: 

    - Using fixed size to save space: **700x700**
        * `gama1_gri.submit`  - Running
        * `gama2_gri.submit`  - Running 
        * `gama3_gri.submit`  - Running

## GAMA 4: `0.2 < z < 0.5`; logM > 11.0 in the new SED fitting results

### Generating Cutouts: 

    - Change the `coaddImageCutout.py` a little bit; And change `batchCut.py` to be able 
        to use `--noSrc` to stop generating source catalog for cutout:
        ``` bash 
        batchCut.py /lustre/Subaru/SSP/rerun/yasuda/SSP3.8.5_20150725 \
            sample/gama4_mass_${PBS_ARRAYID}.fits -f HSC-I \
            --makeDir --noColor --noSrc --prefix gama4 \
            --id ISEDFIT_ID --ra RA --dec DEC --redshift Z
        ```

    - Under `/lustre/Subaru/SSP/rerun/song/gama4`
        * `HSC-I`: `gama4_160120_1.submit` -- Running 
        * `HSC-R`: `gama4_160120_2.submit` -- Running 
        * `HSC-G`: `gama4_160120_3.submit` -- Running 
        * `HSC-Z`: `gama4_160120_4.submit` -- Running 



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

    * After getting the new SED fitting results, should compare with the old mass limit
      sample, and find the missing ones for a new dataset: `gama4`

-----

### Issues:

    * The corrected SBP and CoG is still need to be tested
    * Sometime `zscale` resacaling can fail, leave a black image on the output figure. (e.g. `redBCG_15251`)
    * The PA correction is still not perfect (e.g. `redBCG_1053`)
