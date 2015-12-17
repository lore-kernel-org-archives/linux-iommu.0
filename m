From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH 12/13] iommu/arm-smmu: Use STE.S1STALLD only when supported
Date: Thu, 17 Dec 2015 12:12:12 +0000
Message-ID: <1450354333-27256-13-git-send-email-will.deacon@arm.com>
References: <1450354333-27256-1-git-send-email-will.deacon@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1450354333-27256-1-git-send-email-will.deacon-5wv7dgnIgG8@public.gmane.org>
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
Cc: jroedel-l3A5Bk7waGM@public.gmane.org, pmallapp-dY08KVG/lbpWk0Htik3J/w@public.gmane.org, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, zhangbo_a-95E7rUnPDLLQT0dZR+AlfA@public.gmane.org, laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org, van.freenix-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, elfring-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

From: Prem Mallappa <pmallapp-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>

It is ILLEGAL to set STE.S1STALLD to 1 if stage 1 is enabled and
either the stall or terminate models are not supported.

This patch fixes the STALLD check and ensures that we don't set STALLD
in the STE when it is not supported.

Signed-off-by: Prem Mallappa <pmallapp-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
[will: consistently use IDR0_STALL_MODEL_* prefix]
Signed-off-by: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
---
 drivers/iommu/arm-smmu-v3.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 488f763877d2..20875341c865 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -40,7 +40,10 @@
 #define IDR0_ST_LVL_SHIFT		27
 #define IDR0_ST_LVL_MASK		0x3
 #define IDR0_ST_LVL_2LVL		(1 << IDR0_ST_LVL_SHIFT)
-#define IDR0_STALL_MODEL		(3 << 24)
+#define IDR0_STALL_MODEL_SHIFT		24
+#define IDR0_STALL_MODEL_MASK		0x3
+#define IDR0_STALL_MODEL_STALL		(0 << IDR0_STALL_MODEL_SHIFT)
+#define IDR0_STALL_MODEL_FORCE		(2 << IDR0_STALL_MODEL_SHIFT)
 #define IDR0_TTENDIAN_SHIFT		21
 #define IDR0_TTENDIAN_MASK		0x3
 #define IDR0_TTENDIAN_LE		(2 << IDR0_TTENDIAN_SHIFT)
@@ -1062,12 +1065,14 @@ static void arm_smmu_write_strtab_ent(struct arm_smmu_device *smmu, u32 sid,
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
@@ -2464,8 +2469,12 @@ static int arm_smmu_device_probe(struct arm_smmu_device *smmu)
 		dev_warn(smmu->dev, "IDR0.COHACC overridden by dma-coherent property (%s)\n",
 			 coherent ? "true" : "false");
 
-	if (reg & IDR0_STALL_MODEL)
+	switch (reg & IDR0_STALL_MODEL_MASK << IDR0_STALL_MODEL_SHIFT) {
+	case IDR0_STALL_MODEL_STALL:
+		/* Fallthrough */
+	case IDR0_STALL_MODEL_FORCE:
 		smmu->features |= ARM_SMMU_FEAT_STALLS;
+	}
 
 	if (reg & IDR0_S1P)
 		smmu->features |= ARM_SMMU_FEAT_TRANS_S1;
-- 
2.1.4
