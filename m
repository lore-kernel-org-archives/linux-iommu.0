From: Andreas Herrmann <andreas.herrmann-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 05/11] iommu/arm-smmu: Check for duplicate stream IDs when
	registering master devices
Date: Thu, 16 Jan 2014 13:44:17 +0100
Message-ID: <1389876263-25759-6-git-send-email-andreas.herrmann@calxeda.com>
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

Cc: Andreas Herrmann <herrmann.der.user-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Signed-off-by: Andreas Herrmann <andreas.herrmann-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>
---
 drivers/iommu/arm-smmu.c |   25 ++++++++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 02a871e..a4e0c93 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -56,6 +56,9 @@
 /* Maximum number of stream IDs assigned to a single device */
 #define MAX_MASTER_STREAMIDS		8
 
+/* Maximum stream ID */
+#define ARM_SMMU_MAX_STREAMID		(SZ_64K - 1)
+
 /* Maximum number of context banks per SMMU */
 #define ARM_SMMU_MAX_CBS		128
 
@@ -386,6 +389,8 @@ struct arm_smmu_device {
 	u32				smr_mask_mask;
 	u32				smr_id_mask;
 
+	unsigned long			*sids;
+
 	struct list_head		list;
 	struct rb_root			masters;
 };
@@ -491,7 +496,7 @@ static int register_smmu_master(struct arm_smmu_device *smmu,
 				struct device *dev,
 				struct of_phandle_args *masterspec)
 {
-	int i;
+	int i, sid;
 	struct arm_smmu_master *master;
 
 	master = find_smmu_master(smmu, masterspec->np);
@@ -516,8 +521,14 @@ static int register_smmu_master(struct arm_smmu_device *smmu,
 	master->of_node		= masterspec->np;
 	master->num_streamids	= masterspec->args_count;
 
-	for (i = 0; i < master->num_streamids; ++i)
-		master->streamids[i] = masterspec->args[i];
+	for (i = 0; i < master->num_streamids; ++i) {
+		sid = masterspec->args[i];
+		if (test_and_set_bit(sid, smmu->sids)) {
+			dev_err(dev, "duplicate stream ID (%d)\n", sid);
+			return -EEXIST;
+		}
+		master->streamids[i] = sid;
+	}
 
 	return insert_smmu_master(smmu, master);
 }
@@ -1934,6 +1945,14 @@ static int arm_smmu_device_dt_probe(struct platform_device *pdev)
 	}
 	smmu->dev = dev;
 
+	smmu->sids = devm_kzalloc(dev, BITS_TO_LONGS(ARM_SMMU_MAX_STREAMID) *
+				sizeof(long), GFP_KERNEL);
+	if (!smmu->sids) {
+		dev_err(dev,
+			"failed to allocate bitmap for stream ID tracking\n");
+		return -ENOMEM;
+	}
+
 	check_driver_options(smmu);
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-- 
1.7.9.5
