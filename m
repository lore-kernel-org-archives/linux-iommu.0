From: Linu Cherian <linu.cherian-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>
Subject: Re: [v4 3/4] iommu/arm-smmu-v3: Add workaround for Cavium ThunderX2
	erratum #74
Date: Wed, 10 May 2017 11:01:05 +0530
Message-ID: <20170510053105.GA7576@virtx40>
References: <1494330314-30179-1-git-send-email-gakula@caviumnetworks.com>
	<1494330314-30179-4-git-send-email-gakula@caviumnetworks.com>
	<bd0b9567-ccc5-8bf2-b113-d0f7a1ab2ed2@arm.com>
	<20170509134856.GA1090@virtx40>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170509134856.GA1090@virtx40>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, catalin.marinas-5wv7dgnIgG8@public.gmane.org, Geetha Sowjanya <geethasowjanya.akula-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>, jcm-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, Geetha sowjanya <gakula-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>, will.deacon-5wv7dgnIgG8@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, geethasowjanya.akula-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, sudeep.holla-5wv7dgnIgG8@public.gmane.org, sgoutham-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org, robert.richter-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org, Charles.Garcia-Tobin-5wv7dgnIgG8@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

> On Tue May 09, 2017 at 02:02:58PM +0100, Robin Murphy wrote:
> > On 09/05/17 12:45, Geetha sowjanya wrote:
> > > From: Linu Cherian <linu.cherian-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>
> > > 
> > > Cavium ThunderX2 SMMU implementation doesn't support page 1 register space
> > > and PAGE0_REGS_ONLY option is enabled as an errata workaround.
> > > This option when turned on, replaces all page 1 offsets used for
> > > EVTQ_PROD/CONS, PRIQ_PROD/CONS register access with page 0 offsets.
> > > 
> > > SMMU resource size checks are now based on SMMU option PAGE0_REGS_ONLY,
> > > since resource size can be either 64k/128k.
> > > For this, arm_smmu_device_dt_probe/acpi_probe has been moved before
> > > platform_get_resource call, so that SMMU options are set beforehand.
> > > 
> > > Signed-off-by: Linu Cherian <linu.cherian-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>
> > > Signed-off-by: Geetha Sowjanya <geethasowjanya.akula-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>
> > > ---
> > >  Documentation/arm64/silicon-errata.txt             |  1 +
> > >  .../devicetree/bindings/iommu/arm,smmu-v3.txt      |  6 ++
> > >  drivers/iommu/arm-smmu-v3.c                        | 80 ++++++++++++++++------
> > >  3 files changed, 66 insertions(+), 21 deletions(-)
> > > 
> > > diff --git a/Documentation/arm64/silicon-errata.txt b/Documentation/arm64/silicon-errata.txt
> > > index 10f2ddd..4693a32 100644
> > > --- a/Documentation/arm64/silicon-errata.txt
> > > +++ b/Documentation/arm64/silicon-errata.txt
> > > @@ -62,6 +62,7 @@ stable kernels.
> > >  | Cavium         | ThunderX GICv3  | #23154          | CAVIUM_ERRATUM_23154        |
> > >  | Cavium         | ThunderX Core   | #27456          | CAVIUM_ERRATUM_27456        |
> > >  | Cavium         | ThunderX SMMUv2 | #27704          | N/A                         |
> > > +| Cavium         | ThunderX2 SMMUv3| #74             | N/A                         |
> > >  |                |                 |                 |                             |
> > >  | Freescale/NXP  | LS2080A/LS1043A | A-008585        | FSL_ERRATUM_A008585         |
> > >  |                |                 |                 |                             |
> > > diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu-v3.txt b/Documentation/devicetree/bindings/iommu/arm,smmu-v3.txt
> > > index be57550..e6da62b 100644
> > > --- a/Documentation/devicetree/bindings/iommu/arm,smmu-v3.txt
> > > +++ b/Documentation/devicetree/bindings/iommu/arm,smmu-v3.txt
> > > @@ -49,6 +49,12 @@ the PCIe specification.
> > >  - hisilicon,broken-prefetch-cmd
> > >                      : Avoid sending CMD_PREFETCH_* commands to the SMMU.
> > >  
> > > +- cavium-cn99xx,broken-page1-regspace
> > > +                    : Replaces all page 1 offsets used for EVTQ_PROD/CONS,
> > > +						PRIQ_PROD/CONS register access with page 0 offsets.
> > > +						Set for Caviun ThunderX2 silicon that doesn't support
> > > +						SMMU page1 register space.
> > > +
> > >  ** Example
> > >  
> > >          smmu@2b400000 {
> > > diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
> > > index 380969a..1e986a0 100644
> > > --- a/drivers/iommu/arm-smmu-v3.c
> > > +++ b/drivers/iommu/arm-smmu-v3.c
> > > @@ -176,15 +176,15 @@
> > >  #define ARM_SMMU_CMDQ_CONS		0x9c
> > >  
> > >  #define ARM_SMMU_EVTQ_BASE		0xa0
> > > -#define ARM_SMMU_EVTQ_PROD		0x100a8
> > > -#define ARM_SMMU_EVTQ_CONS		0x100ac
> > > +#define ARM_SMMU_EVTQ_PROD(smmu)	(page1_offset_adjust(0x100a8, smmu))
> > > +#define ARM_SMMU_EVTQ_CONS(smmu)	(page1_offset_adjust(0x100ac, smmu))
> > 
> > Sorry, perhaps I should have communicated the rest of the idea more
> > explicitly - you now don't need to change these definitions...
> > 
> 
> Fine. 
> 
> 
> > >  #define ARM_SMMU_EVTQ_IRQ_CFG0		0xb0
> > >  #define ARM_SMMU_EVTQ_IRQ_CFG1		0xb8
> > >  #define ARM_SMMU_EVTQ_IRQ_CFG2		0xbc
> > >  
> > >  #define ARM_SMMU_PRIQ_BASE		0xc0
> > > -#define ARM_SMMU_PRIQ_PROD		0x100c8
> > > -#define ARM_SMMU_PRIQ_CONS		0x100cc
> > > +#define ARM_SMMU_PRIQ_PROD(smmu)	(page1_offset_adjust(0x100c8, smmu))
> > > +#define ARM_SMMU_PRIQ_CONS(smmu)	(page1_offset_adjust(0x100cc, smmu))
> > >  #define ARM_SMMU_PRIQ_IRQ_CFG0		0xd0
> > >  #define ARM_SMMU_PRIQ_IRQ_CFG1		0xd8
> > >  #define ARM_SMMU_PRIQ_IRQ_CFG2		0xdc
> > > @@ -412,6 +412,9 @@
> > >  #define MSI_IOVA_BASE			0x8000000
> > >  #define MSI_IOVA_LENGTH			0x100000
> > >  
> > > +#define ARM_SMMU_PAGE0_REGS_ONLY(smmu)		\
> > > +	((smmu)->options & ARM_SMMU_OPT_PAGE0_REGS_ONLY)
> > > +
> > >  static bool disable_bypass;
> > >  module_param_named(disable_bypass, disable_bypass, bool, S_IRUGO);
> > >  MODULE_PARM_DESC(disable_bypass,
> > > @@ -597,6 +600,7 @@ struct arm_smmu_device {
> > >  	u32				features;
> > >  
> > >  #define ARM_SMMU_OPT_SKIP_PREFETCH	(1 << 0)
> > > +#define ARM_SMMU_OPT_PAGE0_REGS_ONLY    (1 << 1)
> > >  	u32				options;
> > >  
> > >  	struct arm_smmu_cmdq		cmdq;
> > > @@ -663,9 +667,19 @@ struct arm_smmu_option_prop {
> > >  
> > >  static struct arm_smmu_option_prop arm_smmu_options[] = {
> > >  	{ ARM_SMMU_OPT_SKIP_PREFETCH, "hisilicon,broken-prefetch-cmd" },
> > > +	{ ARM_SMMU_OPT_PAGE0_REGS_ONLY, "cavium-cn99xx,broken-page1-regspace"},
> > >  	{ 0, NULL},
> > >  };
> > >  
> > > +static inline unsigned long page1_offset_adjust(
> > > +	unsigned long off, struct arm_smmu_device *smmu)
> > > +{
> > > +	if (off > SZ_64K && ARM_SMMU_PAGE0_REGS_ONLY(smmu))
> > > +		return (off - SZ_64K);
> > > +
> > > +	return off;
> > > +}
> > > +
> > >  static struct arm_smmu_domain *to_smmu_domain(struct iommu_domain *dom)
> > >  {
> > >  	return container_of(dom, struct arm_smmu_domain, domain);
> > > @@ -1986,8 +2000,10 @@ static int arm_smmu_init_queues(struct arm_smmu_device *smmu)
> > >  		return ret;
> > >  
> > >  	/* evtq */
> > > -	ret = arm_smmu_init_one_queue(smmu, &smmu->evtq.q, ARM_SMMU_EVTQ_PROD,
> > > -				      ARM_SMMU_EVTQ_CONS, EVTQ_ENT_DWORDS);
> > > +	ret = arm_smmu_init_one_queue(smmu, &smmu->evtq.q,
> > > +				      ARM_SMMU_EVTQ_PROD(smmu),
> > > +				      ARM_SMMU_EVTQ_CONS(smmu),
> > > +				      EVTQ_ENT_DWORDS);
> > 
> > ...or these callsites; you can just use page1_offset_adjust() directly
> > within arm_smmu_init_one_queue(), i.e.
> 
> > 
> > 
> >        q->prod_reg = smmu->base + page1_offset_adjust(prod_off, smmu);
> >        q->cons_reg = smmu->base + page1_offset_adjust(cons_off, smmu);
> > 
> > because it won't affect page 0 offsets either way.
> > 
> > >  	if (ret)
> > >  		return ret;
> > >  
> > > @@ -1995,8 +2011,10 @@ static int arm_smmu_init_queues(struct arm_smmu_device *smmu)
> > >  	if (!(smmu->features & ARM_SMMU_FEAT_PRI))
> > >  		return 0;
> > >  
> > > -	return arm_smmu_init_one_queue(smmu, &smmu->priq.q, ARM_SMMU_PRIQ_PROD,
> > > -				       ARM_SMMU_PRIQ_CONS, PRIQ_ENT_DWORDS);
> > > +	return arm_smmu_init_one_queue(smmu, &smmu->priq.q,
> > > +				       ARM_SMMU_PRIQ_PROD(smmu),
> > > +				       ARM_SMMU_PRIQ_CONS(smmu),
> > > +				       PRIQ_ENT_DWORDS);
> > >  }
> > >  
> > >  static int arm_smmu_init_l1_strtab(struct arm_smmu_device *smmu)
> > > @@ -2363,8 +2381,10 @@ static int arm_smmu_device_reset(struct arm_smmu_device *smmu, bool bypass)
> > >  
> > >  	/* Event queue */
> > >  	writeq_relaxed(smmu->evtq.q.q_base, smmu->base + ARM_SMMU_EVTQ_BASE);
> > > -	writel_relaxed(smmu->evtq.q.prod, smmu->base + ARM_SMMU_EVTQ_PROD);
> > > -	writel_relaxed(smmu->evtq.q.cons, smmu->base + ARM_SMMU_EVTQ_CONS);
> > > +	writel_relaxed(smmu->evtq.q.prod, smmu->base +
> > > +		       ARM_SMMU_EVTQ_PROD(smmu));
> > 
> > And correspondingly just use page1_offset_adjust(ARM_SMMU_EVTQ_*, smmu)
> > explicitly for these writes.
> > 
> > In fact, if all the potential callsites are immediately converting the
> > offset into an address, then it may be worth just factoring that into
> > the helper as well, something like:
> > 
> > static inline void __iomem *arm_smmu_page1_fixup(unsigned long offset,
> > 					struct arm_smmu_device *smmu)
> > {
> > 	if (offset > SZ_64K && ARM_SMMU_PAGE0_REGS_ONLY(smmu))
> > 		offset -= SZ_64K;
> > 
> > 	return smmu->base + offset;
> > }
> > 
> > What do you reckon?
> > 
> 
> Just had a opinion that, replacing all page1 offset macros(ARM_SMMU_EVTQ/PRIQ_PROD/CONS) with
> page1_offset_adjust(ARM_SMMU_EVTQ/PRIQ_PROD/CONS, smmu) will make the changes 
> more uniform. In that case, we wont need, offset > SZ_64K  check as
> well.
> 
> Hope the intention is not to change the offset definitions.
> 
> 

Will post v5 series with the approach you suggested (using
arm_smmu_page1_fixup). Also realize that this will result in less
number of changes as well.

Thanks.


-- 
Linu cherian
