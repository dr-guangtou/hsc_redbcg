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

### Improve batchPrep.py; batchSky.py; batchSbp.py

### Allow coaddCutoutSky.py, coaddCutoutSbp.py, and their batch-mode scripts to allow external masks

### Start with ds9Reg2Mask.py

### Organize coaddCutoutPrep.py
    - Clean up
    - Add segmentation map
    - Accept external region files

### Fix the direction of the image by add origin='lower'
