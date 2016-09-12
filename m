From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH v7 15/22] iommu/arm-smmu: Add a stream map entry iterator
Date: Mon, 12 Sep 2016 17:13:53 +0100
Message-ID: <fab6d3e0f8577e73d134899eb609ee8289b3a7b0.1473695704.git.robin.murphy@arm.com>
References: <cover.1473695704.git.robin.murphy@arm.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cover.1473695704.git.robin.murphy-5wv7dgnIgG8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: will.deacon-5wv7dgnIgG8@public.gmane.org, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org, jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org, punit.agrawal-5wv7dgnIgG8@public.gmane.org, thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

We iterate over the SMEs associated with a master config quite a lot in
various places, and are about to do so even more. Let's wrap the idiom
in a handy iterator macro before the repetition gets out of hand.

Tested-by: Lorenzo Pieralisi <lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>
Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
---
 drivers/iommu/arm-smmu.c | 26 ++++++++++++--------------
 1 file changed, 12 insertions(+), 14 deletions(-)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 3962add0c33b..7a0edef34a22 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -324,6 +324,8 @@ struct arm_smmu_master_cfg {
 	s16				smendx[MAX_MASTER_STREAMIDS];
 };
 #define INVALID_SMENDX			-1
+#define for_each_cfg_sme(cfg, i, idx) \
+	for (i = 0; idx = cfg->smendx[i], i < cfg->num_streamids; ++i)
 
 struct arm_smmu_device {
 	struct device			*dev;
@@ -1090,8 +1092,8 @@ static int arm_smmu_master_alloc_smes(struct arm_smmu_device *smmu,
 	int i, idx;
 
 	/* Allocate the SMRs on the SMMU */
-	for (i = 0; i < cfg->num_streamids; ++i) {
-		if (cfg->smendx[i] != INVALID_SMENDX)
+	for_each_cfg_sme(cfg, i, idx) {
+		if (idx != INVALID_SMENDX)
 			return -EEXIST;
 
 		/* ...except on stream indexing hardware, of course */
@@ -1115,8 +1117,8 @@ static int arm_smmu_master_alloc_smes(struct arm_smmu_device *smmu,
 		return 0;
 
 	/* It worked! Now, poke the actual hardware */
-	for (i = 0; i < cfg->num_streamids; ++i)
-		arm_smmu_write_smr(smmu, cfg->smendx[i]);
+	for_each_cfg_sme(cfg, i, idx)
+		arm_smmu_write_smr(smmu, idx);
 
 	return 0;
 
@@ -1131,15 +1133,13 @@ err_free_smrs:
 static void arm_smmu_master_free_smes(struct arm_smmu_master_cfg *cfg)
 {
 	struct arm_smmu_device *smmu = cfg->smmu;
-	int i;
+	int i, idx;
 
 	/*
 	 * We *must* clear the S2CR first, because freeing the SMR means
 	 * that it can be re-allocated immediately.
 	 */
-	for (i = 0; i < cfg->num_streamids; ++i) {
-		int idx = cfg->smendx[i];
-
+	for_each_cfg_sme(cfg, i, idx) {
 		/* An IOMMU group is torn down by the first device to be removed */
 		if (idx == INVALID_SMENDX)
 			return;
@@ -1151,9 +1151,9 @@ static void arm_smmu_master_free_smes(struct arm_smmu_master_cfg *cfg)
 	__iowmb();
 
 	/* Invalidate the SMRs before freeing back to the allocator */
-	for (i = 0; i < cfg->num_streamids; ++i) {
+	for_each_cfg_sme(cfg, i, idx) {
 		if (smmu->smrs)
-			arm_smmu_free_smr(smmu, cfg->smendx[i]);
+			arm_smmu_free_smr(smmu, idx);
 
 		cfg->smendx[i] = INVALID_SMENDX;
 	}
@@ -1162,7 +1162,7 @@ static void arm_smmu_master_free_smes(struct arm_smmu_master_cfg *cfg)
 static int arm_smmu_domain_add_master(struct arm_smmu_domain *smmu_domain,
 				      struct arm_smmu_master_cfg *cfg)
 {
-	int i, ret = 0;
+	int i, idx, ret = 0;
 	struct arm_smmu_device *smmu = smmu_domain->smmu;
 	struct arm_smmu_s2cr *s2cr = smmu->s2crs;
 	enum arm_smmu_s2cr_type type = S2CR_TYPE_TRANS;
@@ -1182,9 +1182,7 @@ static int arm_smmu_domain_add_master(struct arm_smmu_domain *smmu_domain,
 	if (smmu_domain->domain.type == IOMMU_DOMAIN_DMA)
 		type = S2CR_TYPE_BYPASS;
 
-	for (i = 0; i < cfg->num_streamids; ++i) {
-		int idx = cfg->smendx[i];
-
+	for_each_cfg_sme(cfg, i, idx) {
 		/* Devices in an IOMMU group may already be configured */
 		if (type == s2cr[idx].type && cbndx == s2cr[idx].cbndx)
 			break;
-- 
2.8.1.dirty

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
