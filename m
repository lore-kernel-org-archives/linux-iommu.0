From: Andreas Herrmann <andreas.herrmann-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 04/11] iommu/arm-smmu: Introduce automatic stream-id-masking
Date: Thu, 16 Jan 2014 13:44:16 +0100
Message-ID: <1389876263-25759-5-git-send-email-andreas.herrmann@calxeda.com>
References: <1389876263-25759-1-git-send-email-andreas.herrmann@calxeda.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1389876263-25759-1-git-send-email-andreas.herrmann-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>
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
Cc: Andreas Herrmann <andreas.herrmann-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Try to determine a mask that can be used for all StreamIDs of a master
device. This allows to use just one SMR group instead of
number-of-streamids SMR groups for a master device.

Changelog:
* dropped "#define DEBUG"
* removed  "BUG_ON(!is_power_of_2(nr))" from determine_smr_mask
  by passing an order instead of the actual number of streamids
  to this function.
* added check for master->num_used_smrs being 0 to
  determine_smr_mapping
* renamed num_used_smrs to num_s2crs
* added validation of calculated SMR mask and id field (against number
  of implemented bits of SMR

Notes:

* Check for duplicate stream IDs
  - not implemented with this patch but in a separate patch
  - If the same stream ID is specified for 2 masters further behaviour
    is implementation defined (we'll end with more than one matching
    entry in the stream mapping table).
  - If one stream ID is specified twice for a master device, the
    determination of how many S2CR/SMR groups are required for stream
    mapping will fail. Esp. it can happen that more than one matching
    entry is created in the stream mapping table.

* Sorting of stream IDs (to make usage of S2CR independend of sequence of
  stream IDs in DT)
  - intentionally not implemented
  - code does not rely on sorting
  - in fact sorting might make things worse with this simple
    implementation
    + Example: master with stream IDs 4, 5, 6, 0xe, 0xf requires 3
      SMRs when IDs are specified in this sorted order (one to map 4,
      5, one to map 6, one to map 0xe, 0xf) but just 2 SMRs when
      specified as 4, 5, 0xe, 0xf, 6 (one to map 4, 5, 0xe, 0xf and
      one SMR to map 6)
  - thus by modifying the DT information you can affect the number of
    S2CRs required for stream matching
  => I'd say "use common sense" when specifying stream IDs for a master
   device in DT.

Cc: Andreas Herrmann <herrmann.der.user-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Signed-off-by: Andreas Herrmann <andreas.herrmann-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>
---
 drivers/iommu/arm-smmu.c |  142 +++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 127 insertions(+), 15 deletions(-)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 823699e..02a871e 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -42,6 +42,7 @@
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
+#include <linux/bitops.h>
 
 #include <linux/amba/bus.h>
 
@@ -338,8 +339,9 @@ struct arm_smmu_master {
 	 * SMMU chain.
 	 */
 	struct rb_node			node;
-	int				num_streamids;
+	u32				num_streamids;
 	u16				streamids[MAX_MASTER_STREAMIDS];
+	int				num_s2crs;
 
 	/*
 	 * We only need to allocate these on the root SMMU, as we
@@ -381,6 +383,9 @@ struct arm_smmu_device {
 	u32				num_context_irqs;
 	unsigned int			*irqs;
 
+	u32				smr_mask_mask;
+	u32				smr_id_mask;
+
 	struct list_head		list;
 	struct rb_root			masters;
 };
@@ -1025,10 +1030,109 @@ static void arm_smmu_domain_destroy(struct iommu_domain *domain)
 	kfree(smmu_domain);
 }
 
+static int determine_smr_mask(struct arm_smmu_device *smmu,
+			struct arm_smmu_master *master,
+			struct arm_smmu_smr *smr, int start, int order)
+{
+	u16 i, zero_bits_mask, one_bits_mask, const_mask;
+	int nr;
+
+	nr = 1 << order;
+
+	if (nr == 1) {
+		/* no mask, use streamid to match and be done with it */
+		smr->mask = 0;
+		smr->id = master->streamids[start];
+		return 0;
+	}
+
+	zero_bits_mask = 0;
+	one_bits_mask = 0xffff;
+	for (i = start; i < start + nr; i++) {
+		zero_bits_mask |= master->streamids[i];   /* const 0 bits */
+		one_bits_mask &= master->streamids[i]; /* const 1 bits */
+	}
+	zero_bits_mask = ~zero_bits_mask;
+
+	/* bits having constant values (either 0 or 1) */
+	const_mask = zero_bits_mask | one_bits_mask;
+
+	i = hweight16(~const_mask);
+	if ((1 << i) == nr) {
+		smr->mask = ~const_mask;
+		smr->id = one_bits_mask;
+	} else {
+		/* no usable mask for this set of streamids */
+		return 1;
+	}
+
+	if (((smr->mask & smmu->smr_mask_mask) != smr->mask) ||
+		((smr->id & smmu->smr_id_mask) != smr->id))
+		/* insufficient number of mask/id bits */
+		return 1;
+
+	return 0;
+}
+
+static int determine_smr_mapping(struct arm_smmu_device *smmu,
+				struct arm_smmu_master *master,
+				struct arm_smmu_smr *smrs, int max_smrs)
+{
+	int nr_sid, nr, i, bit, start;
+
+	/*
+	 * This function is called only once -- when a master is added
+	 * to a domain. If master->num_s2crs != 0 then this master
+	 * was already added to a domain.
+	 */
+	BUG_ON(master->num_s2crs);
+
+	start = nr = 0;
+	nr_sid = master->num_streamids;
+	do {
+		/*
+		 * largest power-of-2 number of streamids for which to
+		 * determine a usable mask/id pair for stream matching
+		 */
+		bit = fls(nr_sid);
+		if (!bit)
+			return 0;
+
+		/*
+		 * iterate over power-of-2 numbers to determine
+		 * largest possible mask/id pair for stream matching
+		 * of next 2**i streamids
+		 */
+		for (i = bit - 1; i >= 0; i--) {
+			if(!determine_smr_mask(smmu, master,
+						&smrs[master->num_s2crs],
+						start, i))
+				break;
+		}
+
+		if (i < 0)
+			goto out;
+
+		nr = 1 << i;
+		nr_sid -= nr;
+		start += nr;
+		master->num_s2crs++;
+	} while (master->num_s2crs <= max_smrs);
+
+out:
+	if (nr_sid) {
+		/* not enough mapping groups available */
+		master->num_s2crs = 0;
+		return -ENOSPC;
+	}
+
+	return 0;
+}
+
 static int arm_smmu_master_configure_smrs(struct arm_smmu_device *smmu,
 					  struct arm_smmu_master *master)
 {
-	int i;
+	int i, max_smrs, ret;
 	struct arm_smmu_smr *smrs;
 	void __iomem *gr0_base = ARM_SMMU_GR0(smmu);
 
@@ -1038,42 +1142,45 @@ static int arm_smmu_master_configure_smrs(struct arm_smmu_device *smmu,
 	if (master->smrs)
 		return -EEXIST;
 
-	smrs = kmalloc(sizeof(*smrs) * master->num_streamids, GFP_KERNEL);
+	max_smrs = min(smmu->num_mapping_groups, master->num_streamids);
+	smrs = kmalloc(sizeof(*smrs) * max_smrs, GFP_KERNEL);
 	if (!smrs) {
 		dev_err(smmu->dev, "failed to allocate %d SMRs for master %s\n",
-			master->num_streamids, master->of_node->name);
+			max_smrs, master->of_node->name);
 		return -ENOMEM;
 	}
 
+	ret = determine_smr_mapping(smmu, master, smrs, max_smrs);
+	if (ret)
+		goto err_free_smrs;
+
 	/* Allocate the SMRs on the root SMMU */
-	for (i = 0; i < master->num_streamids; ++i) {
+	for (i = 0; i < master->num_s2crs; ++i) {
 		int idx = __arm_smmu_alloc_bitmap(smmu->smr_map, 0,
 						  smmu->num_mapping_groups);
 		if (IS_ERR_VALUE(idx)) {
 			dev_err(smmu->dev, "failed to allocate free SMR\n");
-			goto err_free_smrs;
+			goto err_free_bitmap;
 		}
-
-		smrs[i] = (struct arm_smmu_smr) {
-			.idx	= idx,
-			.mask	= 0, /* We don't currently share SMRs */
-			.id	= master->streamids[i],
-		};
+		smrs[i].idx = idx;
 	}
 
 	/* It worked! Now, poke the actual hardware */
-	for (i = 0; i < master->num_streamids; ++i) {
+	for (i = 0; i < master->num_s2crs; ++i) {
 		u32 reg = SMR_VALID | smrs[i].id << SMR_ID_SHIFT |
 			  smrs[i].mask << SMR_MASK_SHIFT;
+		dev_dbg(smmu->dev, "SMR%d: 0x%x\n", smrs[i].idx, reg);
 		writel_relaxed(reg, gr0_base + ARM_SMMU_GR0_SMR(smrs[i].idx));
 	}
 
 	master->smrs = smrs;
 	return 0;
 
-err_free_smrs:
+err_free_bitmap:
 	while (--i >= 0)
 		__arm_smmu_free_bitmap(smmu->smr_map, smrs[i].idx);
+	master->num_s2crs = 0;
+err_free_smrs:
 	kfree(smrs);
 	return -ENOSPC;
 }
@@ -1136,11 +1243,14 @@ static int arm_smmu_domain_add_master(struct arm_smmu_domain *smmu_domain,
 	}
 
 	/* Now we're at the root, time to point at our context bank */
-	for (i = 0; i < master->num_streamids; ++i) {
+	if (!master->num_s2crs)
+		master->num_s2crs = master->num_streamids;
+	for (i = 0; i < master->num_s2crs; ++i) {
 		u32 idx, s2cr;
 		idx = master->smrs ? master->smrs[i].idx : master->streamids[i];
 		s2cr = (S2CR_TYPE_TRANS << S2CR_TYPE_SHIFT) |
 		       (smmu_domain->root_cfg.cbndx << S2CR_CBNDX_SHIFT);
+		dev_dbg(smmu->dev, "S2CR%d: 0x%x\n", idx, s2cr);
 		writel_relaxed(s2cr, gr0_base + ARM_SMMU_GR0_S2CR(idx));
 	}
 
@@ -1733,6 +1843,8 @@ static int arm_smmu_device_cfg_probe(struct arm_smmu_device *smmu)
 				mask, sid);
 			return -ENODEV;
 		}
+		smmu->smr_mask_mask = mask;
+		smmu->smr_id_mask = sid;
 
 		dev_notice(smmu->dev,
 			   "\tstream matching with %u register groups, mask 0x%x",
-- 
1.7.9.5
