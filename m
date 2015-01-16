From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH 2/2] iommu/arm-smmu: remove homebrew PCI dma alias parsing
Date: Fri, 16 Jan 2015 16:58:34 +0000
Message-ID: <1421427514-16579-3-git-send-email-will.deacon@arm.com>
References: <1421427514-16579-1-git-send-email-will.deacon@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1421427514-16579-1-git-send-email-will.deacon-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
Cc: m-karicheri2-l0cyMroinI0@public.gmane.org, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Core code can walk the PCI topology and extract the DMA alias for us
whilst retrieving the IOMMU group for a device, so use that instead.

Signed-off-by: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
---
 drivers/iommu/arm-smmu.c | 58 ++++++++++++++++++++++++++----------------------
 1 file changed, 31 insertions(+), 27 deletions(-)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 006f006c35e9..779c248a140d 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -1255,12 +1255,6 @@ static bool arm_smmu_capable(enum iommu_cap cap)
 	}
 }
 
-static int __arm_smmu_get_pci_sid(struct pci_dev *pdev, u16 alias, void *data)
-{
-	*((u16 *)data) = alias;
-	return 0; /* Continue walking */
-}
-
 static void __arm_smmu_release_pci_iommudata(void *data)
 {
 	kfree(data);
@@ -1269,56 +1263,66 @@ static void __arm_smmu_release_pci_iommudata(void *data)
 static int arm_smmu_add_device(struct device *dev)
 {
 	struct arm_smmu_device *smmu;
-	struct arm_smmu_master_cfg *cfg;
 	struct iommu_group *group;
-	void (*releasefn)(void *) = NULL;
 	int ret;
 
 	smmu = find_smmu_for_device(dev);
 	if (!smmu)
 		return -ENODEV;
 
-	group = iommu_group_alloc();
-	if (IS_ERR(group)) {
-		dev_err(dev, "Failed to allocate IOMMU group\n");
-		return PTR_ERR(group);
-	}
-
 	if (dev_is_pci(dev)) {
+		u16 sid;
+		struct arm_smmu_master_cfg *cfg;
 		struct pci_dev *pdev = to_pci_dev(dev);
+		void (*releasefn)(void *) = __arm_smmu_release_pci_iommudata;
 
-		cfg = kzalloc(sizeof(*cfg), GFP_KERNEL);
+		group = iommu_group_get_for_pci_dev(pdev, &sid);
+		if (IS_ERR(group))
+			goto out_no_group;
+
+		cfg = iommu_group_get_iommudata(group);
 		if (!cfg) {
-			ret = -ENOMEM;
+			cfg = kzalloc(sizeof(*cfg), GFP_KERNEL);
+			if (!cfg) {
+				ret = -ENOMEM;
+				goto out_put_group;
+			}
+
+			iommu_group_set_iommudata(group, cfg, releasefn);
+		}
+
+		if (cfg->num_streamids >= MAX_MASTER_STREAMIDS) {
+			ret = -ENOSPC;
 			goto out_put_group;
 		}
 
-		cfg->num_streamids = 1;
 		/*
 		 * Assume Stream ID == Requester ID for now.
 		 * We need a way to describe the ID mappings in FDT.
 		 */
-		pci_for_each_dma_alias(pdev, __arm_smmu_get_pci_sid,
-				       &cfg->streamids[0]);
-		releasefn = __arm_smmu_release_pci_iommudata;
+		cfg->streamids[cfg->num_streamids++] = sid;
 	} else {
 		struct arm_smmu_master *master;
 
 		master = find_smmu_master(smmu, dev->of_node);
-		if (!master) {
-			ret = -ENODEV;
-			goto out_put_group;
-		}
+		if (!master)
+			return -ENODEV;
+
+		group = iommu_group_alloc();
+		if (IS_ERR(group))
+			goto out_no_group;
 
-		cfg = &master->cfg;
+		iommu_group_set_iommudata(group, &master->cfg, NULL);
 	}
 
-	iommu_group_set_iommudata(group, cfg, releasefn);
-	ret = iommu_group_add_device(group, dev);
+	return iommu_group_add_device(group, dev);
 
 out_put_group:
 	iommu_group_put(group);
 	return ret;
+out_no_group:
+	dev_err(dev, "Failed to allocate IOMMU group\n");
+	return PTR_ERR(group);
 }
 
 static void arm_smmu_remove_device(struct device *dev)
-- 
2.1.4
