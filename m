From: Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH] iommu/arm-smmu: Add support for MSI on SMMUv3
Date: Tue,  6 Oct 2015 16:48:03 +0100
Message-ID: <1444146484-29628-1-git-send-email-marc.zyngier@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
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
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Despite being a platform device, the SMMUv3 is capable of signaling
interrupts using MSIs. Hook it into the platform MSI framework and
enjoy faults being reported in a new and exciting way.

Signed-off-by: Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>
---
 drivers/iommu/arm-smmu-v3.c | 78 +++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 76 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index dafaf59..38f24bf 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -26,6 +26,7 @@
 #include <linux/iommu.h>
 #include <linux/iopoll.h>
 #include <linux/module.h>
+#include <linux/msi.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/pci.h>
@@ -2182,6 +2183,63 @@ static int arm_smmu_write_reg_sync(struct arm_smmu_device *smmu, u32 val,
 					  1, ARM_SMMU_POLL_TIMEOUT_US);
 }
 
+static void arm_smmu_write_msi_msg(struct msi_desc *desc, struct msi_msg *msg)
+{
+	struct device *dev = msi_desc_to_dev(desc);
+	struct arm_smmu_device *smmu = dev_get_drvdata(dev);
+	phys_addr_t cfg0_offset, cfg1_offset, cfg2_offset;
+	phys_addr_t doorbell;
+
+	switch (desc->platform.msi_index) {
+	case 0:			/* EVTQ */
+		cfg0_offset = ARM_SMMU_EVTQ_IRQ_CFG0;
+		cfg1_offset = ARM_SMMU_EVTQ_IRQ_CFG1;
+		cfg2_offset = ARM_SMMU_EVTQ_IRQ_CFG2;
+		break;
+	case 1:			/* GERROR */
+		cfg0_offset = ARM_SMMU_GERROR_IRQ_CFG0;
+		cfg1_offset = ARM_SMMU_GERROR_IRQ_CFG1;
+		cfg2_offset = ARM_SMMU_GERROR_IRQ_CFG2;
+		break;
+	case 2:			/* PRIQ */
+		cfg0_offset = ARM_SMMU_PRIQ_IRQ_CFG0;
+		cfg1_offset = ARM_SMMU_PRIQ_IRQ_CFG1;
+		cfg2_offset = ARM_SMMU_PRIQ_IRQ_CFG2;
+		break;
+	default:		/* Unknown */
+		return;
+	}
+
+	doorbell = (((u64)msg->address_hi) << 32) | msg->address_lo;
+	doorbell &= MSI_CFG0_ADDR_MASK << MSI_CFG0_ADDR_SHIFT;
+
+	writeq_relaxed(doorbell, smmu->base + cfg0_offset);
+	writew_relaxed(msg->data, smmu->base + cfg1_offset);
+	writew_relaxed(MSI_CFG2_MEMATTR_DEVICE_nGnRE,
+		       smmu->base + cfg2_offset);
+}
+
+static void arm_smmu_msi_override_irqs(struct arm_smmu_device *smmu)
+{
+	struct msi_desc *desc;
+
+	for_each_msi_entry(desc, smmu->dev) {
+		switch (desc->platform.msi_index) {
+		case 0:		/* EVTQ */
+			smmu->evtq.q.irq = desc->irq;
+			break;
+		case 1:		/* GERROR */
+			smmu->gerr_irq = desc->irq;
+			break;
+		case 2:		/* PRIQ */
+			smmu->priq.q.irq = desc->irq;
+			break;
+		default:	/* Unknown */
+			continue;
+		}
+	}
+}
+
 static int arm_smmu_setup_irqs(struct arm_smmu_device *smmu)
 {
 	int ret, irq;
@@ -2198,6 +2256,23 @@ static int arm_smmu_setup_irqs(struct arm_smmu_device *smmu)
 	/* Clear the MSI address regs */
 	writeq_relaxed(0, smmu->base + ARM_SMMU_GERROR_IRQ_CFG0);
 	writeq_relaxed(0, smmu->base + ARM_SMMU_EVTQ_IRQ_CFG0);
+	if (smmu->features & ARM_SMMU_FEAT_PRI)
+		writeq_relaxed(0, smmu->base + ARM_SMMU_PRIQ_IRQ_CFG0);
+
+	/* Allocate MSIs for evtq, gerror and priq. Ignore cmdq */
+	if (smmu->features & ARM_SMMU_FEAT_MSI) {
+		int nvecs = 2;
+
+		if (smmu->features & ARM_SMMU_FEAT_PRI)
+			nvecs++;
+
+		ret = platform_msi_domain_alloc_irqs(smmu->dev, nvecs,
+						     arm_smmu_write_msi_msg);
+		if (ret)
+			dev_warn(smmu->dev, "failed to allocate MSIs\n");
+		else
+			arm_smmu_msi_override_irqs(smmu);
+	}
 
 	/* Request wired interrupt lines */
 	irq = smmu->evtq.q.irq;
@@ -2228,8 +2303,6 @@ static int arm_smmu_setup_irqs(struct arm_smmu_device *smmu)
 	}
 
 	if (smmu->features & ARM_SMMU_FEAT_PRI) {
-		writeq_relaxed(0, smmu->base + ARM_SMMU_PRIQ_IRQ_CFG0);
-
 		irq = smmu->priq.q.irq;
 		if (irq) {
 			ret = devm_request_threaded_irq(smmu->dev, irq,
@@ -2562,6 +2635,7 @@ static int arm_smmu_device_dt_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	}
 	smmu->dev = dev;
+	dev_set_drvdata(dev, smmu);
 
 	/* Base address */
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-- 
2.1.4
