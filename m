From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH v3 6/7] iommu/arm-smmu-v3: Support 52-bit physical address
Date: Mon, 26 Mar 2018 13:35:14 +0100
Message-ID: <ac6480ad02818a46e560a714633ffb194acff5f2.1522065584.git.robin.murphy@arm.com>
References: <cover.1522065583.git.robin.murphy@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <cover.1522065583.git.robin.murphy-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: will.deacon-5wv7dgnIgG8@public.gmane.org, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Implement SMMUv3.1 support for 52-bit physical addresses. Since a 52-bit
OAS implies 64KB translation granule support, permitting level 1 block
entries there is simple, and the rest is just extending address fields.

Tested-by: Nate Watterson <nwatters-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
---

v3: No change

 drivers/iommu/arm-smmu-v3.c | 35 ++++++++++++++++++++---------------
 1 file changed, 20 insertions(+), 15 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 4e0ffda217f6..e0d46661c153 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -91,6 +91,7 @@
 #define IDR5_OAS_42_BIT			3
 #define IDR5_OAS_44_BIT			4
 #define IDR5_OAS_48_BIT			5
+#define IDR5_OAS_52_BIT			6
 
 #define ARM_SMMU_CR0			0x20
 #define CR0_CMDQEN			(1 << 3)
@@ -147,7 +148,7 @@
 
 #define ARM_SMMU_STRTAB_BASE		0x80
 #define STRTAB_BASE_RA			(1UL << 62)
-#define STRTAB_BASE_ADDR_MASK		GENMASK_ULL(47, 6)
+#define STRTAB_BASE_ADDR_MASK		GENMASK_ULL(51, 6)
 
 #define ARM_SMMU_STRTAB_BASE_CFG	0x88
 #define STRTAB_BASE_CFG_FMT		GENMASK(17, 16)
@@ -175,7 +176,7 @@
 #define ARM_SMMU_PRIQ_IRQ_CFG2		0xdc
 
 /* Common MSI config fields */
-#define MSI_CFG0_ADDR_MASK		GENMASK_ULL(47, 2)
+#define MSI_CFG0_ADDR_MASK		GENMASK_ULL(51, 2)
 #define MSI_CFG2_SH			GENMASK(5, 4)
 #define MSI_CFG2_MEMATTR		GENMASK(3, 0)
 
@@ -194,7 +195,7 @@
 					 Q_IDX(q, p) * (q)->ent_dwords)
 
 #define Q_BASE_RWA			(1UL << 62)
-#define Q_BASE_ADDR_MASK		GENMASK_ULL(47, 5)
+#define Q_BASE_ADDR_MASK		GENMASK_ULL(51, 5)
 #define Q_BASE_LOG2SIZE			GENMASK(4, 0)
 
 /*
@@ -209,7 +210,7 @@
 
 #define STRTAB_L1_DESC_DWORDS		1
 #define STRTAB_L1_DESC_SPAN		GENMASK_ULL(4, 0)
-#define STRTAB_L1_DESC_L2PTR_MASK	GENMASK_ULL(47, 6)
+#define STRTAB_L1_DESC_L2PTR_MASK	GENMASK_ULL(51, 6)
 
 #define STRTAB_STE_DWORDS		8
 #define STRTAB_STE_0_V			(1UL << 0)
@@ -221,7 +222,7 @@
 
 #define STRTAB_STE_0_S1FMT		GENMASK_ULL(5, 4)
 #define STRTAB_STE_0_S1FMT_LINEAR	0
-#define STRTAB_STE_0_S1CTXPTR_MASK	GENMASK_ULL(47, 6)
+#define STRTAB_STE_0_S1CTXPTR_MASK	GENMASK_ULL(51, 6)
 #define STRTAB_STE_0_S1CDMAX		GENMASK_ULL(63, 59)
 
 #define STRTAB_STE_1_S1C_CACHE_NC	0UL
@@ -253,7 +254,7 @@
 #define STRTAB_STE_2_S2PTW		(1UL << 54)
 #define STRTAB_STE_2_S2R		(1UL << 58)
 
-#define STRTAB_STE_3_S2TTB_MASK		GENMASK_ULL(47, 4)
+#define STRTAB_STE_3_S2TTB_MASK		GENMASK_ULL(51, 4)
 
 /* Context descriptor (stage-1 only) */
 #define CTXDESC_CD_DWORDS		8
@@ -287,7 +288,7 @@
 #define CTXDESC_CD_0_ASET		(1UL << 47)
 #define CTXDESC_CD_0_ASID		GENMASK_ULL(63, 48)
 
-#define CTXDESC_CD_1_TTB0_MASK		GENMASK_ULL(47, 4)
+#define CTXDESC_CD_1_TTB0_MASK		GENMASK_ULL(51, 4)
 
 /* Convert between AArch64 (CPU) TCR format and SMMU CD format */
 #define ARM_SMMU_TCR2CD(tcr, fld)	FIELD_PREP(CTXDESC_CD_0_TCR_##fld, \
@@ -317,7 +318,7 @@
 #define CMDQ_TLBI_0_ASID		GENMASK_ULL(63, 48)
 #define CMDQ_TLBI_1_LEAF		(1UL << 0)
 #define CMDQ_TLBI_1_VA_MASK		GENMASK_ULL(63, 12)
-#define CMDQ_TLBI_1_IPA_MASK		GENMASK_ULL(47, 12)
+#define CMDQ_TLBI_1_IPA_MASK		GENMASK_ULL(51, 12)
 
 #define CMDQ_PRI_0_SSID			GENMASK_ULL(31, 12)
 #define CMDQ_PRI_0_SID			GENMASK_ULL(63, 32)
@@ -331,7 +332,7 @@
 #define CMDQ_SYNC_0_MSH			GENMASK_ULL(23, 22)
 #define CMDQ_SYNC_0_MSIATTR		GENMASK_ULL(27, 24)
 #define CMDQ_SYNC_0_MSIDATA		GENMASK_ULL(63, 32)
-#define CMDQ_SYNC_1_MSIADDR_MASK	GENMASK_ULL(47, 2)
+#define CMDQ_SYNC_1_MSIADDR_MASK	GENMASK_ULL(51, 2)
 
 /* Event queue */
 #define EVTQ_ENT_DWORDS			4
@@ -1622,7 +1623,7 @@ static int arm_smmu_domain_finalise(struct iommu_domain *domain)
 		return -ENOMEM;
 
 	domain->pgsize_bitmap = pgtbl_cfg.pgsize_bitmap;
-	domain->geometry.aperture_end = (1UL << ias) - 1;
+	domain->geometry.aperture_end = (1UL << pgtbl_cfg.ias) - 1;
 	domain->geometry.force_aperture = true;
 
 	ret = finalise_stage_fn(smmu_domain, &pgtbl_cfg);
@@ -2633,11 +2634,6 @@ static int arm_smmu_device_hw_probe(struct arm_smmu_device *smmu)
 	if (reg & IDR5_GRAN4K)
 		smmu->pgsize_bitmap |= SZ_4K | SZ_2M | SZ_1G;
 
-	if (arm_smmu_ops.pgsize_bitmap == -1UL)
-		arm_smmu_ops.pgsize_bitmap = smmu->pgsize_bitmap;
-	else
-		arm_smmu_ops.pgsize_bitmap |= smmu->pgsize_bitmap;
-
 	/* Output address size */
 	switch (FIELD_GET(IDR5_OAS, reg)) {
 	case IDR5_OAS_32_BIT:
@@ -2655,6 +2651,10 @@ static int arm_smmu_device_hw_probe(struct arm_smmu_device *smmu)
 	case IDR5_OAS_44_BIT:
 		smmu->oas = 44;
 		break;
+	case IDR5_OAS_52_BIT:
+		smmu->oas = 52;
+		smmu->pgsize_bitmap |= 1ULL << 42; /* 4TB */
+		break;
 	default:
 		dev_info(smmu->dev,
 			"unknown output address size. Truncating to 48-bit\n");
@@ -2663,6 +2663,11 @@ static int arm_smmu_device_hw_probe(struct arm_smmu_device *smmu)
 		smmu->oas = 48;
 	}
 
+	if (arm_smmu_ops.pgsize_bitmap == -1UL)
+		arm_smmu_ops.pgsize_bitmap = smmu->pgsize_bitmap;
+	else
+		arm_smmu_ops.pgsize_bitmap |= smmu->pgsize_bitmap;
+
 	/* Set the DMA mask for our table walker */
 	if (dma_set_mask_and_coherent(smmu->dev, DMA_BIT_MASK(smmu->oas)))
 		dev_warn(smmu->dev,
-- 
2.16.1.dirty
