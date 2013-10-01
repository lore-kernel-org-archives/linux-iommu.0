From: Andreas Herrmann <andreas.herrmann-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 6/6] iommu/arm-smmu: Support buggy implemenations where
	all config accesses are secure
Date: Tue, 1 Oct 2013 20:17:09 +0200
Message-ID: <20131001181709.GZ3315@alberich>
References: <1380631150-10783-1-git-send-email-andreas.herrmann@calxeda.com>
	<1380631150-10783-7-git-send-email-andreas.herrmann@calxeda.com>
	<524ACE13.4020309@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <524ACE13.4020309-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Tue, Oct 01, 2013 at 09:28:51AM -0400, Rob Herring wrote:
> On 10/01/2013 07:39 AM, Andreas Herrmann wrote:
> > In such a case we have to use secure aliases of some non-secure
> > registers.
> > 
> > This behaviour is controlled via a flag in smmu->bugs. It is set
> > based on DT information when probing an SMMU device.
> 
> Perhaps quirks would be a nicer word...

In fact it might be better to rename this as "options".
For device isolation I had added a flag to indicate this in
smmu->features.
But it might be better to not mix hardware features with software
features or options.

So what do you (Will and Rob) think about a change like

 struct arm_smmu_device {
   ...

 #define ARM_SMMU_FEAT_COHERENT_WALK     (1 << 0)
 #define ARM_SMMU_FEAT_STREAM_MATCH      (1 << 1)
 #define ARM_SMMU_FEAT_TRANS_S1          (1 << 2)
 #define ARM_SMMU_FEAT_TRANS_S2          (1 << 3)
 #define ARM_SMMU_FEAT_TRANS_NESTED      (1 << 4)
         u32                             features;
+ #define ARM_SMMU_OPT_SECURE_CFG_ACCESS  (1 << 0)
+ #define ARM_SMMU_OPT_ISOLATE_DEVICES    (1 << 1)
+        u32                             options;
         int                             version;
   ...
 }

DT property "calxeda,smmu-secure-cfg-access" would set
ARM_SMMU_OPT_SECURE_CFG_ACCESS and
DT property "linux,arm-smmu-isolate-devices" would set
ARM_SMMU_OPT_ISOLATE_DEVICES.

(Maybe in future there will be more driver options. )

> > Signed-off-by: Andreas Herrmann <andreas.herrmann-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>
> > ---
> >  drivers/iommu/arm-smmu.c |   33 ++++++++++++++++++++++++---------
> >  1 file changed, 24 insertions(+), 9 deletions(-)
> > 
> > diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> > index b632bcd..46f2b78 100644
> > --- a/drivers/iommu/arm-smmu.c
> > +++ b/drivers/iommu/arm-smmu.c
> > @@ -60,6 +60,15 @@
> >  #define ARM_SMMU_GR0(smmu)		((smmu)->base)
> >  #define ARM_SMMU_GR1(smmu)		((smmu)->base + (smmu)->pagesize)
> >  
> > +/*
> > + * SMMU global address space with conditional offset to access secure aliases of
> > + * non-secure registers (e.g. nsCR0: 0x400, nsGFSR: 0x448, nsGFSYNR0: 0x450)
> > + */
> > +#define ARM_SMMU_GR0_NS(smmu)						\
> > +	((smmu)->base +							\
> > +		((smmu->bugs & ARM_SMMU_BUG_SECURE_CFG_ACCESS) ? 0x400 : 0))
> > +
> > +
> >  /* Page table bits */
> >  #define ARM_SMMU_PTE_PAGE		(((pteval_t)3) << 0)
> >  #define ARM_SMMU_PTE_CONT		(((pteval_t)1) << 52)
> > @@ -348,6 +357,8 @@ struct arm_smmu_device {
> >  #define ARM_SMMU_FEAT_TRANS_S2		(1 << 3)
> >  #define ARM_SMMU_FEAT_TRANS_NESTED	(1 << 4)
> >  	u32				features;
> > +#define ARM_SMMU_BUG_SECURE_CFG_ACCESS	(1 << 0)
> > +	u32				bugs;
> >  	int				version;
> >  
> >  	u32				num_context_banks;
> > @@ -611,16 +622,16 @@ static irqreturn_t arm_smmu_global_fault(int irq, void *dev)
> >  {
> >  	u32 gfsr, gfsynr0, gfsynr1, gfsynr2;
> >  	struct arm_smmu_device *smmu = dev;
> > -	void __iomem *gr0_base = ARM_SMMU_GR0(smmu);
> > +	void __iomem *gr0_base = ARM_SMMU_GR0_NS(smmu);
> >  
> >  	gfsr = readl_relaxed(gr0_base + ARM_SMMU_GR0_sGFSR);
> > -	if (!gfsr)
> > -		return IRQ_NONE;
> > -
> >  	gfsynr0 = readl_relaxed(gr0_base + ARM_SMMU_GR0_sGFSYNR0);
> >  	gfsynr1 = readl_relaxed(gr0_base + ARM_SMMU_GR0_sGFSYNR1);
> >  	gfsynr2 = readl_relaxed(gr0_base + ARM_SMMU_GR0_sGFSYNR2);
> >  
> > +	if (!gfsr)
> > +		return IRQ_NONE;
> > +
> >  	dev_err_ratelimited(smmu->dev,
> >  		"Unexpected global fault, this could be serious\n");
> >  	dev_err_ratelimited(smmu->dev,
> > @@ -1567,8 +1578,8 @@ static void arm_smmu_device_reset(struct arm_smmu_device *smmu)
> >  	u32 reg;
> >  
> >  	/* clear global FSR */
> > -	reg = readl_relaxed(gr0_base + ARM_SMMU_GR0_sGFSR);
> > -	writel(reg, gr0_base + ARM_SMMU_GR0_sGFSR);
> > +	reg = readl_relaxed(ARM_SMMU_GR0_NS(smmu) + ARM_SMMU_GR0_sGFSR);
> > +	writel(reg, ARM_SMMU_GR0_NS(smmu) + ARM_SMMU_GR0_sGFSR);
> >  
> >  	/* Mark all SMRn as invalid and all S2CRn as bypass */
> >  	for (i = 0; i < smmu->num_mapping_groups; ++i) {
> > @@ -1588,7 +1599,7 @@ static void arm_smmu_device_reset(struct arm_smmu_device *smmu)
> >  	writel_relaxed(0, gr0_base + ARM_SMMU_GR0_TLBIALLH);
> >  	writel_relaxed(0, gr0_base + ARM_SMMU_GR0_TLBIALLNSNH);
> >  
> > -	reg = readl_relaxed(gr0_base + ARM_SMMU_GR0_sCR0);
> > +	reg = readl_relaxed(ARM_SMMU_GR0_NS(smmu) + ARM_SMMU_GR0_sCR0);
> >  
> >  	/* Enable fault reporting */
> >  	reg |= (sCR0_GFRE | sCR0_GFIE | sCR0_GCFGFRE | sCR0_GCFGFIE);
> > @@ -1607,7 +1618,7 @@ static void arm_smmu_device_reset(struct arm_smmu_device *smmu)
> >  
> >  	/* Push the button */
> >  	arm_smmu_tlb_sync(smmu);
> > -	writel(reg, gr0_base + ARM_SMMU_GR0_sCR0);
> > +	writel(reg, ARM_SMMU_GR0_NS(smmu) + ARM_SMMU_GR0_sCR0);
> >  }
> >  
> >  static int arm_smmu_id_size_to_bits(int size)
> > @@ -1881,6 +1892,9 @@ static int arm_smmu_device_dt_probe(struct platform_device *pdev)
> >  		}
> >  	}
> >  
> > +	if (of_property_read_bool(dev->of_node, "calxeda,smmu-secure-cfg-access"))
> 
> This needs to be documented.

Yes, will add it in a next version of the patch.

> Rob

Andreas
