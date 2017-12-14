From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH v2 1/4] iommu/arm-smmu-v3: Clean up address masking
Date: Thu, 14 Dec 2017 16:58:50 +0000
Message-ID: <24f90689e35a90a337601943a48902a7ab6a7c4d.1512038236.git.robin.murphy@arm.com>
References: <cover.1512038236.git.robin.murphy@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <cover.1512038236.git.robin.murphy-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: will.deacon-5wv7dgnIgG8@public.gmane.org
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, kristina.martsenko-5wv7dgnIgG8@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, steve.capper-5wv7dgnIgG8@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Before trying to add the SMMUv3.1 support for 52-bit addresses, make
things bearable by cleaning up the various address mask definitions to
use GENMASK_ULL() consistently. The fact that doing so reveals (and
fixes) a latent off-by-one in Q_BASE_ADDR_MASK only goes to show what a
jolly good idea it is...

Tested-by: Nate Watterson <nwatters-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
---

v2: Clean up one more now-unnecessary linewrap

 drivers/iommu/arm-smmu-v3.c | 53 ++++++++++++++++++---------------------------
 1 file changed, 21 insertions(+), 32 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index f122071688fd..52cad776b31b 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -22,6 +22,7 @@
 
 #include <linux/acpi.h>
 #include <linux/acpi_iort.h>
+#include <linux/bitops.h>
 #include <linux/delay.h>
 #include <linux/dma-iommu.h>
 #include <linux/err.h>
@@ -158,8 +159,7 @@
 
 #define ARM_SMMU_STRTAB_BASE		0x80
 #define STRTAB_BASE_RA			(1UL << 62)
-#define STRTAB_BASE_ADDR_SHIFT		6
-#define STRTAB_BASE_ADDR_MASK		0x3ffffffffffUL
+#define STRTAB_BASE_ADDR_MASK		GENMASK_ULL(47, 6)
 
 #define ARM_SMMU_STRTAB_BASE_CFG	0x88
 #define STRTAB_BASE_CFG_LOG2SIZE_SHIFT	0
@@ -190,8 +190,7 @@
 #define ARM_SMMU_PRIQ_IRQ_CFG2		0xdc
 
 /* Common MSI config fields */
-#define MSI_CFG0_ADDR_SHIFT		2
-#define MSI_CFG0_ADDR_MASK		0x3fffffffffffUL
+#define MSI_CFG0_ADDR_MASK		GENMASK_ULL(47, 2)
 #define MSI_CFG2_SH_SHIFT		4
 #define MSI_CFG2_SH_NSH			(0UL << MSI_CFG2_SH_SHIFT)
 #define MSI_CFG2_SH_OSH			(2UL << MSI_CFG2_SH_SHIFT)
@@ -207,8 +206,7 @@
 					 Q_IDX(q, p) * (q)->ent_dwords)
 
 #define Q_BASE_RWA			(1UL << 62)
-#define Q_BASE_ADDR_SHIFT		5
-#define Q_BASE_ADDR_MASK		0xfffffffffffUL
+#define Q_BASE_ADDR_MASK		GENMASK_ULL(47, 5)
 #define Q_BASE_LOG2SIZE_SHIFT		0
 #define Q_BASE_LOG2SIZE_MASK		0x1fUL
 
@@ -225,8 +223,7 @@
 #define STRTAB_L1_DESC_DWORDS		1
 #define STRTAB_L1_DESC_SPAN_SHIFT	0
 #define STRTAB_L1_DESC_SPAN_MASK	0x1fUL
-#define STRTAB_L1_DESC_L2PTR_SHIFT	6
-#define STRTAB_L1_DESC_L2PTR_MASK	0x3ffffffffffUL
+#define STRTAB_L1_DESC_L2PTR_MASK	GENMASK_ULL(47, 6)
 
 #define STRTAB_STE_DWORDS		8
 #define STRTAB_STE_0_V			(1UL << 0)
@@ -239,8 +236,7 @@
 
 #define STRTAB_STE_0_S1FMT_SHIFT	4
 #define STRTAB_STE_0_S1FMT_LINEAR	(0UL << STRTAB_STE_0_S1FMT_SHIFT)
-#define STRTAB_STE_0_S1CTXPTR_SHIFT	6
-#define STRTAB_STE_0_S1CTXPTR_MASK	0x3ffffffffffUL
+#define STRTAB_STE_0_S1CTXPTR_MASK	GENMASK_ULL(47, 6)
 #define STRTAB_STE_0_S1CDMAX_SHIFT	59
 #define STRTAB_STE_0_S1CDMAX_MASK	0x1fUL
 
@@ -278,8 +274,7 @@
 #define STRTAB_STE_2_S2PTW		(1UL << 54)
 #define STRTAB_STE_2_S2R		(1UL << 58)
 
-#define STRTAB_STE_3_S2TTB_SHIFT	4
-#define STRTAB_STE_3_S2TTB_MASK		0xfffffffffffUL
+#define STRTAB_STE_3_S2TTB_MASK		GENMASK_ULL(47, 4)
 
 /* Context descriptor (stage-1 only) */
 #define CTXDESC_CD_DWORDS		8
@@ -325,8 +320,7 @@
 #define CTXDESC_CD_0_ASID_SHIFT		48
 #define CTXDESC_CD_0_ASID_MASK		0xffffUL
 
-#define CTXDESC_CD_1_TTB0_SHIFT		4
-#define CTXDESC_CD_1_TTB0_MASK		0xfffffffffffUL
+#define CTXDESC_CD_1_TTB0_MASK		GENMASK_ULL(47, 4)
 
 #define CTXDESC_CD_3_MAIR_SHIFT		0
 
@@ -351,7 +345,7 @@
 
 #define CMDQ_PREFETCH_0_SID_SHIFT	32
 #define CMDQ_PREFETCH_1_SIZE_SHIFT	0
-#define CMDQ_PREFETCH_1_ADDR_MASK	~0xfffUL
+#define CMDQ_PREFETCH_1_ADDR_MASK	GENMASK_ULL(63, 12)
 
 #define CMDQ_CFGI_0_SID_SHIFT		32
 #define CMDQ_CFGI_0_SID_MASK		0xffffffffUL
@@ -362,8 +356,8 @@
 #define CMDQ_TLBI_0_VMID_SHIFT		32
 #define CMDQ_TLBI_0_ASID_SHIFT		48
 #define CMDQ_TLBI_1_LEAF		(1UL << 0)
-#define CMDQ_TLBI_1_VA_MASK		~0xfffUL
-#define CMDQ_TLBI_1_IPA_MASK		0xfffffffff000UL
+#define CMDQ_TLBI_1_VA_MASK		GENMASK_ULL(63, 12)
+#define CMDQ_TLBI_1_IPA_MASK		GENMASK_ULL(47, 12)
 
 #define CMDQ_PRI_0_SSID_SHIFT		12
 #define CMDQ_PRI_0_SSID_MASK		0xfffffUL
@@ -386,8 +380,7 @@
 #define CMDQ_SYNC_0_MSIATTR_OIWB	(0xfUL << CMDQ_SYNC_0_MSIATTR_SHIFT)
 #define CMDQ_SYNC_0_MSIDATA_SHIFT	32
 #define CMDQ_SYNC_0_MSIDATA_MASK	0xffffffffUL
-#define CMDQ_SYNC_1_MSIADDR_SHIFT	0
-#define CMDQ_SYNC_1_MSIADDR_MASK	0xffffffffffffcUL
+#define CMDQ_SYNC_1_MSIADDR_MASK	GENMASK_ULL(47, 2)
 
 /* Event queue */
 #define EVTQ_ENT_DWORDS			4
@@ -413,8 +406,7 @@
 
 #define PRIQ_1_PRG_IDX_SHIFT		0
 #define PRIQ_1_PRG_IDX_MASK		0x1ffUL
-#define PRIQ_1_ADDR_SHIFT		12
-#define PRIQ_1_ADDR_MASK		0xfffffffffffffUL
+#define PRIQ_1_ADDR_MASK		GENMASK_ULL(63, 12)
 
 /* High-level queue structures */
 #define ARM_SMMU_POLL_TIMEOUT_US	100
@@ -1093,7 +1085,7 @@ static void arm_smmu_write_ctx_desc(struct arm_smmu_device *smmu,
 
 	cfg->cdptr[0] = cpu_to_le64(val);
 
-	val = cfg->cd.ttbr & CTXDESC_CD_1_TTB0_MASK << CTXDESC_CD_1_TTB0_SHIFT;
+	val = cfg->cd.ttbr & CTXDESC_CD_1_TTB0_MASK;
 	cfg->cdptr[1] = cpu_to_le64(val);
 
 	cfg->cdptr[3] = cpu_to_le64(cfg->cd.mair << CTXDESC_CD_3_MAIR_SHIFT);
@@ -1107,8 +1099,7 @@ arm_smmu_write_strtab_l1_desc(__le64 *dst, struct arm_smmu_strtab_l1_desc *desc)
 
 	val |= (desc->span & STRTAB_L1_DESC_SPAN_MASK)
 		<< STRTAB_L1_DESC_SPAN_SHIFT;
-	val |= desc->l2ptr_dma &
-	       STRTAB_L1_DESC_L2PTR_MASK << STRTAB_L1_DESC_L2PTR_SHIFT;
+	val |= desc->l2ptr_dma & STRTAB_L1_DESC_L2PTR_MASK;
 
 	*dst = cpu_to_le64(val);
 }
@@ -1214,8 +1205,7 @@ static void arm_smmu_write_strtab_ent(struct arm_smmu_device *smmu, u32 sid,
 		   !(smmu->features & ARM_SMMU_FEAT_STALL_FORCE))
 			dst[1] |= cpu_to_le64(STRTAB_STE_1_S1STALLD);
 
-		val |= (ste->s1_cfg->cdptr_dma & STRTAB_STE_0_S1CTXPTR_MASK
-		        << STRTAB_STE_0_S1CTXPTR_SHIFT) |
+		val |= (ste->s1_cfg->cdptr_dma & STRTAB_STE_0_S1CTXPTR_MASK) |
 			STRTAB_STE_0_CFG_S1_TRANS;
 	}
 
@@ -1232,7 +1222,7 @@ static void arm_smmu_write_strtab_ent(struct arm_smmu_device *smmu, u32 sid,
 			 STRTAB_STE_2_S2R);
 
 		dst[3] = cpu_to_le64(ste->s2_cfg->vttbr &
-			 STRTAB_STE_3_S2TTB_MASK << STRTAB_STE_3_S2TTB_SHIFT);
+			 STRTAB_STE_3_S2TTB_MASK);
 
 		val |= STRTAB_STE_0_CFG_S2_TRANS;
 	}
@@ -1337,7 +1327,7 @@ static void arm_smmu_handle_ppr(struct arm_smmu_device *smmu, u64 *evt)
 		 evt[0] & PRIQ_0_PERM_READ ? "R" : "",
 		 evt[0] & PRIQ_0_PERM_WRITE ? "W" : "",
 		 evt[0] & PRIQ_0_PERM_EXEC ? "X" : "",
-		 evt[1] & PRIQ_1_ADDR_MASK << PRIQ_1_ADDR_SHIFT);
+		 evt[1] & PRIQ_1_ADDR_MASK);
 
 	if (last) {
 		struct arm_smmu_cmdq_ent cmd = {
@@ -2093,7 +2083,7 @@ static int arm_smmu_init_one_queue(struct arm_smmu_device *smmu,
 	q->ent_dwords	= dwords;
 
 	q->q_base  = Q_BASE_RWA;
-	q->q_base |= q->base_dma & Q_BASE_ADDR_MASK << Q_BASE_ADDR_SHIFT;
+	q->q_base |= q->base_dma & Q_BASE_ADDR_MASK;
 	q->q_base |= (q->max_n_shift & Q_BASE_LOG2SIZE_MASK)
 		     << Q_BASE_LOG2SIZE_SHIFT;
 
@@ -2230,8 +2220,7 @@ static int arm_smmu_init_strtab(struct arm_smmu_device *smmu)
 		return ret;
 
 	/* Set the strtab base address */
-	reg  = smmu->strtab_cfg.strtab_dma &
-	       STRTAB_BASE_ADDR_MASK << STRTAB_BASE_ADDR_SHIFT;
+	reg  = smmu->strtab_cfg.strtab_dma & STRTAB_BASE_ADDR_MASK;
 	reg |= STRTAB_BASE_RA;
 	smmu->strtab_cfg.strtab_base = reg;
 
@@ -2294,7 +2283,7 @@ static void arm_smmu_write_msi_msg(struct msi_desc *desc, struct msi_msg *msg)
 	phys_addr_t *cfg = arm_smmu_msi_cfg[desc->platform.msi_index];
 
 	doorbell = (((u64)msg->address_hi) << 32) | msg->address_lo;
-	doorbell &= MSI_CFG0_ADDR_MASK << MSI_CFG0_ADDR_SHIFT;
+	doorbell &= MSI_CFG0_ADDR_MASK;
 
 	writeq_relaxed(doorbell, smmu->base + cfg[0]);
 	writel_relaxed(msg->data, smmu->base + cfg[1]);
-- 
2.13.4.dirty
