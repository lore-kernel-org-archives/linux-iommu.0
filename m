From: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: [v3 1/1] iommu/tegra: smmu: Support variable MMIO ranges/blocks
Date: Tue, 29 Jan 2013 19:56:09 +0200
Message-ID: <1359482169-26756-1-git-send-email-hdoyu@nvidia.com>
References: <510800F7.7020507@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <510800F7.7020507-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org
Cc: linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Presently SMMU registers are located in discontiguous 3 blocks. They
are interleaved by MC registers. Ideally SMMU register blocks should
be in an independent one block, but it is too late to change this H/W
design. In the future Tegra chips over some generations, it is
expected that some of register block "size" can be extended towards
the end and also more new register blocks will be added at most a few
blocks. The starting address of each existing block won't change. This
patch allocates multiple number of register blocks dynamically based
on the info passed from DT. Those ranges are verified in the
accessors{read,write}. This may sacrifice some performance because a
new accessors prevents compiler optimization of a fixed size register
offset calculation. Since SMMU register accesses are not so frequent,
this would be acceptable. This patch is necessary to unify
"tegra-smmu.ko" over some Tegra SoC generations.

Signed-off-by: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
---
v3:
Fixed overlapped register validation. (Stephen Warren)
Fixed typo s/regiter/register/. (Stephen Warren)
---
 drivers/iommu/tegra-smmu.c |   61 ++++++++++++++++++++++++++------------------
 1 file changed, 36 insertions(+), 25 deletions(-)

diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
index fc17889..d1448f9 100644
--- a/drivers/iommu/tegra-smmu.c
+++ b/drivers/iommu/tegra-smmu.c
@@ -293,7 +293,11 @@ struct smmu_debugfs_info {
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
@@ -325,35 +329,33 @@ static struct smmu_device *smmu_handle; /* unique for a system */
  */
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
+	int i;
+
+	for (i = 0; i < smmu->nregs; i++) {
+		void __iomem *addr = smmu->regbase + offs;
+
+		BUG_ON(addr < smmu->regs[i]);
+		if (addr < smmu->rege[i])
+			return readl(addr);
+	}
+
 	BUG();
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
+	int i;
+
+	for (i = 0; i < smmu->nregs; i++) {
+		void __iomem *addr = smmu->regbase + offs;
+
+		BUG_ON(addr < smmu->regs[i]);
+		if (addr < smmu->rege[i]) {
+			writel(val, addr);
+			return;
+		}
 	}
+
 	BUG();
 }
 
@@ -1170,7 +1172,13 @@ static int tegra_smmu_probe(struct platform_device *pdev)
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
@@ -1179,7 +1187,10 @@ static int tegra_smmu_probe(struct platform_device *pdev)
 		smmu->regs[i] = devm_request_and_ioremap(&pdev->dev, res);
 		if (!smmu->regs[i])
 			return -EBUSY;
+		smmu->rege[i] = smmu->regs[i] + resource_size(res);
 	}
+	/* Same as "mc" 1st register block start address */
+	smmu->regbase = (void __iomem *)((u32)smmu->regs[0] & ~PAGE_MASK);
 
 	err = of_get_dma_window(dev->of_node, NULL, 0, NULL, &base, &size);
 	if (err)
-- 
1.7.9.5
