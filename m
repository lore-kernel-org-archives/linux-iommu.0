From: Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH v4] iommu/arm-smmu: Add support for MSI on SMMUv3
Date: Tue, 13 Oct 2015 18:32:30 +0100
Message-ID: <1444757550-24702-1-git-send-email-marc.zyngier@arm.com>
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
* From v3:
  - Pass the device as a parameter to the MSI destructor (instead of
  the smmu structure)
  - Select CONFIG_GENERIC_MSI_IRQ
  - Update binding documentation (and add an example)

* From v2:
  - MSI indexes as an enum
  - Fixed stupid 16bit writes instead of 32bit
  - Added devm callback to release MSIs on teardown
  - Moved all the MSI setup to its own function

 .../devicetree/bindings/iommu/arm,smmu-v3.txt      |  20 ++++
 drivers/iommu/Kconfig                              |   1 +
 drivers/iommu/arm-smmu-v3.c                        | 106 +++++++++++++++++++--
 3 files changed, 119 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu-v3.txt b/Documentation/devicetree/bindings/iommu/arm,smmu-v3.txt
index 3443e0f..9f5958e 100644
--- a/Documentation/devicetree/bindings/iommu/arm,smmu-v3.txt
+++ b/Documentation/devicetree/bindings/iommu/arm,smmu-v3.txt
@@ -36,5 +36,25 @@ the PCIe specification.
                       NOTE: this only applies to the SMMU itself, not
                       masters connected upstream of the SMMU.
 
+- msi-parent	    : phandles (and potential Device IDs) of MSI controllers
+		      the SMMU can send MSIs to (instead of wired interrupts).
+		      See devicetree/bindings.interrupt-controller/msi.txt
+		      for a description of the msi-parent property.
+
 - hisilicon,broken-prefetch-cmd
                     : Avoid sending CMD_PREFETCH_* commands to the SMMU.
+
+** Example
+
+        smmu@2b400000 {
+                compatible = "arm,smmu-v3";
+                reg = <0x0 0x2b400000 0x0 0x20000>;
+                interrupts = <0x0 0x4a 0x1>,
+			     <0x0 0x4b 0x1>,
+			     <0x0 0x4d 0x1>,
+			     <0x0 0x4f 0x1>;
+                interrupt-names = "eventq", "priq", "cmdq-sync", "gerror";
+                dma-coherent;
+                #iommu-cells = <0x0>;
+                msi-parent = <&its 0x13210>;
+        };
diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index 4664c2a..722ec85 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -362,6 +362,7 @@ config ARM_SMMU_V3
 	depends on ARM64 && PCI
 	select IOMMU_API
 	select IOMMU_IO_PGTABLE_LPAE
+	select GENERIC_MSI_IRQ_DOMAIN
 	help
 	  Support for implementations of the ARM System MMU architecture
 	  version 3 providing translation support to a PCIe root complex.
diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 5b11b77..be71831 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -26,6 +26,7 @@
 #include <linux/iommu.h>
 #include <linux/iopoll.h>
 #include <linux/module.h>
+#include <linux/msi.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/of_platform.h>
@@ -403,6 +404,12 @@ enum pri_resp {
 	PRI_RESP_SUCC,
 };
 
+enum msi_index {
+	EVTQ_MSI_INDEX,
+	GERROR_MSI_INDEX,
+	PRIQ_MSI_INDEX,
+};
+
 struct arm_smmu_cmdq_ent {
 	/* Common fields */
 	u8				opcode;
@@ -2176,6 +2183,92 @@ static int arm_smmu_write_reg_sync(struct arm_smmu_device *smmu, u32 val,
 					  1, ARM_SMMU_POLL_TIMEOUT_US);
 }
 
+static void arm_smmu_free_msis(void *data)
+{
+	struct device *dev = data;
+	platform_msi_domain_free_irqs(dev);
+}
+
+static void arm_smmu_write_msi_msg(struct msi_desc *desc, struct msi_msg *msg)
+{
+	struct device *dev = msi_desc_to_dev(desc);
+	struct arm_smmu_device *smmu = dev_get_drvdata(dev);
+	phys_addr_t cfg0_offset, cfg1_offset, cfg2_offset;
+	phys_addr_t doorbell;
+
+	switch (desc->platform.msi_index) {
+	case EVTQ_MSI_INDEX:
+		cfg0_offset = ARM_SMMU_EVTQ_IRQ_CFG0;
+		cfg1_offset = ARM_SMMU_EVTQ_IRQ_CFG1;
+		cfg2_offset = ARM_SMMU_EVTQ_IRQ_CFG2;
+		break;
+	case GERROR_MSI_INDEX:
+		cfg0_offset = ARM_SMMU_GERROR_IRQ_CFG0;
+		cfg1_offset = ARM_SMMU_GERROR_IRQ_CFG1;
+		cfg2_offset = ARM_SMMU_GERROR_IRQ_CFG2;
+		break;
+	case PRIQ_MSI_INDEX:
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
+	writel_relaxed(msg->data, smmu->base + cfg1_offset);
+	writel_relaxed(MSI_CFG2_MEMATTR_DEVICE_nGnRE,
+		       smmu->base + cfg2_offset);
+}
+
+static void arm_smmu_setup_msis(struct arm_smmu_device *smmu)
+{
+	/* Clear the MSI address regs */
+	writeq_relaxed(0, smmu->base + ARM_SMMU_GERROR_IRQ_CFG0);
+	writeq_relaxed(0, smmu->base + ARM_SMMU_EVTQ_IRQ_CFG0);
+	if (smmu->features & ARM_SMMU_FEAT_PRI)
+		writeq_relaxed(0, smmu->base + ARM_SMMU_PRIQ_IRQ_CFG0);
+
+	/* Allocate MSIs for evtq, gerror and priq. Ignore cmdq */
+	if (smmu->features & ARM_SMMU_FEAT_MSI) {
+		struct msi_desc *desc;
+		int ret, nvecs = 2;
+
+		if (smmu->features & ARM_SMMU_FEAT_PRI)
+			nvecs++;
+
+		ret = platform_msi_domain_alloc_irqs(smmu->dev, nvecs,
+						     arm_smmu_write_msi_msg);
+		if (ret) {
+			dev_warn(smmu->dev, "failed to allocate MSIs\n");
+			return;
+		}
+
+		for_each_msi_entry(desc, smmu->dev) {
+			switch (desc->platform.msi_index) {
+			case EVTQ_MSI_INDEX:
+				smmu->evtq.q.irq = desc->irq;
+				break;
+			case GERROR_MSI_INDEX:
+				smmu->gerr_irq = desc->irq;
+				break;
+			case PRIQ_MSI_INDEX:
+				smmu->priq.q.irq = desc->irq;
+				break;
+			default:	/* Unknown */
+				continue;
+			}
+		}
+
+		/* Add callback to free MSIs on teardown */
+		devm_add_action(smmu->dev, arm_smmu_free_msis, smmu->dev);
+	}
+}
+
 static int arm_smmu_setup_irqs(struct arm_smmu_device *smmu)
 {
 	int ret, irq;
@@ -2189,11 +2282,9 @@ static int arm_smmu_setup_irqs(struct arm_smmu_device *smmu)
 		return ret;
 	}
 
-	/* Clear the MSI address regs */
-	writeq_relaxed(0, smmu->base + ARM_SMMU_GERROR_IRQ_CFG0);
-	writeq_relaxed(0, smmu->base + ARM_SMMU_EVTQ_IRQ_CFG0);
+	arm_smmu_setup_msis(smmu);
 
-	/* Request wired interrupt lines */
+	/* Request interrupt lines */
 	irq = smmu->evtq.q.irq;
 	if (irq) {
 		ret = devm_request_threaded_irq(smmu->dev, irq,
@@ -2222,8 +2313,6 @@ static int arm_smmu_setup_irqs(struct arm_smmu_device *smmu)
 	}
 
 	if (smmu->features & ARM_SMMU_FEAT_PRI) {
-		writeq_relaxed(0, smmu->base + ARM_SMMU_PRIQ_IRQ_CFG0);
-
 		irq = smmu->priq.q.irq;
 		if (irq) {
 			ret = devm_request_threaded_irq(smmu->dev, irq,
@@ -2602,13 +2691,14 @@ static int arm_smmu_device_dt_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	/* Record our private device structure */
+	platform_set_drvdata(pdev, smmu);
+
 	/* Reset the device */
 	ret = arm_smmu_device_reset(smmu);
 	if (ret)
 		goto out_free_structures;
 
-	/* Record our private device structure */
-	platform_set_drvdata(pdev, smmu);
 	return 0;
 
 out_free_structures:
-- 
2.1.4
