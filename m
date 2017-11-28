From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH 3/4] iommu/arm-smmu-v3: Support 52-bit physical address
Date: Tue, 28 Nov 2017 17:27:06 +0000
Message-ID: <9bd8616795de1dec4b7afbedf89b06b7b027e162.1511807303.git.robin.murphy@arm.com>
References: <cover.1511807303.git.robin.murphy@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <cover.1511807303.git.robin.murphy-5wv7dgnIgG8@public.gmane.org>
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

Implement SMMUv3.1 support for 52-bit physical addresses. Since a 52-bit
OAS implies 64KB translation granule support, permitting level 1 block
entries there is simple, and the rest is just extending address fields.

Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
---
 drivers/iommu/arm-smmu-v3.c | 35 ++++++++++++++++++++---------------
 1 file changed, 20 insertions(+), 15 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 89bcd39d213c..e251762663c6 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -101,6 +101,7 @@
 #define IDR5_OAS_42_BIT			(3 << IDR5_OAS_SHIFT)
 #define IDR5_OAS_44_BIT			(4 << IDR5_OAS_SHIFT)
 #define IDR5_OAS_48_BIT			(5 << IDR5_OAS_SHIFT)
+#define IDR5_OAS_52_BIT			(6 << IDR5_OAS_SHIFT)
 
 #define ARM_SMMU_CR0			0x20
 #define CR0_CMDQEN			(1 << 3)
@@ -159,7 +160,7 @@
 
 #define ARM_SMMU_STRTAB_BASE		0x80
 #define STRTAB_BASE_RA			(1UL << 62)
-#define STRTAB_BASE_ADDR_MASK		GENMASK_ULL(47, 6)
+#define STRTAB_BASE_ADDR_MASK		GENMASK_ULL(51, 6)
 
 #define ARM_SMMU_STRTAB_BASE_CFG	0x88
 #define STRTAB_BASE_CFG_LOG2SIZE_SHIFT	0
@@ -190,7 +191,7 @@
 #define ARM_SMMU_PRIQ_IRQ_CFG2		0xdc
 
 /* Common MSI config fields */
-#define MSI_CFG0_ADDR_MASK		GENMASK_ULL(47, 2)
+#define MSI_CFG0_ADDR_MASK		GENMASK_ULL(51, 2)
 #define MSI_CFG2_SH_SHIFT		4
 #define MSI_CFG2_SH_NSH			(0UL << MSI_CFG2_SH_SHIFT)
 #define MSI_CFG2_SH_OSH			(2UL << MSI_CFG2_SH_SHIFT)
@@ -206,7 +207,7 @@
 					 Q_IDX(q, p) * (q)->ent_dwords)
 
 #define Q_BASE_RWA			(1UL << 62)
-#define Q_BASE_ADDR_MASK		GENMASK_ULL(47, 5)
+#define Q_BASE_ADDR_MASK		GENMASK_ULL(51, 5)
 #define Q_BASE_LOG2SIZE_SHIFT		0
 #define Q_BASE_LOG2SIZE_MASK		0x1fUL
 
@@ -223,7 +224,7 @@
 #define STRTAB_L1_DESC_DWORDS		1
 #define STRTAB_L1_DESC_SPAN_SHIFT	0
 #define STRTAB_L1_DESC_SPAN_MASK	0x1fUL
-#define STRTAB_L1_DESC_L2PTR_MASK	GENMASK_ULL(47, 6)
+#define STRTAB_L1_DESC_L2PTR_MASK	GENMASK_ULL(51, 6)
 
 #define STRTAB_STE_DWORDS		8
 #define STRTAB_STE_0_V			(1UL << 0)
@@ -236,7 +237,7 @@
 
 #define STRTAB_STE_0_S1FMT_SHIFT	4
 #define STRTAB_STE_0_S1FMT_LINEAR	(0UL << STRTAB_STE_0_S1FMT_SHIFT)
-#define STRTAB_STE_0_S1CTXPTR_MASK	GENMASK_ULL(47, 6)
+#define STRTAB_STE_0_S1CTXPTR_MASK	GENMASK_ULL(51, 6)
 #define STRTAB_STE_0_S1CDMAX_SHIFT	59
 #define STRTAB_STE_0_S1CDMAX_MASK	0x1fUL
 
@@ -274,7 +275,7 @@
 #define STRTAB_STE_2_S2PTW		(1UL << 54)
 #define STRTAB_STE_2_S2R		(1UL << 58)
 
-#define STRTAB_STE_3_S2TTB_MASK		GENMASK_ULL(47, 4)
+#define STRTAB_STE_3_S2TTB_MASK		GENMASK_ULL(51, 4)
 
 /* Context descriptor (stage-1 only) */
 #define CTXDESC_CD_DWORDS		8
@@ -320,7 +321,7 @@
 #define CTXDESC_CD_0_ASID_SHIFT		48
 #define CTXDESC_CD_0_ASID_MASK		0xffffUL
 
-#define CTXDESC_CD_1_TTB0_MASK		GENMASK_ULL(47, 4)
+#define CTXDESC_CD_1_TTB0_MASK		GENMASK_ULL(51, 4)
 
 #define CTXDESC_CD_3_MAIR_SHIFT		0
 
@@ -357,7 +358,7 @@
 #define CMDQ_TLBI_0_ASID_SHIFT		48
 #define CMDQ_TLBI_1_LEAF		(1UL << 0)
 #define CMDQ_TLBI_1_VA_MASK		GENMASK_ULL(63, 12)
-#define CMDQ_TLBI_1_IPA_MASK		GENMASK_ULL(47, 12)
+#define CMDQ_TLBI_1_IPA_MASK		GENMASK_ULL(51, 12)
 
 #define CMDQ_PRI_0_SSID_SHIFT		12
 #define CMDQ_PRI_0_SSID_MASK		0xfffffUL
@@ -380,7 +381,7 @@
 #define CMDQ_SYNC_0_MSIATTR_OIWB	(0xfUL << CMDQ_SYNC_0_MSIATTR_SHIFT)
 #define CMDQ_SYNC_0_MSIDATA_SHIFT	32
 #define CMDQ_SYNC_0_MSIDATA_MASK	0xffffffffUL
-#define CMDQ_SYNC_1_MSIADDR_MASK	GENMASK_ULL(47, 2)
+#define CMDQ_SYNC_1_MSIADDR_MASK	GENMASK_ULL(51, 2)
 
 /* Event queue */
 #define EVTQ_ENT_DWORDS			4
@@ -1687,7 +1688,7 @@ static int arm_smmu_domain_finalise(struct iommu_domain *domain)
 		return -ENOMEM;
 
 	domain->pgsize_bitmap = pgtbl_cfg.pgsize_bitmap;
-	domain->geometry.aperture_end = (1UL << ias) - 1;
+	domain->geometry.aperture_end = (1UL << pgtbl_cfg.ias) - 1;
 	domain->geometry.force_aperture = true;
 	smmu_domain->pgtbl_ops = pgtbl_ops;
 
@@ -2694,11 +2695,6 @@ static int arm_smmu_device_hw_probe(struct arm_smmu_device *smmu)
 	if (reg & IDR5_GRAN4K)
 		smmu->pgsize_bitmap |= SZ_4K | SZ_2M | SZ_1G;
 
-	if (arm_smmu_ops.pgsize_bitmap == -1UL)
-		arm_smmu_ops.pgsize_bitmap = smmu->pgsize_bitmap;
-	else
-		arm_smmu_ops.pgsize_bitmap |= smmu->pgsize_bitmap;
-
 	/* Output address size */
 	switch (reg & IDR5_OAS_MASK << IDR5_OAS_SHIFT) {
 	case IDR5_OAS_32_BIT:
@@ -2716,6 +2712,10 @@ static int arm_smmu_device_hw_probe(struct arm_smmu_device *smmu)
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
@@ -2724,6 +2724,11 @@ static int arm_smmu_device_hw_probe(struct arm_smmu_device *smmu)
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
2.13.4.dirty
