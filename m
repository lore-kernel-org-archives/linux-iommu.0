From: Prem Mallappa <pmallapp-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Subject: [PATCH v2] IOMMU: arm-smmu-v3: Use STE.S1STALLD only when supported
Date: Mon, 14 Dec 2015 22:01:23 +0530
Message-ID: <1450110683-32163-1-git-send-email-pmallapp@broadcom.com>
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
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: jchandra-dY08KVG/lbpWk0Htik3J/w@public.gmane.org, Prem Mallappa <pmallapp-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

It is ILLEGAL to set STE.S1STALLD to 1 if stage 1 is enabled and
either the stall or terminate models are not supported.
Also fix the STALLD check. which has wierd encoding.

Signed-off-by: Prem Mallappa <pmallapp-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
---
 drivers/iommu/arm-smmu-v3.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 4e5118a..d4af50d 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -40,7 +40,10 @@
 #define IDR0_ST_LVL_SHIFT		27
 #define IDR0_ST_LVL_MASK		0x3
 #define IDR0_ST_LVL_2LVL		(1 << IDR0_ST_LVL_SHIFT)
-#define IDR0_STALL_MODEL		(3 << 24)
+#define IDR0_STALL_SHIFT		24
+#define IDR0_STALL_MASK			0x3
+#define IDR0_STALL_MODEL_STALL		(0 << IDR0_STALL_SHIFT)
+#define IDR0_STALL_MODEL_FORCE		(2 << IDR0_STALL_SHIFT)
 #define IDR0_TTENDIAN_SHIFT		21
 #define IDR0_TTENDIAN_MASK		0x3
 #define IDR0_TTENDIAN_LE		(2 << IDR0_TTENDIAN_SHIFT)
@@ -1056,12 +1059,14 @@ static void arm_smmu_write_strtab_ent(struct arm_smmu_device *smmu, u32 sid,
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
@@ -2532,8 +2537,12 @@ static int arm_smmu_device_probe(struct arm_smmu_device *smmu)
 		dev_warn(smmu->dev, "IDR0.COHACC overridden by dma-coherent property (%s)\n",
 			 coherent ? "true" : "false");
 
-	if (reg & IDR0_STALL_MODEL)
+	switch (reg & (IDR0_STALL_MASK << IDR0_STALL_SHIFT)) {
+	case IDR0_STALL_MODEL_STALL:
+	case IDR0_STALL_MODEL_FORCE:
 		smmu->features |= ARM_SMMU_FEAT_STALLS;
+		break;
+	}
 
 	if (reg & IDR0_S1P)
 		smmu->features |= ARM_SMMU_FEAT_TRANS_S1;
-- 
2.6.0
