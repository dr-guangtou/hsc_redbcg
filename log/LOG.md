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
