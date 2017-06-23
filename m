From: Geetha sowjanya <gakula-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>
Subject: [PATCH v9 3/3] iommu/arm-smmu-v3: Add workaround for Cavium ThunderX2
	erratum #126
Date: Fri, 23 Jun 2017 11:28:05 +0530
Message-ID: <1498197485-32008-1-git-send-email-gakula@caviumnetworks.com>
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
To: will.deacon-5wv7dgnIgG8@public.gmane.org, robin.murphy-5wv7dgnIgG8@public.gmane.org, lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org, hanjun.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, sudeep.holla-5wv7dgnIgG8@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, Charles.Garcia-Tobin-5wv7dgnIgG8@public.gmane.org, Geetha Sowjanya <geethasowjanya.akula-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>, geethasowjanya.akula-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, jcm-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, linu.cherian-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org, rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org, robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robert.richter-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org, lv.zheng-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, catalin.marinas-5wv7dgnIgG8@public.gmane.org, Geetha sowjanya <gakula-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>, sgoutham-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devel-E0kO6a4B6psdnm+yROfE0A@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

From: Geetha Sowjanya <geethasowjanya.akula-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>

Cavium ThunderX2 SMMU doesn't support MSI and also doesn't have unique irq
lines for gerror, eventq and cmdq-sync.

New named irq "combined" is set as a errata workaround, which allows to
share the irq line by register single irq handler for all the interrupts.

Signed-off-by: Geetha sowjanya <gakula-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>
---
 Documentation/arm64/silicon-errata.txt             |    1 +
 .../devicetree/bindings/iommu/arm,smmu-v3.txt      |    6 +
 drivers/acpi/arm64/iort.c                          |   54 +++++++----
 drivers/iommu/arm-smmu-v3.c                        |  100 ++++++++++++++-----
 4 files changed, 116 insertions(+), 45 deletions(-)

diff --git a/Documentation/arm64/silicon-errata.txt b/Documentation/arm64/silicon-errata.txt
index 4693a32..42422f6 100644
--- a/Documentation/arm64/silicon-errata.txt
+++ b/Documentation/arm64/silicon-errata.txt
@@ -63,6 +63,7 @@ stable kernels.
 | Cavium         | ThunderX Core   | #27456          | CAVIUM_ERRATUM_27456        |
 | Cavium         | ThunderX SMMUv2 | #27704          | N/A                         |
 | Cavium         | ThunderX2 SMMUv3| #74             | N/A                         |
+| Cavium         | ThunderX2 SMMUv3| #126            | N/A                         |
 |                |                 |                 |                             |
 | Freescale/NXP  | LS2080A/LS1043A | A-008585        | FSL_ERRATUM_A008585         |
 |                |                 |                 |                             |
diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu-v3.txt b/Documentation/devicetree/bindings/iommu/arm,smmu-v3.txt
index e7855cf..c9abbf3 100644
--- a/Documentation/devicetree/bindings/iommu/arm,smmu-v3.txt
+++ b/Documentation/devicetree/bindings/iommu/arm,smmu-v3.txt
@@ -26,6 +26,12 @@ the PCIe specification.
                       * "priq"      - PRI Queue not empty
                       * "cmdq-sync" - CMD_SYNC complete
                       * "gerror"    - Global Error activated
+                      * "combined"  - The combined interrupt is optional,
+				      and should only be provided if the
+				      hardware supports just a single,
+				      combined interrupt line.
+				      If provided, then the combined interrupt
+				      will be used in preference to any others.
 
 - #iommu-cells      : See the generic IOMMU binding described in
                         devicetree/bindings/pci/pci-iommu.txt
diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
index bd97b7d..4e9523b 100644
--- a/drivers/acpi/arm64/iort.c
+++ b/drivers/acpi/arm64/iort.c
@@ -828,6 +828,18 @@ static int __init arm_smmu_v3_count_resources(struct acpi_iort_node *node)
 	return num_res;
 }
 
+static bool arm_smmu_v3_is_combined_irq(struct acpi_iort_smmu_v3 *smmu)
+{
+	/*
+	 * Cavium ThunderX2 implementation doesn't not support unique
+	 * irq line. Use single irq line for all the SMMUv3 interrupts.
+	 */
+	if (smmu->model == ACPI_IORT_SMMU_V3_CAVIUM_CN99XX)
+		return true;
+
+	return false;
+}
+
 static unsigned long arm_smmu_v3_resource_size(struct acpi_iort_smmu_v3 *smmu)
 {
 	/*
@@ -855,26 +867,32 @@ static void __init arm_smmu_v3_init_resources(struct resource *res,
 	res[num_res].flags = IORESOURCE_MEM;
 
 	num_res++;
-
-	if (smmu->event_gsiv)
-		acpi_iort_register_irq(smmu->event_gsiv, "eventq",
-				       ACPI_EDGE_SENSITIVE,
-				       &res[num_res++]);
-
-	if (smmu->pri_gsiv)
-		acpi_iort_register_irq(smmu->pri_gsiv, "priq",
-				       ACPI_EDGE_SENSITIVE,
-				       &res[num_res++]);
-
-	if (smmu->gerr_gsiv)
-		acpi_iort_register_irq(smmu->gerr_gsiv, "gerror",
-				       ACPI_EDGE_SENSITIVE,
-				       &res[num_res++]);
-
-	if (smmu->sync_gsiv)
-		acpi_iort_register_irq(smmu->sync_gsiv, "cmdq-sync",
+	if (arm_smmu_v3_is_combined_irq(smmu))
+		acpi_iort_register_irq(smmu->event_gsiv, "combined",
 				       ACPI_EDGE_SENSITIVE,
 				       &res[num_res++]);
+	else {
+
+		if (smmu->event_gsiv)
+			acpi_iort_register_irq(smmu->event_gsiv, "eventq",
+					       ACPI_EDGE_SENSITIVE,
+					       &res[num_res++]);
+
+		if (smmu->pri_gsiv)
+			acpi_iort_register_irq(smmu->pri_gsiv, "priq",
+					       ACPI_EDGE_SENSITIVE,
+					       &res[num_res++]);
+
+		if (smmu->gerr_gsiv)
+			acpi_iort_register_irq(smmu->gerr_gsiv, "gerror",
+					       ACPI_EDGE_SENSITIVE,
+					       &res[num_res++]);
+
+		if (smmu->sync_gsiv)
+			acpi_iort_register_irq(smmu->sync_gsiv, "cmdq-sync",
+					       ACPI_EDGE_SENSITIVE,
+					       &res[num_res++]);
+	}
 }
 
 static bool __init arm_smmu_v3_is_coherent(struct acpi_iort_node *node)
diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 2dea4a9..fd5a48c 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -605,6 +605,7 @@ struct arm_smmu_device {
 	struct arm_smmu_priq		priq;
 
 	int				gerr_irq;
+	int				combined_irq;
 
 	unsigned long			ias; /* IPA */
 	unsigned long			oas; /* PA */
@@ -1314,6 +1315,24 @@ static irqreturn_t arm_smmu_gerror_handler(int irq, void *dev)
 	return IRQ_HANDLED;
 }
 
+static irqreturn_t arm_smmu_combined_irq_thread(int irq, void *dev)
+{
+	struct arm_smmu_device *smmu = dev;
+
+	arm_smmu_evtq_thread(irq, dev);
+	if (smmu->features & ARM_SMMU_FEAT_PRI)
+		arm_smmu_priq_thread(irq, dev);
+
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t arm_smmu_combined_irq_handler(int irq, void *dev)
+{
+	arm_smmu_gerror_handler(irq, dev);
+	arm_smmu_cmdq_sync_handler(irq, dev);
+	return IRQ_WAKE_THREAD;
+}
+
 /* IO_PGTABLE API */
 static void __arm_smmu_tlb_sync(struct arm_smmu_device *smmu)
 {
@@ -2230,18 +2249,9 @@ static void arm_smmu_setup_msis(struct arm_smmu_device *smmu)
 	devm_add_action(dev, arm_smmu_free_msis, dev);
 }
 
-static int arm_smmu_setup_irqs(struct arm_smmu_device *smmu)
+static void arm_smmu_setup_unique_irqs(struct arm_smmu_device *smmu)
 {
-	int ret, irq;
-	u32 irqen_flags = IRQ_CTRL_EVTQ_IRQEN | IRQ_CTRL_GERROR_IRQEN;
-
-	/* Disable IRQs first */
-	ret = arm_smmu_write_reg_sync(smmu, 0, ARM_SMMU_IRQ_CTRL,
-				      ARM_SMMU_IRQ_CTRLACK);
-	if (ret) {
-		dev_err(smmu->dev, "failed to disable irqs\n");
-		return ret;
-	}
+	int irq, ret;
 
 	arm_smmu_setup_msis(smmu);
 
@@ -2284,10 +2294,41 @@ static int arm_smmu_setup_irqs(struct arm_smmu_device *smmu)
 			if (ret < 0)
 				dev_warn(smmu->dev,
 					 "failed to enable priq irq\n");
-			else
-				irqen_flags |= IRQ_CTRL_PRIQ_IRQEN;
 		}
 	}
+}
+
+static int arm_smmu_setup_irqs(struct arm_smmu_device *smmu)
+{
+	int ret, irq;
+	u32 irqen_flags = IRQ_CTRL_EVTQ_IRQEN | IRQ_CTRL_GERROR_IRQEN;
+
+	/* Disable IRQs first */
+	ret = arm_smmu_write_reg_sync(smmu, 0, ARM_SMMU_IRQ_CTRL,
+				      ARM_SMMU_IRQ_CTRLACK);
+	if (ret) {
+		dev_err(smmu->dev, "failed to disable irqs\n");
+		return ret;
+	}
+
+	irq = smmu->combined_irq;
+	if (irq) {
+		/*
+		 * Cavium ThunderX2 implementation doesn't not support unique
+		 * irq lines. Use single irq line for all the SMMUv3 interrupts.
+		 */
+		ret = devm_request_threaded_irq(smmu->dev, irq,
+					arm_smmu_combined_irq_handler,
+					arm_smmu_combined_irq_thread,
+					IRQF_ONESHOT,
+					"arm-smmu-v3-combined-irq", smmu);
+		if (ret < 0)
+			dev_warn(smmu->dev, "failed to enable combined irq\n");
+	} else
+		arm_smmu_setup_unique_irqs(smmu);
+
+	if (smmu->features & ARM_SMMU_FEAT_PRI)
+		irqen_flags |= IRQ_CTRL_PRIQ_IRQEN;
 
 	/* Enable interrupt generation on the SMMU */
 	ret = arm_smmu_write_reg_sync(smmu, irqen_flags,
@@ -2724,22 +2765,27 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
 		return PTR_ERR(smmu->base);
 
 	/* Interrupt lines */
-	irq = platform_get_irq_byname(pdev, "eventq");
-	if (irq > 0)
-		smmu->evtq.q.irq = irq;
 
-	irq = platform_get_irq_byname(pdev, "priq");
+	irq = platform_get_irq_byname(pdev, "combined");
 	if (irq > 0)
-		smmu->priq.q.irq = irq;
+		smmu->combined_irq = irq;
+	else {
+		irq = platform_get_irq_byname(pdev, "eventq");
+		if (irq > 0)
+			smmu->evtq.q.irq = irq;
 
-	irq = platform_get_irq_byname(pdev, "cmdq-sync");
-	if (irq > 0)
-		smmu->cmdq.q.irq = irq;
+		irq = platform_get_irq_byname(pdev, "priq");
+		if (irq > 0)
+			smmu->priq.q.irq = irq;
 
-	irq = platform_get_irq_byname(pdev, "gerror");
-	if (irq > 0)
-		smmu->gerr_irq = irq;
+		irq = platform_get_irq_byname(pdev, "cmdq-sync");
+		if (irq > 0)
+			smmu->cmdq.q.irq = irq;
 
+		irq = platform_get_irq_byname(pdev, "gerror");
+		if (irq > 0)
+			smmu->gerr_irq = irq;
+	}
 	/* Probe the h/w */
 	ret = arm_smmu_device_hw_probe(smmu);
 	if (ret)
-- 
1.7.1
