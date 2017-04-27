From: Geetha sowjanya <gakula-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>
Subject: [PATCH 2/3] iommu/arm-smmu-v3: Add workaround for Cavium ThunderX2
	erratum #74
Date: Thu, 27 Apr 2017 17:16:23 +0530
Message-ID: <1493293584-20287-3-git-send-email-gakula@caviumnetworks.com>
References: <1493293584-20287-1-git-send-email-gakula@caviumnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1493293584-20287-1-git-send-email-gakula-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>
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
Cc: jcm-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, linu.cherian-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, geethasowjanya.akula-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robert.richter-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org, catalin.marinas-5wv7dgnIgG8@public.gmane.org, Geetha <gakula-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>, sgoutham-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

From: Linu Cherian <linu.cherian-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org> 

Cavium 99xx SMMU implementation doesn't support page 1 register space.
Based on silicon id, ARM_SMMU_PAGE0_REGS_ONLY macro is set as an errata
workaround.

This macro when set, replaces all page 1 offsets used for
EVTQ_PROD/CONS, PRIQ_PROD/CONS register access with page 0 offsets.

Signed-off-by: Linu Cherian <linu.cherian-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>
Signed-off-by: Geetha <gakula-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>
---
 Documentation/arm64/silicon-errata.txt |  1 +
 drivers/acpi/arm64/iort.c              | 14 +++++++++++++-
 drivers/iommu/arm-smmu-v3.c            | 32 +++++++++++++++++++++++++++-----
 3 files changed, 41 insertions(+), 6 deletions(-)

diff --git a/Documentation/arm64/silicon-errata.txt b/Documentation/arm64/silicon-errata.txt
index 2f66683..629e2ce 100644
--- a/Documentation/arm64/silicon-errata.txt
+++ b/Documentation/arm64/silicon-errata.txt
@@ -61,6 +61,7 @@ stable kernels.
 | Cavium         | ThunderX GICv3  | #23154          | CAVIUM_ERRATUM_23154        |
 | Cavium         | ThunderX Core   | #27456          | CAVIUM_ERRATUM_27456        |
 | Cavium         | ThunderX SMMUv2 | #27704          | N/A                         |
+| Cavium         | ThunderX2 SMMUv3| #74             | N/A                         |
 |                |                 |                 |                             |
 | Freescale/NXP  | LS2080A/LS1043A | A-008585        | FSL_ERRATUM_A008585         |
 |                |                 |                 |                             |
diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
index 4a5bb96..a074ce9 100644
--- a/drivers/acpi/arm64/iort.c
+++ b/drivers/acpi/arm64/iort.c
@@ -25,6 +25,7 @@
 #include <linux/pci.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
+#include <asm/cputype.h>
 
 #define IORT_TYPE_MASK(type)	(1 << (type))
 #define IORT_MSI_TYPE		(1 << ACPI_IORT_NODE_ITS_GROUP)
@@ -669,12 +670,23 @@ static void __init arm_smmu_v3_init_resources(struct resource *res,
 {
 	struct acpi_iort_smmu_v3 *smmu;
 	int num_res = 0;
+	u32 cpu_model;
+	unsigned long size = SZ_128K;
 
 	/* Retrieve SMMUv3 specific data */
 	smmu = (struct acpi_iort_smmu_v3 *)node->node_data;
 
+	/*
+	 * Override the size, for Cavium CN99xx implementations
+	 * which doesn't support the page 1 SMMU register space.
+	 */
+	cpu_model = read_cpuid_id() & MIDR_CPU_MODEL_MASK;
+	if (cpu_model == MIDR_THUNDERX_99XX ||
+	    cpu_model == MIDR_BRCM_VULCAN)
+		size = SZ_64K;
+
 	res[num_res].start = smmu->base_address;
-	res[num_res].end = smmu->base_address + SZ_128K - 1;
+	res[num_res].end = smmu->base_address + size - 1;
 	res[num_res].flags = IORESOURCE_MEM;
 
 	num_res++;
diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 1dcd154..ee23ccd 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -38,6 +38,7 @@
 #include <linux/platform_device.h>
 
 #include <linux/amba/bus.h>
+#include <asm/cputype.h>
 
 #include "io-pgtable.h"
 
@@ -176,15 +177,15 @@
 #define ARM_SMMU_CMDQ_CONS		0x9c
 
 #define ARM_SMMU_EVTQ_BASE		0xa0
-#define ARM_SMMU_EVTQ_PROD		0x100a8
-#define ARM_SMMU_EVTQ_CONS		0x100ac
+#define ARM_SMMU_EVTQ_PROD		(page1_offset_adjust(0x100a8))
+#define ARM_SMMU_EVTQ_CONS		(page1_offset_adjust(0x100ac))
 #define ARM_SMMU_EVTQ_IRQ_CFG0		0xb0
 #define ARM_SMMU_EVTQ_IRQ_CFG1		0xb8
 #define ARM_SMMU_EVTQ_IRQ_CFG2		0xbc
 
 #define ARM_SMMU_PRIQ_BASE		0xc0
-#define ARM_SMMU_PRIQ_PROD		0x100c8
-#define ARM_SMMU_PRIQ_CONS		0x100cc
+#define ARM_SMMU_PRIQ_PROD		(page1_offset_adjust(0x100c8))
+#define ARM_SMMU_PRIQ_CONS		(page1_offset_adjust(0x100cc))
 #define ARM_SMMU_PRIQ_IRQ_CFG0		0xd0
 #define ARM_SMMU_PRIQ_IRQ_CFG1		0xd8
 #define ARM_SMMU_PRIQ_IRQ_CFG2		0xdc
@@ -412,6 +413,10 @@
 #define MSI_IOVA_BASE			0x8000000
 #define MSI_IOVA_LENGTH			0x100000
 
+#define ARM_SMMU_PAGE0_REGS_ONLY		\
+	(((read_cpuid_id() & MIDR_CPU_MODEL_MASK) == MIDR_THUNDERX_99XX) \
+	|| ((read_cpuid_id() & MIDR_CPU_MODEL_MASK) == MIDR_BRCM_VULCAN))
+
 static bool disable_bypass;
 module_param_named(disable_bypass, disable_bypass, bool, S_IRUGO);
 MODULE_PARM_DESC(disable_bypass,
@@ -660,6 +665,15 @@ struct arm_smmu_option_prop {
 	{ 0, NULL},
 };
 
+static inline unsigned long page1_offset_adjust(
+	unsigned long off)
+{
+	if (!ARM_SMMU_PAGE0_REGS_ONLY)
+		return off;
+	else
+		return (off - SZ_64K);
+}
+
 static struct arm_smmu_domain *to_smmu_domain(struct iommu_domain *dom)
 {
 	return container_of(dom, struct arm_smmu_domain, domain);
@@ -2631,6 +2645,14 @@ static int arm_smmu_device_dt_probe(struct platform_device *pdev,
 	return ret;
 }
 
+static unsigned long arm_smmu_resource_size(void)
+{
+	if (ARM_SMMU_PAGE0_REGS_ONLY)
+		return SZ_64K;
+	else
+		return SZ_128K;
+}
+
 static int arm_smmu_device_probe(struct platform_device *pdev)
 {
 	int irq, ret;
@@ -2649,7 +2671,7 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
 
 	/* Base address */
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (resource_size(res) + 1 < SZ_128K) {
+	if (resource_size(res) + 1 < arm_smmu_resource_size()) {
 		dev_err(dev, "MMIO region too small (%pr)\n", res);
 		return -EINVAL;
 	}
-- 
1.9.1
