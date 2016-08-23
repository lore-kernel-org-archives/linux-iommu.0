From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH v5 07/19] iommu/arm-smmu: Set PRIVCFG in stage 1 STEs
Date: Tue, 23 Aug 2016 20:05:18 +0100
Message-ID: <1cda9861ce3ede6c2de9c6c4f2294549808b421b.1471975357.git.robin.murphy@arm.com>
References: <cover.1471975357.git.robin.murphy@arm.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cover.1471975357.git.robin.murphy-5wv7dgnIgG8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org, jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org, punit.agrawal-5wv7dgnIgG8@public.gmane.org, thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Implement the SMMUv3 equivalent of d346180e70b9 ("iommu/arm-smmu: Treat
all device transactions as unprivileged"), so that once again those
pesky DMA controllers with their privileged instruction fetches don't
unexpectedly fault in stage 1 domains due to VMSAv8 rules.

Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
---
 drivers/iommu/arm-smmu-v3.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index e0384f7afb03..72b996aa7460 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -263,6 +263,9 @@
 #define STRTAB_STE_1_SHCFG_INCOMING	1UL
 #define STRTAB_STE_1_SHCFG_SHIFT	44
 
+#define STRTAB_STE_1_PRIVCFG_UNPRIV	2UL
+#define STRTAB_STE_1_PRIVCFG_SHIFT	48
+
 #define STRTAB_STE_2_S2VMID_SHIFT	0
 #define STRTAB_STE_2_S2VMID_MASK	0xffffUL
 #define STRTAB_STE_2_VTCR_SHIFT		32
@@ -1073,7 +1076,9 @@ static void arm_smmu_write_strtab_ent(struct arm_smmu_device *smmu, u32 sid,
 #ifdef CONFIG_PCI_ATS
 			 STRTAB_STE_1_EATS_TRANS << STRTAB_STE_1_EATS_SHIFT |
 #endif
-			 STRTAB_STE_1_STRW_NSEL1 << STRTAB_STE_1_STRW_SHIFT);
+			 STRTAB_STE_1_STRW_NSEL1 << STRTAB_STE_1_STRW_SHIFT |
+			 STRTAB_STE_1_PRIVCFG_UNPRIV <<
+			 STRTAB_STE_1_PRIVCFG_SHIFT);
 
 		if (smmu->features & ARM_SMMU_FEAT_STALLS)
 			dst[1] |= cpu_to_le64(STRTAB_STE_1_S1STALLD);
-- 
2.8.1.dirty

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
