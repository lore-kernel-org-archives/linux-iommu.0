From: Andreas Herrmann <andreas.herrmann-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 3/6] iommu/arm-smmu: Check for duplicate stream IDs when
	registering master devices
Date: Thu, 30 Jan 2014 19:18:06 +0100
Message-ID: <1391105889-32718-4-git-send-email-andreas.herrmann@calxeda.com>
References: <1391105889-32718-1-git-send-email-andreas.herrmann@calxeda.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1391105889-32718-1-git-send-email-andreas.herrmann-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>
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

If DT information lists one stream ID twice for the master devices of
an SMMU this can cause a multi match when stream ID matching is used.
For stream ID indexing this might trigger an overwrite of an S2CR that
is already in use.

So better check for duplicates when DT information is parsed.

Cc: Andreas Herrmann <herrmann.der.user-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Signed-off-by: Andreas Herrmann <andreas.herrmann-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>
---
 drivers/iommu/arm-smmu.c |   31 ++++++++++++++++++++++++++-----
 1 file changed, 26 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 0438ec1..4a32fde 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -50,6 +50,9 @@
 /* Maximum number of stream IDs assigned to a single device */
 #define MAX_MASTER_STREAMIDS		8
 
+/* Maximum stream ID */
+#define ARM_SMMU_MAX_STREAMID		(SZ_64K - 1)
+
 /* Maximum number of context banks per SMMU */
 #define ARM_SMMU_MAX_CBS		128
 
@@ -482,9 +485,10 @@ static int insert_smmu_master(struct arm_smmu_device *smmu,
 
 static int register_smmu_master(struct arm_smmu_device *smmu,
 				struct device *dev,
-				struct of_phandle_args *masterspec)
+				struct of_phandle_args *masterspec,
+				unsigned long *smmu_sids)
 {
-	int i;
+	int i, sid;
 	struct arm_smmu_master *master;
 
 	master = find_smmu_master(smmu, masterspec->np);
@@ -509,8 +513,14 @@ static int register_smmu_master(struct arm_smmu_device *smmu,
 	master->of_node		= masterspec->np;
 	master->num_streamids	= masterspec->args_count;
 
-	for (i = 0; i < master->num_streamids; ++i)
-		master->streamids[i] = masterspec->args[i];
+	for (i = 0; i < master->num_streamids; ++i) {
+		sid = masterspec->args[i];
+		if (test_and_set_bit(sid, smmu_sids)) {
+			dev_err(dev, "duplicate stream ID (%d)\n", sid);
+			return -EEXIST;
+		}
+		master->streamids[i] = sid;
+	}
 
 	return insert_smmu_master(smmu, master);
 }
@@ -1828,6 +1838,7 @@ static int arm_smmu_device_dt_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct rb_node *node;
 	struct of_phandle_args masterspec;
+	unsigned long *smmu_sids;
 	int num_irqs, i, err;
 
 	smmu = devm_kzalloc(dev, sizeof(*smmu), GFP_KERNEL);
@@ -1878,20 +1889,30 @@ static int arm_smmu_device_dt_probe(struct platform_device *pdev)
 		smmu->irqs[i] = irq;
 	}
 
+	smmu_sids = kzalloc(BITS_TO_LONGS(ARM_SMMU_MAX_STREAMID) *
+			sizeof(long), GFP_KERNEL);
+	if (!smmu_sids) {
+		dev_err(dev,
+			"failed to allocate bitmap for stream ID tracking\n");
+		return -ENOMEM;
+	}
+
 	i = 0;
 	smmu->masters = RB_ROOT;
 	while (!of_parse_phandle_with_args(dev->of_node, "mmu-masters",
 					   "#stream-id-cells", i,
 					   &masterspec)) {
-		err = register_smmu_master(smmu, dev, &masterspec);
+		err = register_smmu_master(smmu, dev, &masterspec, smmu_sids);
 		if (err) {
 			dev_err(dev, "failed to add master %s\n",
 				masterspec.np->name);
+			kfree(smmu_sids);
 			goto out_put_masters;
 		}
 
 		i++;
 	}
+	kfree(smmu_sids);
 	dev_notice(dev, "registered %d master devices\n", i);
 
 	if ((dev_node = of_parse_phandle(dev->of_node, "smmu-parent", 0)))
-- 
1.7.9.5
