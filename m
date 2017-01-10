From: Nate Watterson <nwatters-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: [PATCH] iommu/arm-smmu-v3: limit use of 2-level stream tables
Date: Tue, 10 Jan 2017 14:47:13 -0500
Message-ID: <1484077633-18376-1-git-send-email-nwatters@codeaurora.org>
References: <20161220102209.GC10132@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20161220102209.GC10132-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

In the current arm-smmu-v3 driver, all smmus that support 2-level
stream tables are being forced to use them. This is suboptimal for
smmus that support fewer stream id bits than would fill in a single
second level table. This patch limits the use of 2-level tables to
smmus that both support the feature and whose first level table can
possibly contain more than a single entry.

Signed-off-by: Nate Watterson <nwatters-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
---
 drivers/iommu/arm-smmu-v3.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 4d6ec44..7d1a7e5 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -1983,17 +1983,9 @@ static int arm_smmu_init_strtab_2lvl(struct arm_smmu_device *smmu)
 	u32 size, l1size;
 	struct arm_smmu_strtab_cfg *cfg = &smmu->strtab_cfg;
 
-	/*
-	 * If we can resolve everything with a single L2 table, then we
-	 * just need a single L1 descriptor. Otherwise, calculate the L1
-	 * size, capped to the SIDSIZE.
-	 */
-	if (smmu->sid_bits < STRTAB_SPLIT) {
-		size = 0;
-	} else {
-		size = STRTAB_L1_SZ_SHIFT - (ilog2(STRTAB_L1_DESC_DWORDS) + 3);
-		size = min(size, smmu->sid_bits - STRTAB_SPLIT);
-	}
+	/* Calculate the L1 size, capped to the SIDSIZE. */
+	size = STRTAB_L1_SZ_SHIFT - (ilog2(STRTAB_L1_DESC_DWORDS) + 3);
+	size = min(size, smmu->sid_bits - STRTAB_SPLIT);
 	cfg->num_l1_ents = 1 << size;
 
 	size += STRTAB_SPLIT;
@@ -2504,6 +2496,13 @@ static int arm_smmu_device_hw_probe(struct arm_smmu_device *smmu)
 	smmu->ssid_bits = reg >> IDR1_SSID_SHIFT & IDR1_SSID_MASK;
 	smmu->sid_bits = reg >> IDR1_SID_SHIFT & IDR1_SID_MASK;
 
+	/*
+	 * If the SMMU supports fewer bits than would fill a single L2 stream
+	 * table, use a linear table instead.
+	 */
+	if (smmu->sid_bits <= STRTAB_SPLIT)
+		smmu->features &= ~ARM_SMMU_FEAT_2_LVL_STRTAB;
+
 	/* IDR5 */
 	reg = readl_relaxed(smmu->base + ARM_SMMU_IDR5);
 
-- 
Qualcomm Datacenter Technologies, Inc. on behalf of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux
Foundation Collaborative Project.
