From: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 4/6] iommu/tegra: smmu: Support variable MMIO range
Date: Tue, 15 Jan 2013 10:17:26 +0200
Message-ID: <1358237848-968-4-git-send-email-hdoyu@nvidia.com>
References: <1358237848-968-1-git-send-email-hdoyu@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1358237848-968-1-git-send-email-hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org
Cc: linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

There are 3 SMMU MMIO register blocks. They may get bigger as new
Tegra SoC comes. This patch enables to support variable size of those
register blocks.

Signed-off-by: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
---
 drivers/iommu/tegra-smmu.c |   14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
index e80312c..4f3a2a5 100644
--- a/drivers/iommu/tegra-smmu.c
+++ b/drivers/iommu/tegra-smmu.c
@@ -222,6 +222,7 @@ struct smmu_debugfs_info {
  */
 struct smmu_device {
 	void __iomem	*regs[NUM_SMMU_REG_BANKS];
+	resource_size_t	regsz[NUM_SMMU_REG_BANKS];
 	unsigned long	iovmm_base;	/* remappable base address */
 	unsigned long	page_count;	/* total remappable size */
 	spinlock_t	lock;
@@ -257,13 +258,13 @@ static struct smmu_device *smmu_handle; /* unique for a system */
 static inline u32 smmu_read(struct smmu_device *smmu, size_t offs)
 {
 	BUG_ON(offs < 0x10);
-	if (offs < 0x3c)
+	if (offs < 0x10 + smmu->regsz[0])
 		return readl(smmu->regs[0] + offs - 0x10);
 	BUG_ON(offs < 0x1f0);
-	if (offs < 0x200)
+	if (offs < 0x1f0 + smmu->regsz[1])
 		return readl(smmu->regs[1] + offs - 0x1f0);
 	BUG_ON(offs < 0x228);
-	if (offs < 0x284)
+	if (offs < 0x228 + smmu->regsz[2])
 		return readl(smmu->regs[2] + offs - 0x228);
 	BUG();
 }
@@ -271,17 +272,17 @@ static inline u32 smmu_read(struct smmu_device *smmu, size_t offs)
 static inline void smmu_write(struct smmu_device *smmu, u32 val, size_t offs)
 {
 	BUG_ON(offs < 0x10);
-	if (offs < 0x3c) {
+	if (offs < 0x10 + smmu->regsz[0]) {
 		writel(val, smmu->regs[0] + offs - 0x10);
 		return;
 	}
 	BUG_ON(offs < 0x1f0);
-	if (offs < 0x200) {
+	if (offs < 0x1f0 + smmu->regsz[1]) {
 		writel(val, smmu->regs[1] + offs - 0x1f0);
 		return;
 	}
 	BUG_ON(offs < 0x228);
-	if (offs < 0x284) {
+	if (offs < 0x228 + smmu->regsz[2]) {
 		writel(val, smmu->regs[2] + offs - 0x228);
 		return;
 	}
@@ -1117,6 +1118,7 @@ static int tegra_smmu_probe(struct platform_device *pdev)
 		smmu->regs[i] = devm_request_and_ioremap(&pdev->dev, res);
 		if (!smmu->regs[i])
 			return -EBUSY;
+		smmu->regsz[i] = resource_size(res);
 	}
 
 	err = of_get_dma_window(dev->of_node, NULL, 0, NULL, &base, &size);
-- 
1.7.9.5
