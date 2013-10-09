From: Andreas Herrmann <andreas.herrmann-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 7/7] iommu/arm-smmu: Introduce automatic stream-id-masking
Date: Thu, 10 Oct 2013 00:38:06 +0200
Message-ID: <1381358286-27065-8-git-send-email-andreas.herrmann@calxeda.com>
References: <1381358286-27065-1-git-send-email-andreas.herrmann@calxeda.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1381358286-27065-1-git-send-email-andreas.herrmann-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Cc: Andreas Herrmann <andreas.herrmann-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Try to determine a mask that can be used for all StreamIDs of a master
device. This allows to use just one SMR group instead of
number-of-streamids SMR groups for a master device.

Signed-off-by: Andreas Herrmann <andreas.herrmann-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>
---
 drivers/iommu/arm-smmu.c |   79 ++++++++++++++++++++++++++++++++++++----------
 1 file changed, 63 insertions(+), 16 deletions(-)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 91316a8..4e8ceab 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -28,6 +28,7 @@
  *	- Context fault reporting
  */
 
+#define DEBUG
 #define pr_fmt(fmt) "arm-smmu: " fmt
 
 #include <linux/delay.h>
@@ -341,6 +342,9 @@ struct arm_smmu_master {
 	struct rb_node			node;
 	int				num_streamids;
 	u16				streamids[MAX_MASTER_STREAMIDS];
+	int				num_smrs;
+	u16				smr_mask;
+	u16				smr_id;
 
 	/*
 	 * We only need to allocate these on the root SMMU, as we
@@ -530,14 +534,11 @@ static int register_smmu_master(struct arm_smmu_device *smmu,
 					ARM_SMMU_OPT_MASK_STREAM_IDS));
 			return -EINVAL;
 		}
-		/* set fixed streamid (0) that will be used for masking */
-		master->num_streamids = 1;
-		master->streamids[0] = 0;
-	} else {
-		for (i = 0; i < master->num_streamids; ++i)
-			master->streamids[i] = masterspec->args[i];
 	}
 
+	for (i = 0; i < master->num_streamids; ++i)
+		master->streamids[i] = masterspec->args[i];
+
 	return insert_smmu_master(smmu, master);
 }
 
@@ -1049,6 +1050,41 @@ static void arm_smmu_domain_destroy(struct iommu_domain *domain)
 	kfree(smmu_domain);
 }
 
+/*
+ * no duplicates streamids please
+ */
+static void determine_smr_mapping(struct arm_smmu_device *smmu,
+				struct arm_smmu_master *master)
+{
+	int nr_sid;
+	u16 i, v1, v2, const_mask;
+
+	if (smmu->options & ARM_SMMU_OPT_MASK_STREAM_IDS) {
+		master->smr_mask = smmu->smr_mask_bits;
+		master->smr_id = 0;
+		return;
+	}
+
+	nr_sid = master->num_streamids;
+	if (!is_power_of_2(nr_sid))
+		return;
+
+	v1 = 0;
+	v2 = -1;
+	for (i = 0; i < nr_sid; i++) {
+		v1 |= master->streamids[i];	/* for const 0 bits */
+		v2 &= ~(master->streamids[i]);	/* const 1 bits */
+	}
+	const_mask = (~v1) | v2;	/* const bits (either 0 or 1) */
+
+	v1 = hweight16(~const_mask);
+	if ((1 << v1) == nr_sid) {
+		/* if smr_mask is set, only 1 SMR group is used smr[0] = 0 */
+		master->smr_mask = ~const_mask;
+		master->smr_id = v1 & const_mask;
+	}
+}
+
 static int arm_smmu_master_configure_smrs(struct arm_smmu_device *smmu,
 					  struct arm_smmu_master *master)
 {
@@ -1062,15 +1098,22 @@ static int arm_smmu_master_configure_smrs(struct arm_smmu_device *smmu,
 	if (master->smrs)
 		return -EEXIST;
 
-	smrs = kmalloc(sizeof(*smrs) * master->num_streamids, GFP_KERNEL);
+	determine_smr_mapping(smmu, master);
+
+	if (master->smr_mask)
+		master->num_smrs = 1;
+	else
+		master->num_smrs = master->num_streamids;
+
+	smrs = kmalloc(sizeof(*smrs) * master->num_smrs, GFP_KERNEL);
 	if (!smrs) {
 		dev_err(smmu->dev, "failed to allocate %d SMRs for master %s\n",
-			master->num_streamids, master->of_node->name);
+			master->num_smrs, master->of_node->name);
 		return -ENOMEM;
 	}
 
 	/* Allocate the SMRs on the root SMMU */
-	for (i = 0; i < master->num_streamids; ++i) {
+	for (i = 0; i < master->num_smrs; ++i) {
 		int idx = __arm_smmu_alloc_bitmap(smmu->smr_map, 0,
 						  smmu->num_mapping_groups);
 		if (IS_ERR_VALUE(idx)) {
@@ -1079,16 +1122,18 @@ static int arm_smmu_master_configure_smrs(struct arm_smmu_device *smmu,
 		}
 
 		smrs[i].idx = idx;
-		smrs[i].id = master->streamids[i];
 
-		if (smmu->options & ARM_SMMU_OPT_MASK_STREAM_IDS)
-			smrs[i].mask = smmu->smr_mask_bits;
-		else
+		if (master->smr_mask) {
+			smrs[i].mask = master->smr_mask;
+			smrs[i].id = master->smr_id;
+		} else {
 			smrs[i].mask = 0;
+			smrs[i].id = master->streamids[i];
+		}
 	}
 
 	/* It worked! Now, poke the actual hardware */
-	for (i = 0; i < master->num_streamids; ++i) {
+	for (i = 0; i < master->num_smrs; ++i) {
 		u32 reg = SMR_VALID | smrs[i].id << SMR_ID_SHIFT |
 			  smrs[i].mask << SMR_MASK_SHIFT;
 		dev_dbg(smmu->dev, "SMR%d: 0x%x\n", smrs[i].idx, reg);
@@ -1139,7 +1184,7 @@ static void arm_smmu_bypass_stream_mapping(struct arm_smmu_device *smmu,
 static int arm_smmu_domain_add_master(struct arm_smmu_domain *smmu_domain,
 				      struct arm_smmu_master *master)
 {
-	int i, ret;
+	int i, ret, num_s2crs;
 	struct arm_smmu_device *parent, *smmu = smmu_domain->root_cfg.smmu;
 	void __iomem *gr0_base = ARM_SMMU_GR0(smmu);
 
@@ -1163,11 +1208,13 @@ static int arm_smmu_domain_add_master(struct arm_smmu_domain *smmu_domain,
 	}
 
 	/* Now we're at the root, time to point at our context bank */
-	for (i = 0; i < master->num_streamids; ++i) {
+	num_s2crs = master->num_smrs ? master->num_smrs : master->num_streamids;
+	for (i = 0; i < num_s2crs; ++i) {
 		u32 idx, s2cr;
 		idx = master->smrs ? master->smrs[i].idx : master->streamids[i];
 		s2cr = (S2CR_TYPE_TRANS << S2CR_TYPE_SHIFT) |
 		       (smmu_domain->root_cfg.cbndx << S2CR_CBNDX_SHIFT);
+		dev_dbg(smmu->dev, "S2CR%d: 0x%x\n", idx, s2cr);
 		writel_relaxed(s2cr, gr0_base + ARM_SMMU_GR0_S2CR(idx));
 	}
 
-- 
1.7.9.5
