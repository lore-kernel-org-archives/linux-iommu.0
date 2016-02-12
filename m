From: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Subject: Re: [PATCH 4/3] iommu/io-pgtable: Rationalise quirk handling
Date: Fri, 12 Feb 2016 14:32:43 +0200
Message-ID: <4282853.vdxKI5JT5z@avalon>
References: <cover.1453723096.git.robin.murphy@arm.com>
	<ea1f3d3feec0dc9c18d43393678370b50b1275f5.1455206840.git.robin.murphy@arm.com>
	<20160212120857.GN25087@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20160212120857.GN25087-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Friday 12 February 2016 12:08:58 Will Deacon wrote:
> On Thu, Feb 11, 2016 at 04:13:45PM +0000, Robin Murphy wrote:
> > As the number of io-pgtable implementations grows beyond 1, it's time
> > to rationalise the quirks mechanism before things have a chance to
> > start getting really ugly and out-of-hand.
> > 
> > To that end:
> > - Indicate exactly which quirks each format can/does support.
> > - Fail creating a table if a caller wants unsupported quirks.
> > - Properly document where each quirk applies and why.
> > 
> > Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
> > ---
> > 
> >  drivers/iommu/io-pgtable-arm-v7s.c |  3 +++
> >  drivers/iommu/io-pgtable-arm.c     |  2 ++
> >  drivers/iommu/io-pgtable.c         |  3 +++
> >  drivers/iommu/io-pgtable.h         | 24 ++++++++++++++++++++----
> >  4 files changed, 28 insertions(+), 4 deletions(-)
> 
> Note that I can't merge this until we've figured out the plan for Yong's
> driver.
> 
> > diff --git a/drivers/iommu/io-pgtable-arm-v7s.c
> > b/drivers/iommu/io-pgtable-arm-v7s.c index d39a021..9bc607a 100644
> > --- a/drivers/iommu/io-pgtable-arm-v7s.c
> > +++ b/drivers/iommu/io-pgtable-arm-v7s.c
> > 
> > @@ -690,6 +690,9 @@ out_free_data:
> >  struct io_pgtable_init_fns io_pgtable_arm_v7s_init_fns = {
> >  
> >  	.alloc	= arm_v7s_alloc_pgtable,
> >  	.free	= arm_v7s_free_pgtable,
> > 
> > +	.supported_quirks = IO_PGTABLE_QUIRK_ARM_NS |
> > +			    IO_PGTABLE_QUIRK_NO_PERMS |
> > +			    IO_PGTABLE_QUIRK_TLBI_ON_MAP,
> > 
> >  };
> >  
> >  #ifdef CONFIG_IOMMU_IO_PGTABLE_ARMV7S_SELFTEST
> > 
> > diff --git a/drivers/iommu/io-pgtable-arm.c
> > b/drivers/iommu/io-pgtable-arm.c index 4095af2..32f94f1 100644
> > --- a/drivers/iommu/io-pgtable-arm.c
> > +++ b/drivers/iommu/io-pgtable-arm.c
> > @@ -863,6 +863,7 @@ arm_32_lpae_alloc_pgtable_s2(struct io_pgtable_cfg
> > *cfg, void *cookie)> 
> >  struct io_pgtable_init_fns io_pgtable_arm_64_lpae_s1_init_fns = {
> >  
> >  	.alloc	= arm_64_lpae_alloc_pgtable_s1,
> >  	.free	= arm_lpae_free_pgtable,
> > 
> > +	.supported_quirks = IO_PGTABLE_QUIRK_ARM_NS,
> > 
> >  };
> >  
> >  struct io_pgtable_init_fns io_pgtable_arm_64_lpae_s2_init_fns = {
> > 
> > @@ -873,6 +874,7 @@ struct io_pgtable_init_fns
> > io_pgtable_arm_64_lpae_s2_init_fns = {> 
> >  struct io_pgtable_init_fns io_pgtable_arm_32_lpae_s1_init_fns = {
> >  
> >  	.alloc	= arm_32_lpae_alloc_pgtable_s1,
> >  	.free	= arm_lpae_free_pgtable,
> > 
> > +	.supported_quirks = IO_PGTABLE_QUIRK_ARM_NS,
> > 
> >  };
> >  
> >  struct io_pgtable_init_fns io_pgtable_arm_32_lpae_s2_init_fns = {
> > 
> > diff --git a/drivers/iommu/io-pgtable.c b/drivers/iommu/io-pgtable.c
> > index 876f6a7..0f57a45 100644
> > --- a/drivers/iommu/io-pgtable.c
> > +++ b/drivers/iommu/io-pgtable.c
> > @@ -52,6 +52,9 @@ struct io_pgtable_ops *alloc_io_pgtable_ops(enum
> > io_pgtable_fmt fmt,> 
> >  	if (!fns)
> >  	
> >  		return NULL;
> > 
> > +	if (cfg->quirks & ~fns->supported_quirks)
> > +		return NULL;
> > +
> > 
> >  	iop = fns->alloc(cfg, cookie);
> >  	if (!iop)
> >  	
> >  		return NULL;
> > 
> > diff --git a/drivers/iommu/io-pgtable.h b/drivers/iommu/io-pgtable.h
> > index 4faee7d..6e7f11e 100644
> > --- a/drivers/iommu/io-pgtable.h
> > +++ b/drivers/iommu/io-pgtable.h
> > @@ -47,10 +47,24 @@ struct iommu_gather_ops {
> > 
> >   *                 page table walker.
> >   */
> >  
> >  struct io_pgtable_cfg {
> > 
> > -	#define IO_PGTABLE_QUIRK_ARM_NS		BIT(0) /* Set NS bit in PTEs */
> > -	#define IO_PGTABLE_QUIRK_NO_PERMS	BIT(1) /* No AP/XN bits */
> > -	#define IO_PGTABLE_QUIRK_TLBI_ON_MAP	BIT(2) /* TLB Inv. on map */
> > -	int				quirks;
> > +	/*
> > +	 * IO_PGTABLE_QUIRK_ARM_NS: (ARM formats) Set NS and NSTABLE bits in
> > +	 *	stage 1 PTEs, for hardware which insists on validating them
> > +	 *	even in	non-secure state where they should normally be ignored.
> > +	 *
> > +	 * IO_PGTABLE_QUIRK_NO_PERMS: Ignore the IOMMU_READ, IOMMU_WRITE and
> > +	 *	IOMMU_NOEXEC flags and map everything with full access, for
> > +	 *	hardware which does not implement the permissions of a given
> > +	 *	format, and/or requires some format-specific default value.
> > +	 *
> > +	 * IO_PGTABLE_QUIRK_TLBI_ON_MAP: If the format forbids caching 
invalid
> > +	 *	(unmapped) entries but the hardware might do so anyway, perform
> > +	 *	TLB maintenance when mapping as well as when unmapping.
> > +	 */
> 
> Much better, cheers.
> 
> > +	#define IO_PGTABLE_QUIRK_ARM_NS		BIT(0)
> > +	#define IO_PGTABLE_QUIRK_NO_PERMS	BIT(1)
> > +	#define IO_PGTABLE_QUIRK_TLBI_ON_MAP	BIT(2)
> > +	unsigned int			quirks;
> 
> Let's just make this unsigned long.
> 
> >  	unsigned long			pgsize_bitmap;
> >  	unsigned int			ias;
> >  	unsigned int			oas;
> > 
> > @@ -173,10 +187,12 @@ static inline void io_pgtable_tlb_sync(struct
> > io_pgtable *iop)
> >   *
> >   * @alloc: Allocate a set of page tables described by cfg.
> >   * @free:  Free the page tables associated with iop.
> > + * @supported_quirks: Bitmap of quirks supported by the format.
> >   */
> >  struct io_pgtable_init_fns {
> >  	struct io_pgtable *(*alloc)(struct io_pgtable_cfg *cfg, void 
*cookie);
> >  	void (*free)(struct io_pgtable *iop);
> > +	unsigned int supported_quirks;
> >  };
> 
> My only gripe here is that this is supposed to be a struct of function
> pointers... get_supported_quirks() ?

Can't we instead say it's a struct of function pointers and static data ? :-) 
A function to retrieve the supported quirks will just contribute to kernel 
bloat without adding any extra benefit.

-- 
Regards,

Laurent Pinchart
