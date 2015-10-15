From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH 6/6] iommu/arm-smmu: Add support for MSI on SMMUv3
Date: Thu, 15 Oct 2015 16:04:24 +0100
Message-ID: <1444921464-14895-7-git-send-email-will.deacon@arm.com>
References: <1444921464-14895-1-git-send-email-will.deacon@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1444921464-14895-1-git-send-email-will.deacon-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org, jroedel-l3A5Bk7waGM@public.gmane.org, marc.zyngier-5wv7dgnIgG8@public.gmane.org, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, tchalamarla-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

From: Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>

Despite being a platform device, the SMMUv3 is capable of signaling
interrupts using MSIs. Hook it into the platform MSI framework and
enjoy faults being reported in a new and exciting way.

Signed-off-by: Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>
[will: tidied up the binding example and reworked most of the code]
Signed-off-by: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
---
 .../devicetree/bindings/iommu/arm,smmu-v3.txt      |  19 ++++
 drivers/iommu/Kconfig                              |   1 +
 drivers/iommu/arm-smmu-v3.c                        | 105 +++++++++++++++++++--
 3 files changed, 117 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu-v3.txt b/Documentation/devicetree/bindings/iommu/arm,smmu-v3.txt
index 3443e0f838df..947863acc2d4 100644
--- a/Documentation/devicetree/bindings/iommu/arm,smmu-v3.txt
+++ b/Documentation/devicetree/bindings/iommu/arm,smmu-v3.txt
@@ -36,5 +36,24 @@ the PCIe specification.
                       NOTE: this only applies to the SMMU itself, not
                       masters connected upstream of the SMMU.
 
+- msi-parent        : See the generic MSI binding described in
+                        devicetree/bindings/interrupt-controller/msi.txt
+                      for a description of the msi-parent property.
+
 - hisilicon,broken-prefetch-cmd
                     : Avoid sending CMD_PREFETCH_* commands to the SMMU.
+
+** Example
+
+        smmu@2b400000 {
+                compatible = "arm,smmu-v3";
+                reg = <0x0 0x2b400000 0x0 0x20000>;
+                interrupts = <GIC_SPI 74 IRQ_TYPE_EDGE_RISING>,
+                             <GIC_SPI 75 IRQ_TYPE_EDGE_RISING>,
+                             <GIC_SPI 77 IRQ_TYPE_EDGE_RISING>,
+                             <GIC_SPI 79 IRQ_TYPE_EDGE_RISING>;
+                interrupt-names = "eventq", "priq", "cmdq-sync", "gerror";
+                dma-coherent;
+                #iommu-cells = <0>;
+                msi-parent = <&its 0xff0000>;
+        };
diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index d9da766719c8..cc2dfa572d07 100644
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
index 970d78dcac53..5a36ef70f6f4 100644
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
@@ -402,6 +403,31 @@ enum pri_resp {
 	PRI_RESP_SUCC,
 };
 
+enum arm_smmu_msi_index {
+	EVTQ_MSI_INDEX,
+	GERROR_MSI_INDEX,
+	PRIQ_MSI_INDEX,
+	ARM_SMMU_MAX_MSIS,
+};
+
+static phys_addr_t arm_smmu_msi_cfg[ARM_SMMU_MAX_MSIS][3] = {
+	[EVTQ_MSI_INDEX] = {
+		ARM_SMMU_EVTQ_IRQ_CFG0,
+		ARM_SMMU_EVTQ_IRQ_CFG1,
+		ARM_SMMU_EVTQ_IRQ_CFG2,
+	},
+	[GERROR_MSI_INDEX] = {
+		ARM_SMMU_GERROR_IRQ_CFG0,
+		ARM_SMMU_GERROR_IRQ_CFG1,
+		ARM_SMMU_GERROR_IRQ_CFG2,
+	},
+	[PRIQ_MSI_INDEX] = {
+		ARM_SMMU_PRIQ_IRQ_CFG0,
+		ARM_SMMU_PRIQ_IRQ_CFG1,
+		ARM_SMMU_PRIQ_IRQ_CFG2,
+	},
+};
+
 struct arm_smmu_cmdq_ent {
 	/* Common fields */
 	u8				opcode;
@@ -2176,6 +2202,72 @@ static int arm_smmu_write_reg_sync(struct arm_smmu_device *smmu, u32 val,
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
+	phys_addr_t doorbell;
+	struct device *dev = msi_desc_to_dev(desc);
+	struct arm_smmu_device *smmu = dev_get_drvdata(dev);
+	phys_addr_t *cfg = arm_smmu_msi_cfg[desc->platform.msi_index];
+
+	doorbell = (((u64)msg->address_hi) << 32) | msg->address_lo;
+	doorbell &= MSI_CFG0_ADDR_MASK << MSI_CFG0_ADDR_SHIFT;
+
+	writeq_relaxed(doorbell, smmu->base + cfg[0]);
+	writel_relaxed(msg->data, smmu->base + cfg[1]);
+	writel_relaxed(MSI_CFG2_MEMATTR_DEVICE_nGnRE, smmu->base + cfg[2]);
+}
+
+static void arm_smmu_setup_msis(struct arm_smmu_device *smmu)
+{
+	struct msi_desc *desc;
+	int ret, nvec = ARM_SMMU_MAX_MSIS;
+	struct device *dev = smmu->dev;
+
+	/* Clear the MSI address regs */
+	writeq_relaxed(0, smmu->base + ARM_SMMU_GERROR_IRQ_CFG0);
+	writeq_relaxed(0, smmu->base + ARM_SMMU_EVTQ_IRQ_CFG0);
+
+	if (smmu->features & ARM_SMMU_FEAT_PRI)
+		writeq_relaxed(0, smmu->base + ARM_SMMU_PRIQ_IRQ_CFG0);
+	else
+		nvec--;
+
+	if (!(smmu->features & ARM_SMMU_FEAT_MSI))
+		return;
+
+	/* Allocate MSIs for evtq, gerror and priq. Ignore cmdq */
+	ret = platform_msi_domain_alloc_irqs(dev, nvec, arm_smmu_write_msi_msg);
+	if (ret) {
+		dev_warn(dev, "failed to allocate MSIs\n");
+		return;
+	}
+
+	for_each_msi_entry(desc, dev) {
+		switch (desc->platform.msi_index) {
+		case EVTQ_MSI_INDEX:
+			smmu->evtq.q.irq = desc->irq;
+			break;
+		case GERROR_MSI_INDEX:
+			smmu->gerr_irq = desc->irq;
+			break;
+		case PRIQ_MSI_INDEX:
+			smmu->priq.q.irq = desc->irq;
+			break;
+		default:	/* Unknown */
+			continue;
+		}
+	}
+
+	/* Add callback to free MSIs on teardown */
+	devm_add_action(dev, arm_smmu_free_msis, dev);
+}
+
 static int arm_smmu_setup_irqs(struct arm_smmu_device *smmu)
 {
 	int ret, irq;
@@ -2189,11 +2281,9 @@ static int arm_smmu_setup_irqs(struct arm_smmu_device *smmu)
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
@@ -2222,8 +2312,6 @@ static int arm_smmu_setup_irqs(struct arm_smmu_device *smmu)
 	}
 
 	if (smmu->features & ARM_SMMU_FEAT_PRI) {
-		writeq_relaxed(0, smmu->base + ARM_SMMU_PRIQ_IRQ_CFG0);
-
 		irq = smmu->priq.q.irq;
 		if (irq) {
 			ret = devm_request_threaded_irq(smmu->dev, irq,
@@ -2597,13 +2685,14 @@ static int arm_smmu_device_dt_probe(struct platform_device *pdev)
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
