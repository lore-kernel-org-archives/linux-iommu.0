From: <tchalamarla-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>
Subject: [PATCH] iommu/arm-smmu-v2: Add support for 16 bit VMID
Date: Thu, 18 Feb 2016 10:23:37 -0800
Message-ID: <1455819817-8432-1-git-send-email-tchalamarla@caviumnetworks.com>
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
To: will.deacon-5wv7dgnIgG8@public.gmane.org, robin.murphy-5wv7dgnIgG8@public.gmane.org
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Geethasowjanya.Akula-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, tchalamarla-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

From: Tirumalesh Chalamarla <tchalamarla-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>

ARM-SMMUv2 supports upto 16 bit VMID. This patch enables
16 bit VMID when requested from device-tree.

Signed-off-by: Tirumalesh Chalamarla <tchalamarla-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>
---
 .../devicetree/bindings/iommu/arm,smmu.txt          |  2 ++
 drivers/iommu/arm-smmu.c                            | 21 ++++++++++++++++++++-
 2 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.txt b/Documentation/devicetree/bindings/iommu/arm,smmu.txt
index 7180745..bb7e569 100644
--- a/Documentation/devicetree/bindings/iommu/arm,smmu.txt
+++ b/Documentation/devicetree/bindings/iommu/arm,smmu.txt
@@ -55,6 +55,8 @@ conditions.
                   aliases of secure registers have to be used during
                   SMMU configuration.
 
+- smmu-enable-vmid16 : Enable 16 bit VMID, if allowed.
+
 Example:
 
         smmu {
diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 59ee4b8..003c442 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -93,6 +93,7 @@
 #define sCR0_VMIDPNE			(1 << 11)
 #define sCR0_PTM			(1 << 12)
 #define sCR0_FB				(1 << 13)
+#define sCR0_VMID16EN			(1 << 31)
 #define sCR0_BSU_SHIFT			14
 #define sCR0_BSU_MASK			0x3
 
@@ -140,6 +141,7 @@
 #define ID2_PTFS_4K			(1 << 12)
 #define ID2_PTFS_16K			(1 << 13)
 #define ID2_PTFS_64K			(1 << 14)
+#define ID2_VMID16			(1 << 15)
 
 /* Global TLB invalidation */
 #define ARM_SMMU_GR0_TLBIVMID		0x64
@@ -189,6 +191,8 @@
 #define ARM_SMMU_GR1_CBA2R(n)		(0x800 + ((n) << 2))
 #define CBA2R_RW64_32BIT		(0 << 0)
 #define CBA2R_RW64_64BIT		(1 << 0)
+#define CBA2R_VMID_SHIFT		16
+#define CBA2R_VMID_MASK			0xffff
 
 /* Translation context bank */
 #define ARM_SMMU_CB_BASE(smmu)		((smmu)->base + ((smmu)->size >> 1))
@@ -300,6 +304,7 @@ struct arm_smmu_device {
 	u32				features;
 
 #define ARM_SMMU_OPT_SECURE_CFG_ACCESS (1 << 0)
+#define ARM_SMMU_OPT_ENABLE_VMID16	(1 << 1)
 	u32				options;
 	enum arm_smmu_arch_version	version;
 
@@ -361,6 +366,7 @@ struct arm_smmu_option_prop {
 
 static struct arm_smmu_option_prop arm_smmu_options[] = {
 	{ ARM_SMMU_OPT_SECURE_CFG_ACCESS, "calxeda,smmu-secure-config-access" },
+	{ ARM_SMMU_OPT_ENABLE_VMID16, "smmu-enable-vmid16" },
 	{ 0, NULL},
 };
 
@@ -736,6 +742,10 @@ static void arm_smmu_init_context_bank(struct arm_smmu_domain *smmu_domain,
 #else
 		reg = CBA2R_RW64_32BIT;
 #endif
+		/* if 16bit VMID required set VMID in CBA2R */
+		if (smmu->options & ARM_SMMU_OPT_ENABLE_VMID16)
+			reg |= ARM_SMMU_CB_VMID(cfg) << CBA2R_VMID_SHIFT;
+
 		writel_relaxed(reg, gr1_base + ARM_SMMU_GR1_CBA2R(cfg->cbndx));
 	}
 
@@ -751,7 +761,8 @@ static void arm_smmu_init_context_bank(struct arm_smmu_domain *smmu_domain,
 	if (stage1) {
 		reg |= (CBAR_S1_BPSHCFG_NSH << CBAR_S1_BPSHCFG_SHIFT) |
 			(CBAR_S1_MEMATTR_WB << CBAR_S1_MEMATTR_SHIFT);
-	} else {
+	} else if (!(smmu->options & ARM_SMMU_OPT_ENABLE_VMID16)) {
+		/*16 bit VMID is not enabled set 8 bit VMID here */
 		reg |= ARM_SMMU_CB_VMID(cfg) << CBAR_VMID_SHIFT;
 	}
 	writel_relaxed(reg, gr1_base + ARM_SMMU_GR1_CBAR(cfg->cbndx));
@@ -1508,6 +1519,14 @@ static void arm_smmu_device_reset(struct arm_smmu_device *smmu)
 	/* Don't upgrade barriers */
 	reg &= ~(sCR0_BSU_MASK << sCR0_BSU_SHIFT);
 
+	/* See if 16bit VMID is required */
+	if (smmu->options & ARM_SMMU_OPT_ENABLE_VMID16) {
+		u32 id = readl_relaxed(gr0_base + ARM_SMMU_GR0_ID2);
+		/* Check to see if HW accepts */
+		if (id & ID2_VMID16)
+			reg |= (sCR0_VMID16EN);
+	}
+
 	/* Push the button */
 	__arm_smmu_tlb_sync(smmu);
 	writel(reg, ARM_SMMU_GR0_NS(smmu) + ARM_SMMU_GR0_sCR0);
-- 
2.1.0
