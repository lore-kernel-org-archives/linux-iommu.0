From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH v5 08/19] iommu/arm-smmu: Handle stream IDs more dynamically
Date: Tue, 23 Aug 2016 20:05:19 +0100
Message-ID: <36f71a07fbc6037ca664bdcc540650f893081dd1.1471975357.git.robin.murphy@arm.com>
References: <cover.1471975357.git.robin.murphy@arm.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cover.1471975357.git.robin.murphy-5wv7dgnIgG8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org, jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org, punit.agrawal-5wv7dgnIgG8@public.gmane.org, thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Rather than assuming fixed worst-case values for stream IDs and SMR
masks, keep track of whatever implemented bits the hardware actually
reports. This also obviates the slightly questionable validation of SMR
fields in isolation - rather than aborting the whole SMMU probe for a
hardware configuration which is still architecturally valid, we can
simply refuse masters later if they try to claim an unrepresentable ID
or mask (which almost certainly implies a DT error anyway).

Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
---
 drivers/iommu/arm-smmu.c | 43 ++++++++++++++++++++++---------------------
 1 file changed, 22 insertions(+), 21 deletions(-)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 2db74ebc3240..3357afdd6865 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -165,9 +165,7 @@
 #define ARM_SMMU_GR0_SMR(n)		(0x800 + ((n) << 2))
 #define SMR_VALID			(1 << 31)
 #define SMR_MASK_SHIFT			16
-#define SMR_MASK_MASK			0x7fff
 #define SMR_ID_SHIFT			0
-#define SMR_ID_MASK			0x7fff
 
 #define ARM_SMMU_GR0_S2CR(n)		(0xc00 + ((n) << 2))
 #define S2CR_CBNDX_SHIFT		0
@@ -346,6 +344,8 @@ struct arm_smmu_device {
 	atomic_t			irptndx;
 
 	u32				num_mapping_groups;
+	u16				streamid_mask;
+	u16				smr_mask_mask;
 	DECLARE_BITMAP(smr_map, ARM_SMMU_MAX_SMRS);
 
 	unsigned long			va_size;
@@ -1690,39 +1690,40 @@ static int arm_smmu_device_cfg_probe(struct arm_smmu_device *smmu)
 		dev_notice(smmu->dev,
 			   "\t(IDR0.CTTW overridden by dma-coherent property)\n");
 
+	/* Max. number of entries we have for stream matching/indexing */
+	size = 1 << ((id >> ID0_NUMSIDB_SHIFT) & ID0_NUMSIDB_MASK);
+	smmu->streamid_mask = size - 1;
 	if (id & ID0_SMS) {
-		u32 smr, sid, mask;
+		u32 smr;
 
 		smmu->features |= ARM_SMMU_FEAT_STREAM_MATCH;
-		smmu->num_mapping_groups = (id >> ID0_NUMSMRG_SHIFT) &
-					   ID0_NUMSMRG_MASK;
-		if (smmu->num_mapping_groups == 0) {
+		size = (id >> ID0_NUMSMRG_SHIFT) & ID0_NUMSMRG_MASK;
+		if (size == 0) {
 			dev_err(smmu->dev,
 				"stream-matching supported, but no SMRs present!\n");
 			return -ENODEV;
 		}
 
-		smr = SMR_MASK_MASK << SMR_MASK_SHIFT;
-		smr |= (SMR_ID_MASK << SMR_ID_SHIFT);
+		/*
+		 * SMR.ID bits may not be preserved if the corresponding MASK
+		 * bits are set, so check each one separately. We can reject
+		 * masters later if they try to claim IDs outside these masks.
+		 */
+		smr = smmu->streamid_mask << SMR_ID_SHIFT;
 		writel_relaxed(smr, gr0_base + ARM_SMMU_GR0_SMR(0));
 		smr = readl_relaxed(gr0_base + ARM_SMMU_GR0_SMR(0));
+		smmu->streamid_mask = smr >> SMR_ID_SHIFT;
 
-		mask = (smr >> SMR_MASK_SHIFT) & SMR_MASK_MASK;
-		sid = (smr >> SMR_ID_SHIFT) & SMR_ID_MASK;
-		if ((mask & sid) != sid) {
-			dev_err(smmu->dev,
-				"SMR mask bits (0x%x) insufficient for ID field (0x%x)\n",
-				mask, sid);
-			return -ENODEV;
-		}
+		smr = smmu->streamid_mask << SMR_MASK_SHIFT;
+		writel_relaxed(smr, gr0_base + ARM_SMMU_GR0_SMR(0));
+		smr = readl_relaxed(gr0_base + ARM_SMMU_GR0_SMR(0));
+		smmu->smr_mask_mask = smr >> SMR_MASK_SHIFT;
 
 		dev_notice(smmu->dev,
-			   "\tstream matching with %u register groups, mask 0x%x",
-			   smmu->num_mapping_groups, mask);
-	} else {
-		smmu->num_mapping_groups = (id >> ID0_NUMSIDB_SHIFT) &
-					   ID0_NUMSIDB_MASK;
+			   "\tstream matching with %lu register groups, mask 0x%x",
+			   size, smmu->smr_mask_mask);
 	}
+	smmu->num_mapping_groups = size;
 
 	if (smmu->version < ARM_SMMU_V2 || !(id & ID0_PTFS_NO_AARCH32)) {
 		smmu->features |= ARM_SMMU_FEAT_FMT_AARCH32_L;
-- 
2.8.1.dirty

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
