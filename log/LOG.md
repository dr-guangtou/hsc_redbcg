# redMapper BCGs in HSC Survey

----

## Sample:

    ``` python
    loc = '~/Dropbox/work/hsc/redmapper/1509/'
    catCHsc = '../1509/hsc_redmapper_cluster_1509.fits'
    catMHsc = '../1509/hsc_redmapper_member_1509.fits'
    ```

----

## 2015-12-05

    * `redMapperRaDec.ipynb`:
        - Update the RA, DEC plots
        - Estimate the:
            1. Magnitude gap between BCG and second brightest galaxy (`bcgGap`)
            2. BCG Dominance: Magnitude difference between the BCG and the mean magnitude of the 2nd to 6th brightest galaxies (`bcgDom`)
            3. BCG's luminosity fraction compared to the sum of the 2nd to 6th brightest galaxies (`bcgFrac5`)
            4. BCG's luminosity fraction compared to all the identified members (except the BCG) (`bcgFracA`)
            * **NOTE**: In all 5 bands, there are non-BCG galaxies with `P_CEN_1`

    * Organize the available IPython notebook, put under `notebook` folder
        - `redMapperRaDec.ipynb`: Make RA, DEC plot of redMapper clusters
        - `convolveMask.ipynb`: Test segmentation in SEP and convolve mask


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
  1. `redmapper` and `nonbcg` to W520:`/home/hs/astro2/hsc/master/`
  2. `redmapper` and `nonbcg` to MBP:`/Users/songhuang/astro3/hscs/`


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
## default rerun
batchForceSbp.py redBCG hsc_redmapper_cluster_1509.fits HSC-G \
    -i 'ID_CLUSTER' -r default --plmask \
    -mf HSC-I -rf HSC-I -rr default -rm 3
## largeR1 rerun
batchForceSbp.py redBCG hsc_redmapper_cluster_1509.fits HSC-G \
    -i 'ID_CLUSTER' -r largeR1 --plmask \
    -mf HSC-I -rf HSC-I -rr default -rm 3
## smallR1 rerun
batchForceSbp.py redBCG hsc_redmapper_cluster_1509.fits HSC-G \
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
batchSbp.py nonBCG massive_nonBCG_test_2.fits --id 'ISEDFIT_ID' \
    --plmask --step 0.1 -r default -f HSC-I
```

### Issues:

* The corrected SBP and CoG is still need to be tested
* Sometime `zscale` resacaling can fail, leave a black image on the output figure. (e.g. redBCG_15251) 
* The PA correction is still not perfect (e.g. redBCG_1053)
