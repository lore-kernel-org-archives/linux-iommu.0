From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH 2/7] iommu/arm-smmu: Do not access non-existing S2CR registers
Date: Fri, 29 Aug 2014 15:47:40 +0100
Message-ID: <1409323665-9605-3-git-send-email-will.deacon@arm.com>
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

From: Olav Haugan <ohaugan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>

The number of S2CR registers is not properly set when stream
matching is not supported. Fix this and add check that we do not try to
access outside of the number of S2CR regisrers.

Signed-off-by: Olav Haugan <ohaugan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
[will: added missing NUMSIDB_* definitions]
Signed-off-by: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
---
 drivers/iommu/arm-smmu.c | 28 +++++++++++++++++++++-------
 1 file changed, 21 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 98fcd87cbacb..0ba7a1d3df78 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -146,6 +146,8 @@
 #define ID0_CTTW			(1 << 14)
 #define ID0_NUMIRPT_SHIFT		16
 #define ID0_NUMIRPT_MASK		0xff
+#define ID0_NUMSIDB_SHIFT		9
+#define ID0_NUMSIDB_MASK		0xf
 #define ID0_NUMSMRG_SHIFT		0
 #define ID0_NUMSMRG_MASK		0xff
 
@@ -524,9 +526,18 @@ static int register_smmu_master(struct arm_smmu_device *smmu,
 	master->of_node			= masterspec->np;
 	master->cfg.num_streamids	= masterspec->args_count;
 
-	for (i = 0; i < master->cfg.num_streamids; ++i)
-		master->cfg.streamids[i] = masterspec->args[i];
+	for (i = 0; i < master->cfg.num_streamids; ++i) {
+		u16 streamid = masterspec->args[i];
 
+		if (!(smmu->features & ARM_SMMU_FEAT_STREAM_MATCH) &&
+		     (streamid >= smmu->num_mapping_groups)) {
+			dev_err(dev,
+				"stream ID for master device %s greater than maximum allowed (%d)\n",
+				masterspec->np->name, smmu->num_mapping_groups);
+			return -ERANGE;
+		}
+		master->cfg.streamids[i] = streamid;
+	}
 	return insert_smmu_master(smmu, master);
 }
 
@@ -1629,7 +1640,7 @@ static void arm_smmu_device_reset(struct arm_smmu_device *smmu)
 
 	/* Mark all SMRn as invalid and all S2CRn as bypass */
 	for (i = 0; i < smmu->num_mapping_groups; ++i) {
-		writel_relaxed(~SMR_VALID, gr0_base + ARM_SMMU_GR0_SMR(i));
+		writel_relaxed(0, gr0_base + ARM_SMMU_GR0_SMR(i));
 		writel_relaxed(S2CR_TYPE_BYPASS,
 			gr0_base + ARM_SMMU_GR0_S2CR(i));
 	}
@@ -1764,6 +1775,9 @@ static int arm_smmu_device_cfg_probe(struct arm_smmu_device *smmu)
 		dev_notice(smmu->dev,
 			   "\tstream matching with %u register groups, mask 0x%x",
 			   smmu->num_mapping_groups, mask);
+	} else {
+		smmu->num_mapping_groups = (id >> ID0_NUMSIDB_SHIFT) &
+					   ID0_NUMSIDB_MASK;
 	}
 
 	/* ID1 */
@@ -1892,6 +1906,10 @@ static int arm_smmu_device_dt_probe(struct platform_device *pdev)
 		smmu->irqs[i] = irq;
 	}
 
+	err = arm_smmu_device_cfg_probe(smmu);
+	if (err)
+		return err;
+
 	i = 0;
 	smmu->masters = RB_ROOT;
 	while (!of_parse_phandle_with_args(dev->of_node, "mmu-masters",
@@ -1908,10 +1926,6 @@ static int arm_smmu_device_dt_probe(struct platform_device *pdev)
 	}
 	dev_notice(dev, "registered %d master devices\n", i);
 
-	err = arm_smmu_device_cfg_probe(smmu);
-	if (err)
-		goto out_put_masters;
-
 	parse_driver_options(smmu);
 
 	if (smmu->version > 1 &&
-- 
2.1.0
