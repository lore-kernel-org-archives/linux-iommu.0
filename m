From: Sethi Varun-B16395 <B16395-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: RE: [PATCH 3/4 v5] iommu/fsl: Add iommu domain attributes required
	by fsl PAMU driver.
Date: Sun, 2 Dec 2012 08:12:31 +0000
Message-ID: <C5ECD7A89D1DC44195F34B25E172658D2B0419@039-SN2MPN1-013.039d.mgd.msft.net>
References: <1353419697-31269-1-git-send-email-Varun.Sethi@freescale.com>
	<1353419697-31269-4-git-send-email-Varun.Sethi@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: "joerg.roedel-5C7GfCeVMHo@public.gmane.org" <joerg.roedel-5C7GfCeVMHo@public.gmane.org>
Cc: Wood Scott-B07421 <B07421-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Tabi Timur-B04825 <B04825-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Ping!!

> -----Original Message-----
> From: Sethi Varun-B16395
> Sent: Monday, November 26, 2012 10:55 AM
> To: joerg.roedel-5C7GfCeVMHo@public.gmane.org
> Cc: Sethi Varun-B16395; iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org; linuxppc-
> dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org; linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; Wood Scott-B07421;
> Tabi Timur-B04825
> Subject: RE: [PATCH 3/4 v5] iommu/fsl: Add iommu domain attributes
> required by fsl PAMU driver.
> 
> Hi Joerg,
> Any comments? Can we apply this patch?
> 
> Regards
> Varun
> 
> > -----Original Message-----
> > From: Sethi Varun-B16395
> > Sent: Tuesday, November 20, 2012 7:25 PM
> > To: joerg.roedel-5C7GfCeVMHo@public.gmane.org; iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org; linuxppc-
> > dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org; linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; Wood Scott-B07421;
> > Tabi Timur-B04825
> > Cc: Sethi Varun-B16395
> > Subject: [PATCH 3/4 v5] iommu/fsl: Add iommu domain attributes
> > required by fsl PAMU driver.
> >
> > Added the following domain attributes required by FSL PAMU driver:
> > 1. Subwindows field added to the iommu domain geometry attribute.
> > 2. Added new iommu stash attribute, which allows setting of the
> >    LIODN specific stash id parameter through IOMMU API.
> > 3. Added an attribute for enabling/disabling DMA to a particular
> >    memory window.
> >
> > Signed-off-by: Varun Sethi <Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
> > ---
> > changes in v5:
> > - Updated description of the subwindows field.
> > changes in v4:
> > - Updated comment explaining subwindows(as mentioned by Scott).
> > change in v3:
> > -renamed the stash attribute targets
> >  include/linux/iommu.h |   43
> +++++++++++++++++++++++++++++++++++++++++++
> >  1 files changed, 43 insertions(+), 0 deletions(-)
> >
> > diff --git a/include/linux/iommu.h b/include/linux/iommu.h index
> > f3b99e1..7ca1cda 100644
> > --- a/include/linux/iommu.h
> > +++ b/include/linux/iommu.h
> > @@ -44,6 +44,41 @@ struct iommu_domain_geometry {
> >  	dma_addr_t aperture_start; /* First address that can be mapped */
> >  	dma_addr_t aperture_end;   /* Last address that can be mapped
> > */
> >  	bool force_aperture;       /* DMA only allowed in mappable range?
> > */
> > +
> > +	/*
> > +	 * A geometry mapping can be created in one of the following ways
> > +	 * for an IOMMU:
> > +	 * 1. A single contiguous window
> > +	 * 2. Through arbritary paging throughout the aperture.
> > +	 * 3. Using multiple subwindows
> > +	 *
> > +	 * In absence of arbritary paging, subwindows allow for supporting
> > +	 * physically discontiguous mappings.
> > +	 *
> > +	 * This attribute indicates number of DMA subwindows supported by
> > +	 * the geometry. If there is a single window that maps the entire
> > +	 * geometry, attribute must be set to "1". A value of "0" implies
> > +	 * that this mechanism is not used at all(normal paging is used).
> > +	 * Value other than* "0" or "1" indicates the actual number of
> > +	 * subwindows.
> > +	 */
> > +	u32 subwindows;
> > +};
> > +
> > +/* cache stash targets */
> > +#define IOMMU_ATTR_CACHE_L1 1
> > +#define IOMMU_ATTR_CACHE_L2 2
> > +#define IOMMU_ATTR_CACHE_L3 3
> > +
> > +/* This attribute corresponds to IOMMUs capable of generating
> > + * a stash transaction. A stash transaction is typically a
> > + * hardware initiated prefetch of data from memory to cache.
> > + * This attribute allows configuring stashig specific parameters
> > + * in the IOMMU hardware.
> > + */
> > +struct iommu_stash_attribute {
> > +	u32 	cpu;	/* cpu number */
> > +	u32 	cache;	/* cache to stash to: L1,L2,L3 */
> >  };
> >
> >  struct iommu_domain {
> > @@ -60,6 +95,14 @@ struct iommu_domain {  enum iommu_attr {
> >  	DOMAIN_ATTR_MAX,
> >  	DOMAIN_ATTR_GEOMETRY,
> > +	/* Set the IOMMU hardware stashing
> > +	 * parameters.
> > +	 */
> > +	DOMAIN_ATTR_STASH,
> > +	/* Explicity enable/disable DMA for a
> > +         * particular memory window.
> > +         */
> > +	DOMAIN_ATTR_ENABLE,
> >  };
> >
> >  #ifdef CONFIG_IOMMU_API
> > --
> > 1.7.4.1
