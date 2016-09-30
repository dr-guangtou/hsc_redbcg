-- Search for bright extended objects in HSC DR1

SELECT

  -- Basic information 
  main.ra2000, main.decl2000, 
  main.gallon, main.gallat,
  main.tract, main.patch, main.id, main.parent, 
  
  -- Galactic extinction
  main.a_g, main.a_r, main.a_i, main.a_z, main.a_y, 
  
  -- Magnitude PSF
  main.gmag_psf, main.gmag_psf_err,
  main.rmag_psf, main.rmag_psf_err,
  main.imag_psf, main.imag_psf_err,
  main.zmag_psf, main.zmag_psf_err,
  main.ymag_psf, main.ymag_psf_err,

  -- Magnitude cModel
  main.gmag_cmodel, main.gmag_cmodel_err, 
  main.rmag_cmodel, main.rmag_cmodel_err, 
  main.imag_cmodel, main.imag_cmodel_err,  
  main.zmag_cmodel, main.zmag_cmodel_err, 
  main.ymag_cmodel, main.ymag_cmodel_err, 

  -- Flux cModel
  main.gflux_cmodel, main.gflux_cmodel_err,  
  main.rflux_cmodel, main.rflux_cmodel_err,   
  main.iflux_cmodel, main.iflux_cmodel_err, 
  main.zflux_cmodel, main.zflux_cmodel_err, 
  main.yflux_cmodel, main.yflux_cmodel_err,  
  
  -- Number of detections in each band 
  i_flag.countinputs                       AS if_countinputs,
  g_flag.countinputs                       AS gf_countinputs,
  r_flag.countinputs                       AS rf_countinputs,
  z_flag.countinputs                       AS zf_countinputs,
  y_flag.countinputs                       AS yf_countinputs,

  -- Flags in i-band  
  i_flag.flags_pixel_offimage              AS if_flags_pixel_offimage,
  i_flag.centroid_naive_flags    		   AS if_centroid_naive_flags, 
  i_flag.centroid_sdss_flags               AS if_centroid_sdss_flags,
  i_flag.shape_sdss_flags           	   AS if_shape_sdss_flags, 

  -- Bright object mask 
  i_flag.flags_pixel_bright_object_center  AS if_flags_pixel_bright_object_center,
  i_flag.flags_pixel_bright_object_any     AS if_flags_pixel_bright_object_any,
  g_flag.flags_pixel_bright_object_center  AS gf_flags_pixel_bright_object_center,
  g_flag.flags_pixel_bright_object_any     AS gf_flags_pixel_bright_object_any,
  r_flag.flags_pixel_bright_object_center  AS rf_flags_pixel_bright_object_center,
  r_flag.flags_pixel_bright_object_any     AS rf_flags_pixel_bright_object_any,
  z_flag.flags_pixel_bright_object_center  AS zf_flags_pixel_bright_object_center,
  z_flag.flags_pixel_bright_object_any     AS zf_flags_pixel_bright_object_any,
  y_flag.flags_pixel_bright_object_center  AS yf_flags_pixel_bright_object_center,
  y_flag.flags_pixel_bright_object_any     AS yf_flags_pixel_bright_object_any,
  
  -- Flags for cModel
  g_flag.cmodel_flux_flags       		   AS gf_cmodel_flux_flags, 
  r_flag.cmodel_flux_flags       		   AS rf_cmodel_flux_flags, 
  z_flag.cmodel_flux_flags       		   AS zf_cmodel_flux_flags, 
  y_flag.cmodel_flux_flags       		   AS yf_cmodel_flux_flags, 

  -- Flags for bad pixels
  g_flag.flags_pixel_bad                   AS gf_flags_pixel_bad,
  r_flag.flags_pixel_bad                   AS rf_flags_pixel_bad,
  i_flag.flags_pixel_bad                   AS if_flags_pixel_bad,
  z_flag.flags_pixel_bad                   AS zf_flags_pixel_bad, 				 
  y_flag.flags_pixel_bad                   AS yf_flags_pixel_bad, 				 

  -- Flags for clipped pixels
  g_flag.flags_pixel_clipped_any           AS gf_flags_pixel_clipped_any, 
  r_flag.flags_pixel_clipped_any           AS rf_flags_pixel_clipped_any, 
  i_flag.flags_pixel_clipped_any           AS if_flags_pixel_clipped_any, 
  z_flag.flags_pixel_clipped_any           AS zf_flags_pixel_clipped_any,    		  
  y_flag.flags_pixel_clipped_any           AS yf_flags_pixel_clipped_any,    		  

  -- Flags for bad central
  g_flag.centroid_sdss_flags     		   AS gf_centroid_sdss_flags, 
  r_flag.centroid_sdss_flags     		   AS rf_centroid_sdss_flags, 
  i_flag.centroid_sdss_flags     		   AS if_centroid_sdss_flags, 
  z_flag.centroid_sdss_flags     		   AS zf_centroid_sdss_flags, 
  y_flag.centroid_sdss_flags     		   AS yf_centroid_sdss_flags, 

  -- Edge pixels
  g_flag.flags_pixel_edge                  AS gf_flags_pixel_edge, 
  r_flag.flags_pixel_edge                  AS rf_flags_pixel_edge,  
  i_flag.flags_pixel_edge                  AS if_flags_pixel_edge,  
  z_flag.flags_pixel_edge                  AS zf_flags_pixel_edge,    			
  y_flag.flags_pixel_edge                  AS yf_flags_pixel_edge,    			

  -- Interpolated pixels
  g_flag.flags_pixel_interpolated_center   AS gf_flags_pixel_interpolated_center, 
  r_flag.flags_pixel_interpolated_center   AS rf_flags_pixel_interpolated_center,
  i_flag.flags_pixel_interpolated_center   AS if_flags_pixel_interpolated_center,
  z_flag.flags_pixel_interpolated_center   AS zf_flags_pixel_interpolated_center,
  y_flag.flags_pixel_interpolated_center   AS yf_flags_pixel_interpolated_center,

  -- Saturated pixels
  g_flag.flags_pixel_saturated_center      AS gf_flags_pixel_saturated_center,
  r_flag.flags_pixel_saturated_center      AS rf_flags_pixel_saturated_center,
  i_flag.flags_pixel_saturated_center      AS if_flags_pixel_saturated_center,
  z_flag.flags_pixel_saturated_center      AS zf_flags_pixel_saturated_center,
  y_flag.flags_pixel_saturated_center      AS yf_flags_pixel_saturated_center,

  -- CR pixels 
  g_flag.flags_pixel_cr_center             AS gf_flags_pixel_cr_center,
  r_flag.flags_pixel_cr_center             AS rf_flags_pixel_cr_center,
  i_flag.flags_pixel_cr_center             AS if_flags_pixel_cr_center,
  z_flag.flags_pixel_cr_center             AS zf_flags_pixel_cr_center,
  y_flag.flags_pixel_cr_center             AS yf_flags_pixel_cr_center,

  -- Suspicious pixels
  g_flag.flags_pixel_suspect_center        AS gf_flags_pixel_suspect_center,
  r_flag.flags_pixel_suspect_center        AS rf_flags_pixel_suspect_center,
  i_flag.flags_pixel_suspect_center        AS if_flags_pixel_suspect_center,
  z_flag.flags_pixel_suspect_center        AS zf_flags_pixel_suspect_center,
  y_flag.flags_pixel_suspect_center        AS yf_flags_pixel_suspect_center,
	
  -- Reference information 
  ref_list.countinputs              	   AS ir_countinputs, 
  ref_list.classification_extendedness     AS ir_classification_extendedness,
  ref_list.blendedness_abs_flux            AS ir_blendedness_abs_flux,

  -- Reference cModel shape and fracDev
  ref_list.cmodel_exp_ellipse   		   AS ir_cmodel_exp_ellipse,
  ref_list.cmodel_dev_ellipse   		   AS ir_cmodel_dev_ellipse,  
  ref_list.cmodel_fracdev                  AS ir_cmodel_fracdev, 
  ref_list.cmodel_objective                AS ir_cmodel_objective, 

  -- Reference flags
  ref_list.cmodel_flux_flags               AS ir_cmodel_flux_flags, 
  ref_list.shape_sdss_flags                AS ir_shape_sdss_flags, 

  -- Reference information about multi-band detections and measurements
  ref_list.merge_peak_g                    AS ir_merge_peak_g, 
  ref_list.merge_peak_r                    AS ir_merge_peak_r, 
  ref_list.merge_peak_i                    AS ir_merge_peak_i,         
  ref_list.merge_peak_z                    AS ir_merge_peak_z,  
  ref_list.merge_peak_y                    AS ir_merge_peak_y,  
  
  -- Reference flags about deblending process
  ref_list.deblend_masked                  AS ir_deblend_masked, 
  ref_list.deblend_parent_too_big          AS ir_deblend_parent_too_big, 
  ref_list.deblend_skipped                 AS ir_deblend_skipped, 
  ref_list.deblend_too_many_peaks          AS ir_deblend_too_many_peaks, 
  ref_list.deblend_deblended_as_psf        AS ir_deblend_as_psf

FROM
    s15b_wide.photoobj_mosaic__deepcoadd__merged         AS main      -- Summary of force photometry 
    JOIN 
        s15b_wide.mosaic_forceflag_i__deepcoadd__merged  AS i_flag    -- Flags for photometry in i-band 
        USING (id) 
    JOIN 
        s15b_wide.mosaic_forceflag_g__deepcoadd__merged  AS g_flag    -- Flags for photometry in g-band 
        USING (id) 
    JOIN 
        s15b_wide.mosaic_forceflag_r__deepcoadd__merged  AS r_flag    -- Flags for photometry in r-band 
        USING (id) 
    JOIN 
        s15b_wide.mosaic_forceflag_z__deepcoadd__merged  AS z_flag    -- Flags for photometry in z-band 
        USING (id) 
    JOIN 
        s15b_wide.mosaic_forceflag_y__deepcoadd__merged  AS y_flag    -- Flags for photometry in y-band 
        USING (id) 
    JOIN 
        s15b_wide.mosaic_reflist__deepcoadd              AS ref_list  -- Reference for force photometry
        USING (id)
     
WHERE

-- Flux and error
    main.imag_cmodel < 21.5								    	-- Magnitude cut using very simple photometry

-- Classification
AND ref_list.classification_extendedness > 0                    -- Extended objects 

-- Multiband detection
AND ref_list.detect_is_primary = True        					-- Primary detection 

-- Deblending 
AND ref_list.deblend_nchild = 0                 		    	-- Isolated or Not parent
