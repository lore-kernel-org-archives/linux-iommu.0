From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 6/8] iommu/arm-smmu: Switch to device_group call-back
Date: Wed, 21 Oct 2015 23:51:41 +0200
Message-ID: <1445464303-18206-7-git-send-email-joro@8bytes.org>
References: <1445464303-18206-1-git-send-email-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1445464303-18206-1-git-send-email-joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
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
Cc: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

From: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>

This converts the ARM SMMU and the SMMUv3 driver to use the
new device_group call-back.

Cc: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Signed-off-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
---
 drivers/iommu/arm-smmu-v3.c |  1 +
 drivers/iommu/arm-smmu.c    | 77 +++++++++++++++++++++++++++------------------
 2 files changed, 47 insertions(+), 31 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 286e890..e9e591c 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -1902,6 +1902,7 @@ static struct iommu_ops arm_smmu_ops = {
 	.iova_to_phys		= arm_smmu_iova_to_phys,
 	.add_device		= arm_smmu_add_device,
 	.remove_device		= arm_smmu_remove_device,
+	.device_group		= pci_device_group,
 	.domain_get_attr	= arm_smmu_domain_get_attr,
 	.domain_set_attr	= arm_smmu_domain_set_attr,
 	.pgsize_bitmap		= -1UL, /* Restricted during device attach */
diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 48a39df..b4c0629 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -1292,33 +1292,25 @@ static void __arm_smmu_release_pci_iommudata(void *data)
 	kfree(data);
 }
 
-static int arm_smmu_add_pci_device(struct pci_dev *pdev)
+static int arm_smmu_init_pci_device(struct pci_dev *pdev,
+				    struct iommu_group *group)
 {
-	int i, ret;
-	u16 sid;
-	struct iommu_group *group;
 	struct arm_smmu_master_cfg *cfg;
-
-	group = iommu_group_get_for_dev(&pdev->dev);
-	if (IS_ERR(group))
-		return PTR_ERR(group);
+	u16 sid;
+	int i;
 
 	cfg = iommu_group_get_iommudata(group);
 	if (!cfg) {
 		cfg = kzalloc(sizeof(*cfg), GFP_KERNEL);
-		if (!cfg) {
-			ret = -ENOMEM;
-			goto out_put_group;
-		}
+		if (!cfg)
+			return -ENOMEM;
 
 		iommu_group_set_iommudata(group, cfg,
 					  __arm_smmu_release_pci_iommudata);
 	}
 
-	if (cfg->num_streamids >= MAX_MASTER_STREAMIDS) {
-		ret = -ENOSPC;
-		goto out_put_group;
-	}
+	if (cfg->num_streamids >= MAX_MASTER_STREAMIDS)
+		return -ENOSPC;
 
 	/*
 	 * Assume Stream ID == Requester ID for now.
@@ -1334,16 +1326,13 @@ static int arm_smmu_add_pci_device(struct pci_dev *pdev)
 		cfg->streamids[cfg->num_streamids++] = sid;
 
 	return 0;
-out_put_group:
-	iommu_group_put(group);
-	return ret;
 }
 
-static int arm_smmu_add_platform_device(struct device *dev)
+static int arm_smmu_init_platform_device(struct device *dev,
+					 struct iommu_group *group)
 {
-	struct iommu_group *group;
-	struct arm_smmu_master *master;
 	struct arm_smmu_device *smmu = find_smmu_for_device(dev);
+	struct arm_smmu_master *master;
 
 	if (!smmu)
 		return -ENODEV;
@@ -1352,21 +1341,20 @@ static int arm_smmu_add_platform_device(struct device *dev)
 	if (!master)
 		return -ENODEV;
 
-	/* No automatic group creation for platform devices */
-	group = iommu_group_alloc();
-	if (IS_ERR(group))
-		return PTR_ERR(group);
-
 	iommu_group_set_iommudata(group, &master->cfg, NULL);
-	return iommu_group_add_device(group, dev);
+
+	return 0;
 }
 
 static int arm_smmu_add_device(struct device *dev)
 {
-	if (dev_is_pci(dev))
-		return arm_smmu_add_pci_device(to_pci_dev(dev));
+	struct iommu_group *group;
 
-	return arm_smmu_add_platform_device(dev);
+	group = iommu_group_get_for_dev(dev);
+	if (IS_ERR(group))
+		return PTR_ERR(group);
+
+	return 0;
 }
 
 static void arm_smmu_remove_device(struct device *dev)
@@ -1374,6 +1362,32 @@ static void arm_smmu_remove_device(struct device *dev)
 	iommu_group_remove_device(dev);
 }
 
+static struct iommu_group *arm_smmu_device_group(struct device *dev)
+{
+	struct iommu_group *group;
+	int ret;
+
+	if (dev_is_pci(dev))
+		group = pci_device_group(dev);
+	else
+		group = generic_device_group(dev);
+
+	if (IS_ERR(group))
+		return group;
+
+	if (dev_is_pci(dev))
+		ret = arm_smmu_init_pci_device(to_pci_dev(dev), group);
+	else
+		ret = arm_smmu_init_platform_device(dev, group);
+
+	if (ret) {
+		iommu_group_put(group);
+		group = ERR_PTR(ret);
+	}
+
+	return group;
+}
+
 static int arm_smmu_domain_get_attr(struct iommu_domain *domain,
 				    enum iommu_attr attr, void *data)
 {
@@ -1430,6 +1444,7 @@ static struct iommu_ops arm_smmu_ops = {
 	.iova_to_phys		= arm_smmu_iova_to_phys,
 	.add_device		= arm_smmu_add_device,
 	.remove_device		= arm_smmu_remove_device,
+	.device_group		= arm_smmu_device_group,
 	.domain_get_attr	= arm_smmu_domain_get_attr,
 	.domain_set_attr	= arm_smmu_domain_set_attr,
 	.pgsize_bitmap		= -1UL, /* Restricted during device attach */
-- 
1.9.1
