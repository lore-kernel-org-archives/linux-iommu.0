From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH 3/7] iommu/arm-smmu: fix s2cr and smr teardown on device
	detach from domain
Date: Fri, 29 Aug 2014 15:47:41 +0100
Message-ID: <1409323665-9605-4-git-send-email-will.deacon@arm.com>
References: <1409323665-9605-1-git-send-email-will.deacon@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1409323665-9605-1-git-send-email-will.deacon-5wv7dgnIgG8@public.gmane.org>
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
Cc: vladimir.murzin-5wv7dgnIgG8@public.gmane.org, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, hans-7z9IcJk4adCsTnJN9+BGXg@public.gmane.org, jroedel-l3A5Bk7waGM@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

When we attach a device to a domain, we configure the SMRs (if we have
any) to match the Stream IDs for the corresponding SMMU master and
program the s2crs accordingly. However, on detach we tear down the s2crs
assuming stream-indexing (as opposed to stream-matching) and SMRs
assuming they are present.

This patch fixes the device detach code so that it operates as a
converse of the attach code.

Signed-off-by: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
---
 drivers/iommu/arm-smmu.c | 27 ++++++++++++---------------
 1 file changed, 12 insertions(+), 15 deletions(-)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 0ba7a1d3df78..34dc7b1cec3c 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -1125,6 +1125,9 @@ static void arm_smmu_master_free_smrs(struct arm_smmu_device *smmu,
 	void __iomem *gr0_base = ARM_SMMU_GR0(smmu);
 	struct arm_smmu_smr *smrs = cfg->smrs;
 
+	if (!smrs)
+		return;
+
 	/* Invalidate the SMRs before freeing back to the allocator */
 	for (i = 0; i < cfg->num_streamids; ++i) {
 		u8 idx = smrs[i].idx;
@@ -1137,20 +1140,6 @@ static void arm_smmu_master_free_smrs(struct arm_smmu_device *smmu,
 	kfree(smrs);
 }
 
-static void arm_smmu_bypass_stream_mapping(struct arm_smmu_device *smmu,
-					   struct arm_smmu_master_cfg *cfg)
-{
-	int i;
-	void __iomem *gr0_base = ARM_SMMU_GR0(smmu);
-
-	for (i = 0; i < cfg->num_streamids; ++i) {
-		u16 sid = cfg->streamids[i];
-
-		writel_relaxed(S2CR_TYPE_BYPASS,
-			       gr0_base + ARM_SMMU_GR0_S2CR(sid));
-	}
-}
-
 static int arm_smmu_domain_add_master(struct arm_smmu_domain *smmu_domain,
 				      struct arm_smmu_master_cfg *cfg)
 {
@@ -1177,13 +1166,21 @@ static int arm_smmu_domain_add_master(struct arm_smmu_domain *smmu_domain,
 static void arm_smmu_domain_remove_master(struct arm_smmu_domain *smmu_domain,
 					  struct arm_smmu_master_cfg *cfg)
 {
+	int i;
 	struct arm_smmu_device *smmu = smmu_domain->smmu;
+	void __iomem *gr0_base = ARM_SMMU_GR0(smmu);
 
 	/*
 	 * We *must* clear the S2CR first, because freeing the SMR means
 	 * that it can be re-allocated immediately.
 	 */
-	arm_smmu_bypass_stream_mapping(smmu, cfg);
+	for (i = 0; i < cfg->num_streamids; ++i) {
+		u32 idx = cfg->smrs ? cfg->smrs[i].idx : cfg->streamids[i];
+
+		writel_relaxed(S2CR_TYPE_BYPASS,
+			       gr0_base + ARM_SMMU_GR0_S2CR(idx));
+	}
+
 	arm_smmu_master_free_smrs(smmu, cfg);
 }
 
-- 
2.1.0
