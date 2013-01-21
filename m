From: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 4/6] iommu/tegra: smmu: Support variable MMIO range
Date: Mon, 21 Jan 2013 08:36:03 +0100
Message-ID: <20130121.093603.449745485344660335.hdoyu@nvidia.com>
References: <50F717B8.6050800@wwwdotorg.org><20130118.110546.1909336134474854222.hdoyu@nvidia.com><50F97BDD.8010502@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <50F97BDD.8010502-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: "swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org" <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Cc: "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org> wrote @ Fri, 18 Jan 2013 17:44:13 +0100:

> > Even the checks if "offs" is in some of register blocks could be
> > ifdef'ed out with DEBUG. "smmu->regbase" can be calculated in probe()
> > as below. I don't think that we don't need to access "mc" DT entry to
> > get this address. since "smmu"'s 1st reg block always starts at 0x10.
> > 
> >   /* same as "mc"'s 1st reg block */
> >   smmu->regbase = smmu->reg[0] & PAGE_MASK;
> 
> I don't see regbase in the existing driver or your patch. Are you

I attached the update one below just for "regbase".

> proposing to simply make readl/writel add the offset onto a base address
> that's calculated like that? That may not work in general; if the SMMU
> register ranges cross a page boundary, and the various separate ranges
> end up getting mapped to non-contiguous virtual addresses, using a
> single base address won't work.

That's not in general, but I think that this works because the 1st
SMMU register block offset is fixed(0x10) against MC base. If this is
not acceptable, then, I think that SMMU driver needs to access to MC
node to get the its base. What do you think?

>From 71de7ddfed8b3341f18e97b92bdf76c193e5127a Mon Sep 17 00:00:00 2001
From: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Date: Wed, 9 Jan 2013 12:38:47 +0200
Subject: [PATCH 1/1] iommu/tegra: smmu: Support variable MMIO ranges/blocks

Presently there are 3 register blocks. In the future chips over some
generations, some of register block "size" can be extended to the end
and also more new register blocks will be added, which is expected at
most a few blocks. Usually the starting address of each block won't
change. Ideally SMMU register blocks should be in one block, but it
was a bit too late to change this design(or H/W). Considering this
situation, in this driver, number of register blocks should be
allocated dynamically, based on the info from DT. Its range checks
can be done in the accessors. This way may sacrifice some perf because
a new accessors prevents compiler optimization of register offset
calculation, but I think that SMMU register accesses are not so
frequent and it's acceptable, but it's ifdef'ed out. This patch is
necessary to unify "tegra-smmu.ko" over Tegra SoCs.

Signed-off-by: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
---
 drivers/iommu/tegra-smmu.c |   62 ++++++++++++++++++++++++--------------------
 1 file changed, 34 insertions(+), 28 deletions(-)

diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
index e80312c..96ac4241 100644
--- a/drivers/iommu/tegra-smmu.c
+++ b/drivers/iommu/tegra-smmu.c
@@ -221,7 +221,11 @@ struct smmu_debugfs_info {
  * Per SMMU device - IOMMU device
  */
 struct smmu_device {
-	void __iomem	*regs[NUM_SMMU_REG_BANKS];
+	void __iomem	*regbase;	/* register offset base */
+	void __iomem	**regs;		/* register block start address array */
+	void __iomem	**rege;		/* register block end address array */
+	int		nregs;		/* number of register blocks */
+
 	unsigned long	iovmm_base;	/* remappable base address */
 	unsigned long	page_count;	/* total remappable size */
 	spinlock_t	lock;
@@ -254,38 +258,31 @@ static struct smmu_device *smmu_handle; /* unique for a system */
 /*
  *	SMMU register accessors
  */
+#ifdef DEBUG
+static inline void smmu_check_reg_range(size_t offs)
+{
+	int i;
+
+	for (i = 0; i < smmu->nregs; i++) {
+		BUG_ON(offs < smmu->regs[i] - smmu->regbase);
+		if (offs <= smmu->rege[i] - smmu->regbase)
+			break;
+	}
+}
+#else
+static inline void smmu_check_reg_range(size_t offs) { }
+#endif
+
 static inline u32 smmu_read(struct smmu_device *smmu, size_t offs)
 {
-	BUG_ON(offs < 0x10);
-	if (offs < 0x3c)
-		return readl(smmu->regs[0] + offs - 0x10);
-	BUG_ON(offs < 0x1f0);
-	if (offs < 0x200)
-		return readl(smmu->regs[1] + offs - 0x1f0);
-	BUG_ON(offs < 0x228);
-	if (offs < 0x284)
-		return readl(smmu->regs[2] + offs - 0x228);
-	BUG();
+	smmu_check_reg_range(offs);
+	return readl(smmu->regbase + offs);
 }
 
 static inline void smmu_write(struct smmu_device *smmu, u32 val, size_t offs)
 {
-	BUG_ON(offs < 0x10);
-	if (offs < 0x3c) {
-		writel(val, smmu->regs[0] + offs - 0x10);
-		return;
-	}
-	BUG_ON(offs < 0x1f0);
-	if (offs < 0x200) {
-		writel(val, smmu->regs[1] + offs - 0x1f0);
-		return;
-	}
-	BUG_ON(offs < 0x228);
-	if (offs < 0x284) {
-		writel(val, smmu->regs[2] + offs - 0x228);
-		return;
-	}
-	BUG();
+	smmu_check_reg_range(offs);
+	writel(val, smmu->regbase + offs);
 }
 
 #define VA_PAGE_TO_PA(va, page)	\
@@ -1108,7 +1105,13 @@ static int tegra_smmu_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	}
 
-	for (i = 0; i < ARRAY_SIZE(smmu->regs); i++) {
+	smmu->nregs = pdev->num_resources;
+	smmu->regs = devm_kzalloc(dev, 2 * smmu->nregs * sizeof(*smmu->regs),
+				  GFP_KERNEL);
+	smmu->rege = smmu->regs + smmu->nregs;
+	if (!smmu->regs)
+		return -ENOMEM;
+	for (i = 0; i < smmu->nregs; i++) {
 		struct resource *res;
 
 		res = platform_get_resource(pdev, IORESOURCE_MEM, i);
@@ -1117,7 +1120,10 @@ static int tegra_smmu_probe(struct platform_device *pdev)
 		smmu->regs[i] = devm_request_and_ioremap(&pdev->dev, res);
 		if (!smmu->regs[i])
 			return -EBUSY;
+		smmu->rege[i] = smmu->regs[i] + resource_size(res);
 	}
+	/* Same as "mc" 1st regiter block start address */
+	smmu->regbase = (void __iomem *)((u32)smmu->regs[0] & ~PAGE_MASK);
 
 	err = of_get_dma_window(dev->of_node, NULL, 0, NULL, &base, &size);
 	if (err)
-- 
1.7.9.5
