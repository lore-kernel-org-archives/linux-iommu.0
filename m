From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH 22/20] iommu/arm-smmu: Fall back to global bypass
Date: Fri,  9 Sep 2016 19:17:47 +0100
Message-ID: <9c467662ca0fb562cff6d5c9443d77eacb257060.1473443407.git.robin.murphy@arm.com>
References: <cover.1473173789.git.robin.murphy@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <cover.1473173789.git.robin.murphy-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: will.deacon-5wv7dgnIgG8@public.gmane.org, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, punit.agrawal-5wv7dgnIgG8@public.gmane.org, thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Unlike SMMUv2, SMMUv3 has no easy way to bypass unknown stream IDs,
other than allocating and filling in the entire stream table with bypass
entries, which for some configurations would waste *gigabytes* of RAM.
Otherwise, all transactions on unknown stream IDs will simply be aborted
with a C_BAD_STREAMID event.

Rather than render the system unusable in the case of an invalid DT,
avoid enabling the SMMU altogether such that everything bypasses
(though letting the explicit disable_bypass option take precedence).

Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
---
 drivers/iommu/arm-smmu-v3.c | 28 +++++++++++++++++++++++-----
 1 file changed, 23 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index be293b5aa896..859b80c83946 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -126,6 +126,9 @@
 #define CR2_RECINVSID			(1 << 1)
 #define CR2_E2H				(1 << 0)
 
+#define ARM_SMMU_GBPA			0x44
+#define GBPA_ABORT			(1 << 20)
+
 #define ARM_SMMU_IRQ_CTRL		0x50
 #define IRQ_CTRL_EVTQ_IRQEN		(1 << 2)
 #define IRQ_CTRL_PRIQ_IRQEN		(1 << 1)
@@ -2242,7 +2245,7 @@ static int arm_smmu_device_disable(struct arm_smmu_device *smmu)
 	return ret;
 }
 
-static int arm_smmu_device_reset(struct arm_smmu_device *smmu)
+static int arm_smmu_device_reset(struct arm_smmu_device *smmu, bool bypass)
 {
 	int ret;
 	u32 reg, enables;
@@ -2343,8 +2346,14 @@ static int arm_smmu_device_reset(struct arm_smmu_device *smmu)
 		return ret;
 	}
 
-	/* Enable the SMMU interface */
-	enables |= CR0_SMMUEN;
+
+	/* Enable the SMMU interface, or ensure bypass */
+	if (!bypass || disable_bypass) {
+		enables |= CR0_SMMUEN;
+	} else {
+		reg = readl_relaxed(smmu->base + ARM_SMMU_GBPA);
+		writel_relaxed(reg & ~GBPA_ABORT, smmu->base + ARM_SMMU_GBPA);
+	}
 	ret = arm_smmu_write_reg_sync(smmu, enables, ARM_SMMU_CR0,
 				      ARM_SMMU_CR0ACK);
 	if (ret) {
@@ -2543,6 +2552,15 @@ static int arm_smmu_device_dt_probe(struct platform_device *pdev)
 	struct resource *res;
 	struct arm_smmu_device *smmu;
 	struct device *dev = &pdev->dev;
+	bool bypass = true;
+	u32 cells;
+
+	if (of_property_read_u32(dev->of_node, "#iommu-cells", &cells))
+		dev_err(dev, "missing #iommu-cells property\n");
+	else if (cells != 1)
+		dev_err(dev, "invalid #iommu-cells value (%d)\n", cells);
+	else
+		bypass = false;
 
 	smmu = devm_kzalloc(dev, sizeof(*smmu), GFP_KERNEL);
 	if (!smmu) {
@@ -2595,8 +2613,8 @@ static int arm_smmu_device_dt_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, smmu);
 
 	/* Reset the device */
-	ret = arm_smmu_device_reset(smmu);
-	if (ret)
+	ret = arm_smmu_device_reset(smmu, bypass);
+	if (ret || bypass)
 		return ret;
 
 	/* And we're up. Go go go! */
-- 
2.8.1.dirty
