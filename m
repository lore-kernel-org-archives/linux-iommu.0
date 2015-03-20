From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH 3/4] iommu/arm-smmu: handle multi-alias IOMMU groups for PCI
	devices
Date: Fri, 20 Mar 2015 18:15:36 +0000
Message-ID: <1426875337-12808-4-git-send-email-will.deacon@arm.com>
References: <1426875337-12808-1-git-send-email-will.deacon@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1426875337-12808-1-git-send-email-will.deacon-5wv7dgnIgG8@public.gmane.org>
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
Cc: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

IOMMU groups for PCI devices can correspond to multiple DMA aliases due
to things like ACS and PCI quirks.

This patch extends the ARM SMMU ->add_device callback so that we
consider all of the DMA aliases for a PCI IOMMU group, rather than
creating a separate group for each Requester ID.

Signed-off-by: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
---
 drivers/iommu/arm-smmu.c | 92 ++++++++++++++++++++++++++++++------------------
 1 file changed, 57 insertions(+), 35 deletions(-)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 161dd46999e2..6ac184669295 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -1330,61 +1330,83 @@ static void __arm_smmu_release_pci_iommudata(void *data)
 	kfree(data);
 }
 
-static int arm_smmu_add_device(struct device *dev)
+static int arm_smmu_add_pci_device(struct pci_dev *pdev)
 {
-	struct arm_smmu_device *smmu;
-	struct arm_smmu_master_cfg *cfg;
+	int i, ret;
+	u16 sid;
 	struct iommu_group *group;
-	void (*releasefn)(void *) = NULL;
-	int ret;
-
-	smmu = find_smmu_for_device(dev);
-	if (!smmu)
-		return -ENODEV;
+	struct arm_smmu_master_cfg *cfg;
 
-	group = iommu_group_alloc();
-	if (IS_ERR(group)) {
-		dev_err(dev, "Failed to allocate IOMMU group\n");
+	group = iommu_group_get_for_dev(&pdev->dev);
+	if (IS_ERR(group))
 		return PTR_ERR(group);
-	}
-
-	if (dev_is_pci(dev)) {
-		struct pci_dev *pdev = to_pci_dev(dev);
 
+	cfg = iommu_group_get_iommudata(group);
+	if (!cfg) {
 		cfg = kzalloc(sizeof(*cfg), GFP_KERNEL);
 		if (!cfg) {
 			ret = -ENOMEM;
 			goto out_put_group;
 		}
 
-		cfg->num_streamids = 1;
-		/*
-		 * Assume Stream ID == Requester ID for now.
-		 * We need a way to describe the ID mappings in FDT.
-		 */
-		pci_for_each_dma_alias(pdev, __arm_smmu_get_pci_sid,
-				       &cfg->streamids[0]);
-		releasefn = __arm_smmu_release_pci_iommudata;
-	} else {
-		struct arm_smmu_master *master;
-
-		master = find_smmu_master(smmu, dev->of_node);
-		if (!master) {
-			ret = -ENODEV;
-			goto out_put_group;
-		}
+		iommu_group_set_iommudata(group, cfg,
+					  __arm_smmu_release_pci_iommudata);
+	}
 
-		cfg = &master->cfg;
+	if (cfg->num_streamids >= MAX_MASTER_STREAMIDS) {
+		ret = -ENOSPC;
+		goto out_put_group;
 	}
 
-	iommu_group_set_iommudata(group, cfg, releasefn);
-	ret = iommu_group_add_device(group, dev);
+	/*
+	 * Assume Stream ID == Requester ID for now.
+	 * We need a way to describe the ID mappings in FDT.
+	 */
+	pci_for_each_dma_alias(pdev, __arm_smmu_get_pci_sid, &sid);
+	for (i = 0; i < cfg->num_streamids; ++i)
+		if (cfg->streamids[i] == sid)
+			break;
+
+	/* Avoid duplicate SIDs, as this can lead to SMR conflicts */
+	if (i == cfg->num_streamids)
+		cfg->streamids[cfg->num_streamids++] = sid;
 
+	return 0;
 out_put_group:
 	iommu_group_put(group);
 	return ret;
 }
 
+static int arm_smmu_add_platform_device(struct device *dev)
+{
+	struct iommu_group *group;
+	struct arm_smmu_master *master;
+	struct arm_smmu_device *smmu = find_smmu_for_device(dev);
+
+	if (!smmu)
+		return -ENODEV;
+
+	master = find_smmu_master(smmu, dev->of_node);
+	if (!master)
+		return -ENODEV;
+
+	/* No automatic group creation for platform devices */
+	group = iommu_group_alloc();
+	if (IS_ERR(group))
+		return PTR_ERR(group);
+
+	iommu_group_set_iommudata(group, &master->cfg, NULL);
+	return iommu_group_add_device(group, dev);
+}
+
+static int arm_smmu_add_device(struct device *dev)
+{
+	if (dev_is_pci(dev))
+		return arm_smmu_add_pci_device(to_pci_dev(dev));
+
+	return arm_smmu_add_platform_device(dev);
+}
+
 static void arm_smmu_remove_device(struct device *dev)
 {
 	iommu_group_remove_device(dev);
-- 
2.1.4
