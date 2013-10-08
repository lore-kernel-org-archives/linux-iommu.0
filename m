From: Andreas Herrmann <andreas.herrmann-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 3/5] iommu/arm-smmu: Introduce stream ID masking
Date: Tue,  8 Oct 2013 11:27:22 +0200
Message-ID: <1381224444-27303-4-git-send-email-andreas.herrmann@calxeda.com>
References: <1381224444-27303-1-git-send-email-andreas.herrmann@calxeda.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1381224444-27303-1-git-send-email-andreas.herrmann-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>
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

Ie. use a mask based on smr_mask_bits to map all stream IDs of an SMMU
to one context.

This behaviour is controlled per SMMU node with DT property
"arm,smmu-mask-stream-ids" and is only allowed if just a single master
is attached to an SMMU. If the option is specified, all stream-ids
that are provided in DT for the single master have no relevance.

This is useful/convenient if a master has more than 8 stream-ids or if
not all stream-ids are known for a master device.

Signed-off-by: Andreas Herrmann <andreas.herrmann-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>
---
 drivers/iommu/arm-smmu.c |   43 +++++++++++++++++++++++++++++++------------
 1 file changed, 31 insertions(+), 12 deletions(-)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 9a73618..e2dbcbb 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -359,6 +359,7 @@ struct arm_smmu_device {
 
 	u32				num_mapping_groups;
 	DECLARE_BITMAP(smr_map, ARM_SMMU_MAX_SMRS);
+	u32				smr_mask_bits;
 
 	unsigned long			input_size;
 	unsigned long			s1_output_size;
@@ -370,6 +371,7 @@ struct arm_smmu_device {
 
 	struct list_head		list;
 	struct rb_root			masters;
+	u32				num_masters;
 };
 
 struct arm_smmu_cfg {
@@ -403,6 +405,7 @@ static LIST_HEAD(arm_smmu_devices);
 /* driver options */
 enum arm_smmu_option {
 	ISOLATE_DEVICES = 0,
+	MASK_STREAM_IDS,
 	OPTION_MAX,
 };
 
@@ -413,6 +416,7 @@ struct arm_smmu_option_prop {
 
 static struct arm_smmu_option_prop arm_smmu_options [] = {
 	{ ISOLATE_DEVICES, "arm,smmu-isolate-devices" },
+	{ MASK_STREAM_IDS, "arm,smmu-mask-stream-ids" },
 	{ OPTION_MAX, NULL},
 };
 
@@ -488,6 +492,7 @@ static int insert_smmu_master(struct arm_smmu_device *smmu,
 
 	rb_link_node(&master->node, parent, new);
 	rb_insert_color(&master->node, &smmu->masters);
+	smmu->num_masters++;
 	return 0;
 }
 
@@ -520,8 +525,19 @@ static int register_smmu_master(struct arm_smmu_device *smmu,
 	master->of_node		= masterspec->np;
 	master->num_streamids	= masterspec->args_count;
 
-	for (i = 0; i < master->num_streamids; ++i)
-		master->streamids[i] = masterspec->args[i];
+	if (arm_smmu_has_option(smmu, MASK_STREAM_IDS)) {
+		if (smmu->num_masters) {
+			dev_err(dev, "option %s not supported with multiple masters\n",
+				arm_smmu_options[MASK_STREAM_IDS].prop);
+			return -EINVAL;
+		}
+		/* set fixed streamid (0) that will be used for masking */
+		master->num_streamids = 1;
+		master->streamids[0] = 0;
+	} else {
+		for (i = 0; i < master->num_streamids; ++i)
+			master->streamids[i] = masterspec->args[i];
+	}
 
 	return insert_smmu_master(smmu, master);
 }
@@ -1063,17 +1079,20 @@ static int arm_smmu_master_configure_smrs(struct arm_smmu_device *smmu,
 			goto err_free_smrs;
 		}
 
-		smrs[i] = (struct arm_smmu_smr) {
-			.idx	= idx,
-			.mask	= 0, /* We don't currently share SMRs */
-			.id	= master->streamids[i],
-		};
+		smrs[i].idx = idx;
+		smrs[i].id = master->streamids[i];
+
+		if (arm_smmu_has_option(smmu, MASK_STREAM_IDS))
+			smrs[i].mask = smmu->smr_mask_bits;
+		else
+			smrs[i].mask = 0;
 	}
 
 	/* It worked! Now, poke the actual hardware */
 	for (i = 0; i < master->num_streamids; ++i) {
 		u32 reg = SMR_VALID | smrs[i].id << SMR_ID_SHIFT |
 			  smrs[i].mask << SMR_MASK_SHIFT;
+		dev_dbg(smmu->dev, "SMR%d: 0x%x\n", smrs[i].idx, reg);
 		writel_relaxed(reg, gr0_base + ARM_SMMU_GR0_SMR(smrs[i].idx));
 	}
 
@@ -1726,7 +1745,7 @@ static int arm_smmu_device_cfg_probe(struct arm_smmu_device *smmu)
 	}
 
 	if (id & ID0_SMS) {
-		u32 smr, sid, mask;
+		u32 smr, sid;
 
 		smmu->features |= ARM_SMMU_FEAT_STREAM_MATCH;
 		smmu->num_mapping_groups = (id >> ID0_NUMSMRG_SHIFT) &
@@ -1742,18 +1761,18 @@ static int arm_smmu_device_cfg_probe(struct arm_smmu_device *smmu)
 		writel_relaxed(smr, gr0_base + ARM_SMMU_GR0_SMR(0));
 		smr = readl_relaxed(gr0_base + ARM_SMMU_GR0_SMR(0));
 
-		mask = (smr >> SMR_MASK_SHIFT) & SMR_MASK_MASK;
+		smmu->smr_mask_bits = (smr >> SMR_MASK_SHIFT) & SMR_MASK_MASK;
 		sid = (smr >> SMR_ID_SHIFT) & SMR_ID_MASK;
-		if ((mask & sid) != sid) {
+		if ((smmu->smr_mask_bits & sid) != sid) {
 			dev_err(smmu->dev,
 				"SMR mask bits (0x%x) insufficient for ID field (0x%x)\n",
-				mask, sid);
+				smmu->smr_mask_bits, sid);
 			return -ENODEV;
 		}
 
 		dev_notice(smmu->dev,
 			   "\tstream matching with %u register groups, mask 0x%x",
-			   smmu->num_mapping_groups, mask);
+			   smmu->num_mapping_groups, smmu->smr_mask_bits);
 	}
 
 	/* ID1 */
-- 
1.7.9.5
