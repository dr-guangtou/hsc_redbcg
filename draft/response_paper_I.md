# Response to Referee Report for Paper I 

We thank the referee for the careful reading and detailed comments.  We have re-organized the draft by following most of the referee's suggestions.  The modified parts of the new text are highlighted in cyan color.  Before we will address the referee's each suggestion in details, we now specifically address the main issues raised by the referee: 

1. We share the referee's concern that the current paper is quite long and technical.  Following the referee's suggestions, we have shorten the introduction, remove some redundant technical details, and move others to the appendix. Hopefully, the referee would agree that it is easier to access the main results in the current version.  Meanwhile, we also decide to keep some details in the text (will explain in details later).  As the first paper of this series, it will serve as a technical reference for the following ones.  Since we are looking into the very low surface brightness outskirts of massive galaxies, several of these technical details become very important. We think it is responsible to the readers to keep certain level of technical details in the main text.

2. We agree with the referee that it would be much more straightforward to only use the $M_{100 \mathrm{kpc}}$ in the paper.  We do believe that it is a better proxy of "total" stellar mass for massive galaxies, and we do intend to do so in the following papers (one has been submitted and received very positive referee report).  Following the referee's suggestion, we adjust the relevant text accordingly.  However, we would also like to point out that the comparison with CModel stellar mass is one of the **main results** of this work, and we think it deserves to be kept in the main text.  Here are the details reasons: 
	- Ever since it has been adopted by the SDSS survey, CModel photometry has been widely used in numerous studies related to galaxy evolution.  For example, many of the published luminosity and stellar mass functions are based on this photometry.  Since it can take the PSF convolution into account and fit galaxy with a wide range of profiles, it has been considered a better choice for galaxy photometry than simple aperture photometry in the age of multi-band imaging surveys.  And due to its efficiency and flexibility, similar or improved version of CModel are being used in new imaging surveys (e.g. HSC, DES), and will be adopted by future deep surveys too (e.g. LSST).  Therefore, it is important to point out its limitation and remind the users of these survey data to be careful when it comes to the study of galaxy at high-mass end. 
	- The problem with CModel photometry has been pointed out and carefully studied by the group led by Mariangela Bernardi, and has led to many publications (e.g. Bernardi et al. 2013, 2014, 2016, 2017a, 2017b).  Using better reduced SDSS images and more complex models, these authors argue that the CModel photometry tends to miss large fraction of light in massive galaxies.  These works are very well received and have been discussed under many different contexts.  Since these results are still based on shallow SDSS images, their conclusion is still being questioned (e.g. d'Souza et al. 2014).  Our results addressed the same issue.  But with the help of much deeper image and model-independent method, now we can confirm that CModel photometry indeed misses the light in the outskirt of massive galaxies in a mass-dependent (and environment-dependent) fashion.  Although technical, we think it is an important result of this work.  
	
We sincerely wish that the referee could understand our intention. 
We understand that it increases the length of the text and makes the paper more "technical", but we seriously think it is necessary and useful to do so for the benefits of not only our future works, but any people who will use CModel to study topics about massive galaxies.
 
------

## Major revisions 

### Abstract:

> Reduce it. It resembles a "short introduction", saying why it is important to study stellar halos, rather than pointing out the main methods and results of the work.

We have re-organize the abstract to make it emphasizes the main results more.  The length of the abstract has also been slightly reduced. 

### Introduction:


>This section is too long. I would suggest to reduce the first 3 paragraphs in few sentences (including references) and starting from “Both numerical simulation....” and to review the up-to-date science on stellar halos.

The referee is right that the first part of the Introduction was unnecessarily long.  We have significantly shortened the first three paragraphs according to the referee's suggestion. 

>First paragraph on pag.3 is a repetition of what is already written in sec.2.1

We removed the redundant details of the HSC survey, and refer the reader to Section 2.1 for details. 

### Sec 2.2:

> Can the authors explain how the error estimates on the surface brightnesses are derived? Which are the sources that contributes to them? How much is the uncertainty on the sky background?

The uncertainties of the surface brightness profiles are based on the error in isophotal intensity derived by the ```Ellipse``` procedure and the global RMS of the background estimates.  ```Ellipse``` measures the RMS of intensities along each isophote.  This is affected by the intrinsic S/N and the contaminations of fluxes that are from other sources.  We have tested the ```Ellipse``` step size (which influences the S/N at different radius), masks for other objects and sigma-clipping methods during profile extraction (which affects the contaminations from other objects), and come up with an optimized approach.  We also perform our own background estimate after aggressively masking out all objects and rebin the rest of the pixels.  It provides us the RMS of the global background fluctuation.  We did not include the **systematic uncertainties** from background subtraction as it is difficult to estimate at the coadd level for HSC images.  But we empirically correct the large scale background to account for over-subtraction due to nearby bright object and to make sure the intensity profile does not go negative at large radius.  More importantly, we perform tests to show that profiles within 100 kpc are not affected by systematics in background subtraction. 

We add more details about the uncertainties of surface brightness profiles to Appendix B and Section 3 to reflect the referee's question. 

### Sec 3: 

>This section contains a lot of repetitions.
- In the 2nd and 4th paragraphs on page 6, ``We choose the i-band...’’, ``We correct these surface brightness...’’ , are mentioned at least twice in the same section.

We have adjust these paragraphs and remove the repeated parts according to the referee's suggestion.

>The 6th paragraph, starting with ``We cannot extract reliable 1-D profiles....’’ is useless,   since you do not use them in the work.

This is relevant to the completeness of the sample and affects the comparisons of the stellar mass functions at high-mass end later.  Based on the referee's suggestion, we now only briefly mention that ~10% of sample are excluded due to contamination, and move the detailed discussion to Appendix B.

> In this section I would suggest to mention how and why you derive also Mtot, moving here part of the discussion made later in 6.1. This is an important point, since, as you explain, M100kpc is a lower limit for the brightest objects. This is an assumption you make, that is ok, but take in mind that the limiting radius of the surface photometry is the galactocentric distance where the galaxy light blends into the background level (see Polhen & Truijllo 2006). Your Mtot is something similar to this limit, so this estimate is really important, more than that derived with the cModel

We agree with the referee that the background level is important when it comes to estimate the stellar mass and mass density profiles out to very large radius.  The work recommended by the referee has now been cited in our discussion.  As we explain in details in the Appendix B, although the radius we are reaching to is far below the brightness of sky background, we have done a series of tests to make sure that the mass density profiles are robust out to 100 kpc.  Although at this radius, we are still above the limitation of the intrinsic fluctuation of the background, the accuracy of the profile is limited by the systematics in background subtraction and contaminations from the fain outskirts of other objects, we make a conservative choice to only use the reliable part within the inner 100 kpc.

> I would suggest to put in a new section the description of the mass estimates: M(<10kpc), M(<100kpc) and also M*tot

We agree with the referee that the definitions of different stellar masses should be presented in a very clear way.  Inspired by the referee's suggestion, we now merge the last part of Section 3 and Section 4.2 together, and present these definitions in a few bullet points.  Although we still keep Section 4.2, it has been shortened.

###  Sec 4 :

> This section should be reduced to a short paragraph.
> The description of the iSEDfit in the 2nd paragraph should be removed, it is necessary the reference to the code

Based on the referee's suggestion, we now only keep the minimum necessary introduction of ```iSEDFit``` in the main text and move the description to Appendix C.  As there are many different approaches for SED fitting, we still keep brief introduction of ```iSEDFit``` in the Appendix for readers who care about these details. 

We also adjust most text in Section 4.1 to make it more concise. 

> Remove Sec.4.2: authors can shortly say that they assume a constant M/L, which is reasonably for ETGs, providing references

Since we are comparing mass density profiles out to 100 kpc, we think that the assumption of average M/L should be emphasized as a caveat and examined later using our own color profiles.  But we agree with the referee that this is a reasonable assumption for massive ETGs.  Now move the detailed discussion to Appendix C and point the reader there and to the section about color gradient later. 

> Again, remove all comparison and discussion with quantities derived by the cModel, since you do not use them in the final results and discussion

As we explained in the beginning, we sincerely consider the comparison with CModel stellar mass and stellar mass function is the key result of this work.  Not only it clearly demonstrate the advantages of our methods, it also confirms the **intrinsic limitation** of the CModel photometry as it cannot account for the very extended, low surface brightness outskirts of massive galaxies.  This issue **affects many important topics around massive galaxies** (e.g. Evolution of SMF at high mass end; Environmental dependence of galaxy structure; Comparisons between observation and simulations etc.), and **should be taken into serious account as CModel is still a widely adopted photometric method** (including users of HSC data).  In addition, this comparison also serves as important technical reference for our future works. 

Based on these reasons, we strongly propose to keep the comparison with CModel in this work.  We will modify the text to make the main message clear and make the text shorter.  We understand that this will make the paper appears to be more "technical", however we seriously consider it as necessary cost for this work.

> Sec 4.3 could be an appendix. 

Given that we do want to keep the comparisons with CModel SMF, it is useful to discuss the completeness of the sample in advance.  Also, generally speaking, it is important to understand the completeness of the sample before diving into any scientific comparisons within the sample. In addition, this also serves as an important technical reference for our following works.  

Since that Section 4.3 is already a quite short section, we propose to keep it in the main text after shortening it further. 


  
###  Sec 5 :

>As for Sec.4, this section should be reduced to a short paragraph, I would suggest the summary in sec.5.2. The description of the adopted method (redMaPPer) can be moved to the appendix.

We agree with the referee that the first part of Section 5 can be significantly shortened.  
However, as we explained above, 1) The comparison of stellar mass functions and their halo mass dependence is considered as an important result.  Therefore we still want to describe how we separate the sample into two broad halo mass bins here. 2) Such description also serves as the technical reference for the following works that have been submitted.  We rewrite Section 5.1 and make it more concise, while keeping the brief summary in Section 5.2.

### Sec 6 :
> This section should start from sec.6.2 and focusing on the description of Fig.6 and Fig.7, which are the "core" of this work. In detail:
> remove the comparison and discussion of quantities derived from the cModel,so all text up to the beginning of page 6.

As mentioned several times earlier, we sincerely think the comparisons with CModel is a main result of this work.  

We adjust the text in Section 6.1 to make it shorter and more clear.s

> the 1st paragraph on page 6, "As discussed in ..." is really important, but the content should be moved in Sec3, as I suggested above

We think the referee means the 1st paragraph on Page 11.  We agree with the referee that it is better to keep this important discussion together.  Right now, we have merge all the relevant discussion to Section 4.2. 

> The descriptions of the SMF for SDSS-GALEX galaxies and for the Bernardi et al.sample (bullets points on page 11) are useless, references are enough. 

For the comparisons of the SMF, it is crucial to point out the basic photometric method and key assumptions in stellar population modeling.  We think that put these information here could save the reader time to find them in the citations.  

Under the referee's suggestion, we shorten the descriptions for these two bullet points, but keep the key information and put a few details in footnotes.  

> The last paragraph, where you describe the Fig.5, should be moved in Sec.5, where you  describe the sample and, therefore, how it compares with literature data. 

Again, this relates to the strategy about the comparisons with CModel.  We think Figure 5 should stay in this section as it is part of the main results.  The left panel illustrates the differences between our aperture masses and the CModel masses. More importantly, it shows that the difference is apparently more significant for the central galaxies in very massive halos due to their extended stellar halos.  The right panel of Figure 5 not just compares our SMF with literatures, but demonstrate our main point here again: when it comes to the SMF at high-mass end, the photometric method used in stellar mass measurement really matters, and should be carefully taken into account before discussing any physical evolution.  

Again, we hope that the referee could understand our intention, and agree that we can keep Figure 5 in Section 6.1 as part of the results.

### Sec 6.2.1: 

> the last paragraph, "Deep μ* profiles..." is a review on previous works, move it in the Introduction and here cite that section. In this section you should focus on the description of your results.

The referee is right that this sentence belongs to the Introduction section.  We moved it and merged it into the relevant part of the introduction.

> page12: "CGS images are deeper..." , this is a repetition

We think this is the first time we mention this information.  It is about the comparison between CGS and SDSS, and with HSC.  However, since this is not an important information, we remove it any way based on the referee's point.

> page12: "In future work, we will compare..." , this is not useful for the reader at this point, if you like, you could mention this at the end of the paper

We agree with the referee and this sentence has been removed. We do mention this plan at the end of the paper. 

### Sec 6.3: 

> remove 1st paragraph, this is a repetition. Start with "We also apply..."

Based on the referee's suggestion, we modify the beginning of this section and makes it shorter. 

> 2nd paragraph: "The ellipticity of the isophote.." is an information not needed here, you are describing your results

We delete this sentence here according to the referee's point.  We move it to the introduction section as we think it is still useful to remind the reader that the ellipticity profile contains many useful information.

> May you comment a comparison of the ellipticity and P.A. profiles with those derived by Spavone et al. 2017 for a sample of few ETGs in local universe? They found a similar
trend

We agree with the referee that Spavone et al. 2017 also finds a similar trend using a smaller sample of nearby massive galaxies.  We now cited this work in the introduction section and in the discussion about the ellipticity profile. 

> 1st paragraph in the second column: "If accreted stars...", again, this is an information not needed here, it should be moved in the introduction or used in the discussion of the results. Here you are describing them.

The referee is right that this part belongs to the introduction.  We now removed this part and merged it with the relevant text in the Introduction section.

> 2nd paragraph in the second column: "Regarding the color profiles...", this is a repetition, please, delete this sentence

What we meant to say is that we see smooth, negative color gradients as shown in many previous observations and predicted by some simulations. Based on the referee's suggestion, we remove this sentence but incorporate the references here into the presentation of our results.

> Can authors provide an error estimate on the color profiles? usually this increases with radius and with fainter surface brightnesses

The referee is correct that the statistical error of color profile increases quickly with radius.  And, in the outskirts, it is also very sensitive to even a small systematical difference in background subtraction or contaminations from nearby objects.  
We estimate the error by combining the uncertainties of surface brightness from both bands, but as you can see from the figure, the scatters of color profiles in the outskirts are very large and often show unphysical upward or downward turns.  The main reasons are 1) the g-band images are shallower and more noisy, 2) the backgrounds in two bands have not been jointly constrained yet.  Since the comparisons of color gradients are mainly to show that the average color gradients are shallow and do not strongly depend on stellar mass, so that our assumption of single M/L is reasonable here, we only use the average color profiles. More careful investigation of color profile is beyond the scope of this work, and to explore the individual color information in the stellar halo, we think it is necessary to perform multi-band image fitting in the following work. 

In line of the referee's question, we add a few lines of discussion about this in the relevant part of the result. 

### Sec 7.2 :
> The 1st paragraph is a repetition of some material reviewed in the introduction, shorten it and cite the sec.1

Following the referee's suggestion, the first part of Section 7.2 has been shortened.

> Have you looked at the new Illustris simulations, derived with the new TNG code? Thay appeared on astro-ph past week, see Pillepich et al. 2017 (2017arXiv170703406P) and Genel et al. 2017 (2017arXiv170705327G). The new code improve some limits on the mass estimates given in the former simulations. 

The referee is right that the new Illustris-TNG simulation suppose to solve several issues in the original Illustris one, and is very interested to look into.  The results from Illustris-TNG simulation are still not available to the public during the preparation of this work, although the relation with ex-situ fraction does not seem to change much.  We are discussing with members of Illustris-TNG collaboration about careful comparison.  We'd like to mention that in Pillepich+2017, the authors also discuss the stellar masses estimated using different methods and within different apertures, and how they affect the comparisons of stellar mass function with observation.  We feel that it makes more sense to highlight our observational results about this in the main text.  

Both paper suggested by the referee are now cited and discussed in this work. 

> may you also comment about the mass fraction of the accreted stars compared with simulations and other observations? See also Gonzalez et al. 2007 and again Spavone et al 2017

We thank the referee for suggesting the relevant works, both of them have already been cited in this paper.  In Gonzalez et al. 2005, 2007, the authors use 2-D 2-component fitting method to photometrically isolate the ICL component.  In Spavone et al. 2017, the authors also photometrical decompose the light profiles of a small samples into a few components, and use the fraction of the outer component as proxy of the fraction of accreted stars.  Both are very interesting approaches.  The author of this work also tries the similar approach (Huang et al. 2013a, 2013b).  However, this approach also faces challenges:
	1. It is not clear whether Sersic profile is appropriate to describe the physical in-situ and ex-situ component. 
	2. The decomposition and modeling are sensitive to the background subtraction (as the outer component often extends to very large radius) and internal degeneracies of model parameters.  

Still, we are very interested in performing similar decomposition method to our galaxies and compare the results from aperture masses. It is interesting to see that the Spavone et al. 2017 results show higher fraction of accreted stars than ours.  It could be caused by the fraction of mass outside 100 kpc, or could reflect the fact that a significant of mass within 10 kpc is actually accreted (as we try to show in Figure 8b).  We now briefly discuss these points at the end of this section.

> last paragraphs on page 16 (1st column): ``How well justified is our choice...’’, you have already mentioned at this! please, merge all the content in Sec.3 and discuss the similarity with BCGs (last paragraph) in Sec.6

We would like to clarify the purpose of this paragraph.  In Section 3, we simply assume that $M_{10\mathrm{kpc}}$ could be used as proxy of the in-situ mass.  And we want to carefully discuss this choice in this section.  The last paragraph and Figure 8b is meant to show that **although the inner 10 kpc could be indeed dominated by in-situ stars, there are still some uncertainties**.  As mentioned above, the comparisons of profiles show that a fraction of mass within 10 kpc could also come from accretion.  The comparison with the unique z~1 "BCG" is to highlight that massive galaxies may already have a significant fraction of accreted mass.

We think this is more like a discussion of caveat. Therefore, we propose to keep this figure and the discussion here with some modification and additional discussion. 

### Sec 8:
> The 1st point in the list (i),should be removed. The comparison with the cModel is not a result and, as I suggested above, it should not be so widely discussed in the paper.

As we explained above, we do think that the comparison of stellar mass using CModel photometry is a key results of this work.  The differences at the high mass end are significant enough so that many recent results using CModel photometry on the topics of massive galaxies could be affected.  Therefore, we think it is appropriate to remind the reader about this in the summary. 

We do understand the referee's concern that this is a more technical point. We adjust the order of the bullet points, and put this one at the end.  

> your paper focused on the surface density profiles (point ii), about their shape and how they compare with simulations and observations, and on the colors of the stellar
envelope (new point). I would also add, among your results, the estimate of the total accreted mass

As we explained earlier, the measurements of color gradients are still not as reliable as the mass density profiles, and can not reach to the same 100 kpc.  That's why we are hesitate to list it as a separated main result.  Based on the referee's suggestion, we modify it a little and now put it in a separate bullet point. 

We also add a new bullet point to summarize our results on using the aperture masses to trace the in-situ and ex-situ components. 

----- 

## Figures: 

> Fig.1: delate the last sentence, this is not a description of the figure.```

It has been removed based on the referee's suggestion.

> Remove Fig.3 and left panel of Fig 5:See the above comments on avoiding discussion on the cModel.

As we have been explained multiple times above, in our opinion, the comparisons with CModel are not only a crucial technical point, but also the key result of this paper.  We propose to keep these two figures and most of the relevant text. 

> Left panel of Fig.8 is a COPY of Fig.6, please, merge them

As we explained above, the right panel of Figure 8 serves a different purpose in the discussion section compared to Figure 6.  Also, merging these two figures will make it very busy and hard to see the comparisons in the inner region.  Therefore, we think it should be Ok to keep the right panel of Figure 8 as is. 

