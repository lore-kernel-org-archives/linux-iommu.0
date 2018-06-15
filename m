From: Jordan Crouse <jcrouse-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: Re: [PATCH 1/1] iommu/arm-smmu: Add support to use Last level cache
Date: Fri, 15 Jun 2018 11:12:09 -0600
Message-ID: <20180615171208.GN11565@jcrouse-lnx.qualcomm.com>
References: <20180615105329.26800-1-vivek.gautam@codeaurora.org>
	<20180615165232.GE2202@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20180615165232.GE2202-5wv7dgnIgG8@public.gmane.org>
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
Cc: pdaly-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Fri, Jun 15, 2018 at 05:52:32PM +0100, Will Deacon wrote:
> Hi Vivek,
> 
> On Fri, Jun 15, 2018 at 04:23:29PM +0530, Vivek Gautam wrote:
> > Qualcomm SoCs have an additional level of cache called as
> > System cache or Last level cache[1]. This cache sits right
> > before the DDR, and is tightly coupled with the memory
> > controller.
> > The cache is available to all the clients present in the
> > SoC system. The clients request their slices from this system
> > cache, make it active, and can then start using it. For these
> > clients with smmu, to start using the system cache for
> > dma buffers and related page tables [2], few of the memory
> > attributes need to be set accordingly.
> > This change makes the related memory Outer-Shareable, and
> > updates the MAIR with necessary protection.
> > 
> > The MAIR attribute requirements are:
> >     Inner Cacheablity = 0
> >     Outer Cacheablity = 1, Write-Back Write Allocate
> >     Outer Shareablity = 1
> 
> Hmm, so is this cache coherent with the CPU or not? Why don't normal
> non-cacheable mappings allocated in the LLC by default?
> 
> > diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> > index f7a96bcf94a6..8058e7205034 100644
> > --- a/drivers/iommu/arm-smmu.c
> > +++ b/drivers/iommu/arm-smmu.c
> > @@ -249,6 +249,7 @@ struct arm_smmu_domain {
> >  	struct mutex			init_mutex; /* Protects smmu pointer */
> >  	spinlock_t			cb_lock; /* Serialises ATS1* ops and TLB syncs */
> >  	struct iommu_domain		domain;
> > +	bool				has_sys_cache;
> >  };
> >  
> >  struct arm_smmu_option_prop {
> > @@ -862,6 +863,8 @@ static int arm_smmu_init_domain_context(struct iommu_domain *domain,
> >  
> >  	if (smmu->features & ARM_SMMU_FEAT_COHERENT_WALK)
> >  		pgtbl_cfg.quirks = IO_PGTABLE_QUIRK_NO_DMA;
> > +	if (smmu_domain->has_sys_cache)
> > +		pgtbl_cfg.quirks |= IO_PGTABLE_QUIRK_SYS_CACHE;
> >  
> >  	smmu_domain->smmu = smmu;
> >  	pgtbl_ops = alloc_io_pgtable_ops(fmt, &pgtbl_cfg, smmu_domain);
> > @@ -1477,6 +1480,9 @@ static int arm_smmu_domain_get_attr(struct iommu_domain *domain,
> >  	case DOMAIN_ATTR_NESTING:
> >  		*(int *)data = (smmu_domain->stage == ARM_SMMU_DOMAIN_NESTED);
> >  		return 0;
> > +	case DOMAIN_ATTR_USE_SYS_CACHE:
> > +		*((int *)data) = smmu_domain->has_sys_cache;
> > +		return 0;
> 
> I really don't like exposing this to clients directly like this,
> particularly as there aren't any in-tree users. I would prefer that we
> provide a way for the io-pgtable code to have its MAIR values overridden
> so that all non-coherent DMA ends up using the system cache.

FWIW here is a future in-tree user for LLC:

https://patchwork.freedesktop.org/series/40545/

Specifically:

https://patchwork.freedesktop.org/patch/212400/

Jordan

-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
