From: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: [PATCHv3 08/19] iommu/tegra: smmu: Register platform_device to IOMMU dynamically
Date: Fri, 18 Oct 2013 13:26:49 +0300
Message-ID: <1382092020-13170-9-git-send-email-hdoyu@nvidia.com>
References: <1382092020-13170-1-git-send-email-hdoyu@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1382092020-13170-1-git-send-email-hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Register platform_devices to IOMMU dynamically via
ops->{add,remove}_device().

Signed-off-by: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
---
 drivers/iommu/tegra-smmu.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
index 4671579..710c671 100644
--- a/drivers/iommu/tegra-smmu.c
+++ b/drivers/iommu/tegra-smmu.c
@@ -950,6 +950,39 @@ static void smmu_iommu_domain_destroy(struct iommu_domain *domain)
 	dev_dbg(smmu->dev, "smmu_as@%p\n", as);
 }
 
+/*
+ * ASID[0] for the system default
+ * ASID[1] for PPCS("AHB bus children"), which has SDMMC
+ * ASID[2][3].. open for drivers, first come, first served.
+ */
+enum {
+	SYSTEM_DEFAULT,
+	SYSTEM_PROTECTED,
+};
+
+static int smmu_iommu_add_device(struct device *dev)
+{
+	int err;
+	struct dma_iommu_mapping *map = smmu_handle->map[SYSTEM_DEFAULT];
+
+	if (!map)
+		goto out;
+
+	err = arm_iommu_attach_device(dev, map);
+	if (err)
+		return err;
+
+out:
+	dev_dbg(dev, "Attached to map %p\n", map);
+	return 0;
+}
+
+static void smmu_iommu_remove_device(struct device *dev)
+{
+	dev_dbg(dev, "Detaching from map %p\n", to_dma_iommu_mapping(dev));
+	arm_iommu_detach_device(dev);
+}
+
 static struct iommu_ops smmu_iommu_ops = {
 	.domain_init	= smmu_iommu_domain_init,
 	.domain_destroy	= smmu_iommu_domain_destroy,
@@ -959,6 +992,8 @@ static struct iommu_ops smmu_iommu_ops = {
 	.unmap		= smmu_iommu_unmap,
 	.iova_to_phys	= smmu_iommu_iova_to_phys,
 	.domain_has_cap	= smmu_iommu_domain_has_cap,
+	.add_device	= smmu_iommu_add_device,
+	.remove_device	= smmu_iommu_remove_device,
 	.pgsize_bitmap	= SMMU_IOMMU_PGSIZES,
 };
 
-- 
1.8.1.5
