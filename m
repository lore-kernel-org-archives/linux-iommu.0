From: Geetha sowjanya <gakula-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>
Subject: [v4 3/4] iommu/arm-smmu-v3: Add workaround for Cavium ThunderX2
	erratum #74
Date: Tue,  9 May 2017 17:15:13 +0530
Message-ID: <1494330314-30179-4-git-send-email-gakula@caviumnetworks.com>
References: <1494330314-30179-1-git-send-email-gakula@caviumnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1494330314-30179-1-git-send-email-gakula-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>
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
Cc: Geetha Sowjanya <geethasowjanya.akula-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>, jcm-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, linu.cherian-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, geethasowjanya.akula-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robert.richter-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org, catalin.marinas-5wv7dgnIgG8@public.gmane.org, sgoutham-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Charles.Garcia-Tobin-5wv7dgnIgG8@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

From: Linu Cherian <linu.cherian-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>

Cavium ThunderX2 SMMU implementation doesn't support page 1 register space
and PAGE0_REGS_ONLY option is enabled as an errata workaround.
This option when turned on, replaces all page 1 offsets used for
EVTQ_PROD/CONS, PRIQ_PROD/CONS register access with page 0 offsets.

SMMU resource size checks are now based on SMMU option PAGE0_REGS_ONLY,
since resource size can be either 64k/128k.
For this, arm_smmu_device_dt_probe/acpi_probe has been moved before
platform_get_resource call, so that SMMU options are set beforehand.

Signed-off-by: Linu Cherian <linu.cherian-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>
Signed-off-by: Geetha Sowjanya <geethasowjanya.akula-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>
---
 Documentation/arm64/silicon-errata.txt             |  1 +
 .../devicetree/bindings/iommu/arm,smmu-v3.txt      |  6 ++
 drivers/iommu/arm-smmu-v3.c                        | 80 ++++++++++++++++------
 3 files changed, 66 insertions(+), 21 deletions(-)

diff --git a/Documentation/arm64/silicon-errata.txt b/Documentation/arm64/silicon-errata.txt
index 10f2ddd..4693a32 100644
--- a/Documentation/arm64/silicon-errata.txt
+++ b/Documentation/arm64/silicon-errata.txt
@@ -62,6 +62,7 @@ stable kernels.
 | Cavium         | ThunderX GICv3  | #23154          | CAVIUM_ERRATUM_23154        |
 | Cavium         | ThunderX Core   | #27456          | CAVIUM_ERRATUM_27456        |
 | Cavium         | ThunderX SMMUv2 | #27704          | N/A                         |
+| Cavium         | ThunderX2 SMMUv3| #74             | N/A                         |
 |                |                 |                 |                             |
 | Freescale/NXP  | LS2080A/LS1043A | A-008585        | FSL_ERRATUM_A008585         |
 |                |                 |                 |                             |
diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu-v3.txt b/Documentation/devicetree/bindings/iommu/arm,smmu-v3.txt
index be57550..e6da62b 100644
--- a/Documentation/devicetree/bindings/iommu/arm,smmu-v3.txt
+++ b/Documentation/devicetree/bindings/iommu/arm,smmu-v3.txt
@@ -49,6 +49,12 @@ the PCIe specification.
 - hisilicon,broken-prefetch-cmd
                     : Avoid sending CMD_PREFETCH_* commands to the SMMU.
 
+- cavium-cn99xx,broken-page1-regspace
+                    : Replaces all page 1 offsets used for EVTQ_PROD/CONS,
+						PRIQ_PROD/CONS register access with page 0 offsets.
+						Set for Caviun ThunderX2 silicon that doesn't support
+						SMMU page1 register space.
+
 ** Example
 
         smmu@2b400000 {
diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 380969a..1e986a0 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -176,15 +176,15 @@
 #define ARM_SMMU_CMDQ_CONS		0x9c
 
 #define ARM_SMMU_EVTQ_BASE		0xa0
-#define ARM_SMMU_EVTQ_PROD		0x100a8
-#define ARM_SMMU_EVTQ_CONS		0x100ac
+#define ARM_SMMU_EVTQ_PROD(smmu)	(page1_offset_adjust(0x100a8, smmu))
+#define ARM_SMMU_EVTQ_CONS(smmu)	(page1_offset_adjust(0x100ac, smmu))
 #define ARM_SMMU_EVTQ_IRQ_CFG0		0xb0
 #define ARM_SMMU_EVTQ_IRQ_CFG1		0xb8
 #define ARM_SMMU_EVTQ_IRQ_CFG2		0xbc
 
 #define ARM_SMMU_PRIQ_BASE		0xc0
-#define ARM_SMMU_PRIQ_PROD		0x100c8
-#define ARM_SMMU_PRIQ_CONS		0x100cc
+#define ARM_SMMU_PRIQ_PROD(smmu)	(page1_offset_adjust(0x100c8, smmu))
+#define ARM_SMMU_PRIQ_CONS(smmu)	(page1_offset_adjust(0x100cc, smmu))
 #define ARM_SMMU_PRIQ_IRQ_CFG0		0xd0
 #define ARM_SMMU_PRIQ_IRQ_CFG1		0xd8
 #define ARM_SMMU_PRIQ_IRQ_CFG2		0xdc
@@ -412,6 +412,9 @@
 #define MSI_IOVA_BASE			0x8000000
 #define MSI_IOVA_LENGTH			0x100000
 
+#define ARM_SMMU_PAGE0_REGS_ONLY(smmu)		\
+	((smmu)->options & ARM_SMMU_OPT_PAGE0_REGS_ONLY)
+
 static bool disable_bypass;
 module_param_named(disable_bypass, disable_bypass, bool, S_IRUGO);
 MODULE_PARM_DESC(disable_bypass,
@@ -597,6 +600,7 @@ struct arm_smmu_device {
 	u32				features;
 
 #define ARM_SMMU_OPT_SKIP_PREFETCH	(1 << 0)
+#define ARM_SMMU_OPT_PAGE0_REGS_ONLY    (1 << 1)
 	u32				options;
 
 	struct arm_smmu_cmdq		cmdq;
@@ -663,9 +667,19 @@ struct arm_smmu_option_prop {
 
 static struct arm_smmu_option_prop arm_smmu_options[] = {
 	{ ARM_SMMU_OPT_SKIP_PREFETCH, "hisilicon,broken-prefetch-cmd" },
+	{ ARM_SMMU_OPT_PAGE0_REGS_ONLY, "cavium-cn99xx,broken-page1-regspace"},
 	{ 0, NULL},
 };
 
+static inline unsigned long page1_offset_adjust(
+	unsigned long off, struct arm_smmu_device *smmu)
+{
+	if (off > SZ_64K && ARM_SMMU_PAGE0_REGS_ONLY(smmu))
+		return (off - SZ_64K);
+
+	return off;
+}
+
 static struct arm_smmu_domain *to_smmu_domain(struct iommu_domain *dom)
 {
 	return container_of(dom, struct arm_smmu_domain, domain);
@@ -1986,8 +2000,10 @@ static int arm_smmu_init_queues(struct arm_smmu_device *smmu)
 		return ret;
 
 	/* evtq */
-	ret = arm_smmu_init_one_queue(smmu, &smmu->evtq.q, ARM_SMMU_EVTQ_PROD,
-				      ARM_SMMU_EVTQ_CONS, EVTQ_ENT_DWORDS);
+	ret = arm_smmu_init_one_queue(smmu, &smmu->evtq.q,
+				      ARM_SMMU_EVTQ_PROD(smmu),
+				      ARM_SMMU_EVTQ_CONS(smmu),
+				      EVTQ_ENT_DWORDS);
 	if (ret)
 		return ret;
 
@@ -1995,8 +2011,10 @@ static int arm_smmu_init_queues(struct arm_smmu_device *smmu)
 	if (!(smmu->features & ARM_SMMU_FEAT_PRI))
 		return 0;
 
-	return arm_smmu_init_one_queue(smmu, &smmu->priq.q, ARM_SMMU_PRIQ_PROD,
-				       ARM_SMMU_PRIQ_CONS, PRIQ_ENT_DWORDS);
+	return arm_smmu_init_one_queue(smmu, &smmu->priq.q,
+				       ARM_SMMU_PRIQ_PROD(smmu),
+				       ARM_SMMU_PRIQ_CONS(smmu),
+				       PRIQ_ENT_DWORDS);
 }
 
 static int arm_smmu_init_l1_strtab(struct arm_smmu_device *smmu)
@@ -2363,8 +2381,10 @@ static int arm_smmu_device_reset(struct arm_smmu_device *smmu, bool bypass)
 
 	/* Event queue */
 	writeq_relaxed(smmu->evtq.q.q_base, smmu->base + ARM_SMMU_EVTQ_BASE);
-	writel_relaxed(smmu->evtq.q.prod, smmu->base + ARM_SMMU_EVTQ_PROD);
-	writel_relaxed(smmu->evtq.q.cons, smmu->base + ARM_SMMU_EVTQ_CONS);
+	writel_relaxed(smmu->evtq.q.prod, smmu->base +
+		       ARM_SMMU_EVTQ_PROD(smmu));
+	writel_relaxed(smmu->evtq.q.cons, smmu->base +
+		       ARM_SMMU_EVTQ_CONS(smmu));
 
 	enables |= CR0_EVTQEN;
 	ret = arm_smmu_write_reg_sync(smmu, enables, ARM_SMMU_CR0,
@@ -2379,9 +2399,9 @@ static int arm_smmu_device_reset(struct arm_smmu_device *smmu, bool bypass)
 		writeq_relaxed(smmu->priq.q.q_base,
 			       smmu->base + ARM_SMMU_PRIQ_BASE);
 		writel_relaxed(smmu->priq.q.prod,
-			       smmu->base + ARM_SMMU_PRIQ_PROD);
+			       smmu->base + ARM_SMMU_PRIQ_PROD(smmu));
 		writel_relaxed(smmu->priq.q.cons,
-			       smmu->base + ARM_SMMU_PRIQ_CONS);
+			       smmu->base + ARM_SMMU_PRIQ_CONS(smmu));
 
 		enables |= CR0_PRIQEN;
 		ret = arm_smmu_write_reg_sync(smmu, enables, ARM_SMMU_CR0,
@@ -2605,6 +2625,14 @@ static int arm_smmu_device_hw_probe(struct arm_smmu_device *smmu)
 }
 
 #ifdef CONFIG_ACPI
+static void acpi_smmu_get_options(u32 model, struct arm_smmu_device *smmu)
+{
+	if (model == ACPI_IORT_SMMU_V3_CAVIUM_CN99XX)
+		smmu->options |= ARM_SMMU_OPT_PAGE0_REGS_ONLY;
+
+	dev_notice(smmu->dev, "option mask 0x%x\n", smmu->options);
+}
+
 static int arm_smmu_device_acpi_probe(struct platform_device *pdev,
 				      struct arm_smmu_device *smmu)
 {
@@ -2617,6 +2645,8 @@ static int arm_smmu_device_acpi_probe(struct platform_device *pdev,
 	/* Retrieve SMMUv3 specific data */
 	iort_smmu = (struct acpi_iort_smmu_v3 *)node->node_data;
 
+	acpi_smmu_get_options(iort_smmu->model, smmu);
+
 	if (iort_smmu->flags & ACPI_IORT_SMMU_V3_COHACC_OVERRIDE)
 		smmu->features |= ARM_SMMU_FEAT_COHERENCY;
 
@@ -2652,6 +2682,14 @@ static int arm_smmu_device_dt_probe(struct platform_device *pdev,
 	return ret;
 }
 
+static unsigned long arm_smmu_resource_size(struct arm_smmu_device *smmu)
+{
+	if (ARM_SMMU_PAGE0_REGS_ONLY(smmu))
+		return SZ_64K;
+	else
+		return SZ_128K;
+}
+
 static int arm_smmu_device_probe(struct platform_device *pdev)
 {
 	int irq, ret;
@@ -2668,9 +2706,17 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
 	}
 	smmu->dev = dev;
 
+	if (dev->of_node) {
+		ret = arm_smmu_device_dt_probe(pdev, smmu);
+	} else {
+		ret = arm_smmu_device_acpi_probe(pdev, smmu);
+		if (ret == -ENODEV)
+			return ret;
+	}
+
 	/* Base address */
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (resource_size(res) + 1 < SZ_128K) {
+	if (resource_size(res) + 1 < arm_smmu_resource_size(smmu)) {
 		dev_err(dev, "MMIO region too small (%pr)\n", res);
 		return -EINVAL;
 	}
@@ -2697,14 +2743,6 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
 	if (irq > 0)
 		smmu->gerr_irq = irq;
 
-	if (dev->of_node) {
-		ret = arm_smmu_device_dt_probe(pdev, smmu);
-	} else {
-		ret = arm_smmu_device_acpi_probe(pdev, smmu);
-		if (ret == -ENODEV)
-			return ret;
-	}
-
 	/* Set bypass mode according to firmware probing result */
 	bypass = !!ret;
 
-- 
1.8.3.1
