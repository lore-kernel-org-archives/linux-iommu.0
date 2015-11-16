From: <pmallapp@broadcom.com>
Subject: [PATCH] IOMMU: arm-smmu-v3: Use STE.S1STALLD only when supported
Date: Mon, 16 Nov 2015 14:18:20 +0530
Message-ID: <1447663700-13309-1-git-send-email-pmallapp@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: iommu@lists.linux-foundation.org, will.deacon@arm.com, linux-arm-kernel@lists.infradead.org
Cc: jchandra@broadcom.com, Prem Mallappa <pmallapp@broadcom.com>
List-Id: iommu@lists.linux-foundation.org

From: Prem Mallappa <pmallapp@broadcom.com>

Also fix the STALLD check.

Signed-off-by: Prem Mallappa <pmallapp@broadcom.com>
---
 drivers/iommu/arm-smmu-v3.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index ed409cb..804671c 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -38,7 +38,9 @@
 #define IDR0_ST_LVL_SHIFT		27
 #define IDR0_ST_LVL_MASK		0x3
 #define IDR0_ST_LVL_2LVL		(1 << IDR0_ST_LVL_SHIFT)
-#define IDR0_STALL_MODEL		(3 << 24)
+#define IDR0_STALL_SHIFT		24
+#define IDR0_STALL_MODEL_STALL		0x0
+#define IDR0_STALL_MODEL_FORCE		0x2
 #define IDR0_TTENDIAN_SHIFT		21
 #define IDR0_TTENDIAN_MASK		0x3
 #define IDR0_TTENDIAN_LE		(2 << IDR0_TTENDIAN_SHIFT)
@@ -1051,12 +1053,14 @@ static void arm_smmu_write_strtab_ent(struct arm_smmu_device *smmu, u32 sid,
 			 STRTAB_STE_1_S1C_CACHE_WBRA
 			 << STRTAB_STE_1_S1COR_SHIFT |
 			 STRTAB_STE_1_S1C_SH_ISH << STRTAB_STE_1_S1CSH_SHIFT |
-			 STRTAB_STE_1_S1STALLD |
 #ifdef CONFIG_PCI_ATS
 			 STRTAB_STE_1_EATS_TRANS << STRTAB_STE_1_EATS_SHIFT |
 #endif
 			 STRTAB_STE_1_STRW_NSEL1 << STRTAB_STE_1_STRW_SHIFT);
 
+		if (smmu->features & ARM_SMMU_FEAT_STALLS)
+			dst[1] |= cpu_to_le64(STRTAB_STE_1_S1STALLD);
+
 		val |= (ste->s1_cfg->cdptr_dma & STRTAB_STE_0_S1CTXPTR_MASK
 		        << STRTAB_STE_0_S1CTXPTR_SHIFT) |
 			STRTAB_STE_0_CFG_S1_TRANS;
@@ -2483,8 +2487,14 @@ static int arm_smmu_device_probe(struct arm_smmu_device *smmu)
 		dev_warn(smmu->dev, "IDR0.COHACC overridden by dma-coherent property (%s)\n",
 			 coherent ? "true" : "false");
 
-	if (reg & IDR0_STALL_MODEL)
+	switch ((reg >> IDR0_STALL_SHIFT) & 0x3) {
+	case IDR0_STALL_MODEL_STALL:
+	case IDR0_STALL_MODEL_FORCE:
 		smmu->features |= ARM_SMMU_FEAT_STALLS;
+		break;
+	default:
+		break;
+	}
 
 	if (reg & IDR0_S1P)
 		smmu->features |= ARM_SMMU_FEAT_TRANS_S1;
-- 
2.6.0
