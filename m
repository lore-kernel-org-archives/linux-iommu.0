From: Navneet Kumar <navneetk-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 4/5] iommu/tegra-smmu: Add PCI support
Date: Wed, 16 Jan 2019 12:50:13 -0800
Message-ID: <1547671814-30088-4-git-send-email-navneetk@nvidia.com>
References: <1547671814-30088-1-git-send-email-navneetk@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1547671814-30088-1-git-send-email-navneetk-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org
Cc: linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, navneetk-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Add support for PCI devices.

Signed-off-by: Navneet Kumar <navneetk-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
---
 drivers/iommu/tegra-smmu.c | 47 +++++++++++++++++++++++++++++++++-------------
 1 file changed, 34 insertions(+), 13 deletions(-)

diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
index 1a44cf6..4b43c63 100644
--- a/drivers/iommu/tegra-smmu.c
+++ b/drivers/iommu/tegra-smmu.c
@@ -17,6 +17,7 @@
 #include <linux/slab.h>
 #include <linux/dma-mapping.h>
 #include <linux/dma-iommu.h>
+#include <linux/pci.h>
 
 #include <soc/tegra/ahb.h>
 #include <soc/tegra/mc.h>
@@ -820,7 +821,8 @@ tegra_smmu_find_group(struct tegra_smmu *smmu, unsigned int swgroup)
 	return NULL;
 }
 
-static struct iommu_group *tegra_smmu_group_get(struct tegra_smmu *smmu,
+static struct iommu_group *tegra_smmu_group_get(struct device *dev,
+						struct tegra_smmu *smmu,
 						unsigned int swgroup)
 {
 	const struct tegra_smmu_group_soc *soc;
@@ -847,7 +849,11 @@ static struct iommu_group *tegra_smmu_group_get(struct tegra_smmu *smmu,
 	INIT_LIST_HEAD(&group->list);
 	group->soc = soc;
 
-	group->group = iommu_group_alloc();
+	if (dev_is_pci(dev))
+		group->group = pci_device_group(dev);
+	else
+		group->group = generic_device_group(dev);
+
 	if (IS_ERR(group->group)) {
 		devm_kfree(smmu->dev, group);
 		mutex_unlock(&smmu->lock);
@@ -864,13 +870,8 @@ static struct iommu_group *tegra_smmu_device_group(struct device *dev)
 {
 	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
 	struct tegra_smmu *smmu = dev->archdata.iommu;
-	struct iommu_group *group;
 
-	group = tegra_smmu_group_get(smmu, fwspec->ids[0]);
-	if (!group)
-		group = generic_device_group(dev);
-
-	return group;
+	return tegra_smmu_group_get(dev, smmu, fwspec->ids[0]);
 }
 
 static int tegra_smmu_of_xlate(struct device *dev,
@@ -989,6 +990,28 @@ static void tegra_smmu_debugfs_exit(struct tegra_smmu *smmu)
 	debugfs_remove_recursive(smmu->debugfs);
 }
 
+static int tegra_smmu_iommu_bus_init(struct tegra_smmu *smmu)
+{
+	int err;
+
+	err = bus_set_iommu(&platform_bus_type, &tegra_smmu_ops);
+	if (err < 0) {
+		iommu_device_unregister(&smmu->iommu);
+		iommu_device_sysfs_remove(&smmu->iommu);
+		return err;
+	}
+
+#ifdef CONFIG_PCI
+	if (!iommu_present(&pci_bus_type)) {
+		pci_request_acs();
+		err = bus_set_iommu(&pci_bus_type, &tegra_smmu_ops);
+		if (err < 0)
+			return err;
+	}
+#endif
+	return 0;
+}
+
 struct tegra_smmu *tegra_smmu_probe(struct device *dev,
 				    const struct tegra_smmu_soc *soc,
 				    struct tegra_mc *mc)
@@ -1072,12 +1095,10 @@ struct tegra_smmu *tegra_smmu_probe(struct device *dev,
 		return ERR_PTR(err);
 	}
 
-	err = bus_set_iommu(&platform_bus_type, &tegra_smmu_ops);
-	if (err < 0) {
-		iommu_device_unregister(&smmu->iommu);
-		iommu_device_sysfs_remove(&smmu->iommu);
+	err = tegra_smmu_iommu_bus_init(smmu);
+	if (err)
 		return ERR_PTR(err);
-	}
+	err = bus_set_iommu(&platform_bus_type, &tegra_smmu_ops);
 
 	if (IS_ENABLED(CONFIG_DEBUG_FS))
 		tegra_smmu_debugfs_init(smmu);
-- 
2.7.4
