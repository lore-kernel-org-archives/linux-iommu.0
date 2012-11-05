From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 3/4 v4] iommu/fsl: Add iommu domain attributes required
 by fsl PAMU driver.
Date: Mon, 5 Nov 2012 16:21:14 -0600
Message-ID: <1352154074.28279.9@snotra>
References: <50983966.4080805@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; delsp=Yes; format=Flowed
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <50983966.4080805@freescale.com> (from timur@freescale.com on
	Mon Nov  5 16:10:46 2012)
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Timur Tabi <timur@freescale.com>
Cc: Varun Sethi <Varun.Sethi@freescale.com>, joerg.roedel@amd.com, iommu@lists.linux-foundation.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On 11/05/2012 04:10:46 PM, Timur Tabi wrote:
> Varun Sethi wrote:
> > Added the following domain attributes required by FSL PAMU driver:
> > 1. Subwindows field added to the iommu domain geometry attribute.
> > 2. Added new iommu stash attribute, which allows setting of the
> >    LIODN specific stash id parameter through IOMMU API.
> > 3. Added an attribute for enabling/disabling DMA to a particular
> >    memory window.
> >
> >
> > Signed-off-by: Varun Sethi <Varun.Sethi@freescale.com>
> > ---
> > changes in v4:
> > - Updated comment explaining subwindows(as mentioned by Scott).
> > change in v3:
> > -renamed the stash attribute targets
> >  include/linux/iommu.h |   36 ++++++++++++++++++++++++++++++++++++
> >  1 files changed, 36 insertions(+), 0 deletions(-)
> >
> > diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> > index f3b99e1..e72f5e5 100644
> > --- a/include/linux/iommu.h
> > +++ b/include/linux/iommu.h
> > @@ -44,6 +44,34 @@ struct iommu_domain_geometry {
> >  	dma_addr_t aperture_start; /* First address that can be  
> mapped    */
> >  	dma_addr_t aperture_end;   /* Last address that can be  
> mapped     */
> >  	bool force_aperture;       /* DMA only allowed in mappable  
> range? */
> > +
> > +	/**
> 
> /** is used by kerneldoc to indicate a kerneldoc-style comment.   
> Normal
> comments should start with just "/*".
> 
> > +	 * There could be a single contiguous window tha maps the entire
> > +	 * geometry or it could be split in to multiple subwindows.
> > +	 * Subwindows allow for supporting physically discontiguous  
> mappings.
> > +	 * This attribute indicates number of DMA subwindows supported  
> by
> > +	 * the geometry. If there is a single window that maps the  
> entire
> > +	 * geometry, attribute must be set to "1". A value of "0"  
> implies
> > +	 * that there are 256 subwindows each of size 4K. Value other  
> than
> > +	 * "0" or "1" indicates the actual number of subwindows.
> > +	 */
> > +	u32 subwindows;
> 
> Why is this a sized integer?

The whole struct should be fixed size integers, if we're going to  
eventually expose this via VFIO.

> > +/* cache stash targets */
> > +#define IOMMU_ATTR_CACHE_L1 1
> > +#define IOMMU_ATTR_CACHE_L2 2
> > +#define IOMMU_ATTR_CACHE_L3 3
> 
> This seems kinda silly.  The value of the enum is in the enum name.

There might be less obvious members of this enum in the future -- this  
is a generic API and should make as few assumptions about the hardware  
as possible.

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
> > @@ -60,6 +88,14 @@ struct iommu_domain {
> >  enum iommu_attr {
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

Whitespace and comment style.

-Scott
