From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH v2 2/9] iommu/arm-smmu: Sort out coherency
Date: Wed, 29 Jul 2015 19:46:05 +0100
Message-ID: <85e468665bc36f94d95950f78fc6ceb35818dc5f.1438195011.git.robin.murphy@arm.com>
References: <6999933bfa9b3d50853fd023d455c837a0d7ff23.1438195011.git.robin.murphy@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <6999933bfa9b3d50853fd023d455c837a0d7ff23.1438195011.git.robin.murphy-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: will.deacon-5wv7dgnIgG8@public.gmane.org, laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org
Cc: linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Currently, we detect whether the SMMU has coherent page table walk
capability from the IDR0.CTTW field, and base our cache maintenance
decisions on that. In preparation for fixing the bogus DMA API usage,
however, we need to ensure that the DMA API agrees about this, which
necessitates deferring to the dma-coherent property in the device tree
for the final say.

As an added bonus, since systems exist where an external CTTW signal
has been tied off incorrectly at integration, allowing DT to override
it offers a neat workaround for coherency issues with such SMMUs.

Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
---
 Documentation/devicetree/bindings/iommu/arm,smmu.txt |  6 ++++++
 drivers/iommu/arm-smmu.c                             | 20 +++++++++++++++++---
 2 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.txt b/Documentation/devicetree/bindings/iommu/arm,smmu.txt
index 0676050..7180745 100644
--- a/Documentation/devicetree/bindings/iommu/arm,smmu.txt
+++ b/Documentation/devicetree/bindings/iommu/arm,smmu.txt
@@ -43,6 +43,12 @@ conditions.
 
 ** System MMU optional properties:
 
+- dma-coherent  : Present if page table walks made by the SMMU are
+                  cache coherent with the CPU.
+
+                  NOTE: this only applies to the SMMU itself, not
+                  masters connected upstream of the SMMU.
+
 - calxeda,smmu-secure-config-access : Enable proper handling of buggy
                   implementations that always use secure access to
                   SMMU configuration registers. In this case non-secure
diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 4cd0c29..0583ed2 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -37,6 +37,7 @@
 #include <linux/iopoll.h>
 #include <linux/module.h>
 #include <linux/of.h>
+#include <linux/of_address.h>
 #include <linux/pci.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
@@ -1532,6 +1533,7 @@ static int arm_smmu_device_cfg_probe(struct arm_smmu_device *smmu)
 	unsigned long size;
 	void __iomem *gr0_base = ARM_SMMU_GR0(smmu);
 	u32 id;
+	bool cttw_dt, cttw_reg;
 
 	dev_notice(smmu->dev, "probing hardware configuration...\n");
 	dev_notice(smmu->dev, "SMMUv%d with:\n", smmu->version);
@@ -1571,10 +1573,22 @@ static int arm_smmu_device_cfg_probe(struct arm_smmu_device *smmu)
 		dev_notice(smmu->dev, "\taddress translation ops\n");
 	}
 
-	if (id & ID0_CTTW) {
+	/*
+	 * In order for DMA API calls to work properly, we must defer to what
+	 * the DT says about coherency, regardless of what the hardware claims.
+	 * Fortunately, this also opens up a workaround for systems where the
+	 * ID register value has ended up configured incorrectly.
+	 */
+	cttw_dt = of_dma_is_coherent(smmu->dev->of_node);
+	cttw_reg = !!(id & ID0_CTTW);
+	if (cttw_dt)
 		smmu->features |= ARM_SMMU_FEAT_COHERENT_WALK;
-		dev_notice(smmu->dev, "\tcoherent table walk\n");
-	}
+	if (cttw_dt || cttw_reg)
+		dev_notice(smmu->dev, "\t%scoherent table walk\n",
+			   cttw_dt ? "" : "non-");
+	if (cttw_dt != cttw_reg)
+		dev_notice(smmu->dev,
+			   "\t(IDR0.CTTW overridden by dma-coherent property)\n");
 
 	if (id & ID0_SMS) {
 		u32 smr, sid, mask;
-- 
1.9.1
