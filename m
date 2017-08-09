From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 2/2] iommu/tegra-gart: Add support for struct iommu_device
Date: Thu, 10 Aug 2017 00:29:12 +0200
Message-ID: <1502317752-8792-3-git-send-email-joro@8bytes.org>
References: <1502317752-8792-1-git-send-email-joro@8bytes.org>
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1502317752-8792-1-git-send-email-joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jonathan Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

From: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>

Add a struct iommu_device to each tegra-gart and register it
with the iommu-core. Also link devices added to the driver
to their respective hardware iommus.

Signed-off-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
---
 drivers/iommu/tegra-gart.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/iommu/tegra-gart.c b/drivers/iommu/tegra-gart.c
index 29bafc6..b62f790 100644
--- a/drivers/iommu/tegra-gart.c
+++ b/drivers/iommu/tegra-gart.c
@@ -61,6 +61,8 @@ struct gart_device {
 	struct list_head	client;
 	spinlock_t		client_lock;	/* for client list */
 	struct device		*dev;
+
+	struct iommu_device	iommu;		/* IOMMU Core handle */
 };
 
 struct gart_domain {
@@ -342,12 +344,16 @@ static int gart_iommu_add_device(struct device *dev)
 		return PTR_ERR(group);
 
 	iommu_group_put(group);
+
+	iommu_device_link(&gart_handle->iommu, dev);
+
 	return 0;
 }
 
 static void gart_iommu_remove_device(struct device *dev)
 {
 	iommu_group_remove_device(dev);
+	iommu_device_unlink(&gart_handle->iommu, dev);
 }
 
 static const struct iommu_ops gart_iommu_ops = {
@@ -397,6 +403,7 @@ static int tegra_gart_probe(struct platform_device *pdev)
 	struct resource *res, *res_remap;
 	void __iomem *gart_regs;
 	struct device *dev = &pdev->dev;
+	int ret;
 
 	if (gart_handle)
 		return -EIO;
@@ -423,6 +430,22 @@ static int tegra_gart_probe(struct platform_device *pdev)
 		return -ENXIO;
 	}
 
+	ret = iommu_device_sysfs_add(&gart->iommu, &pdev->dev, NULL,
+				     dev_name(&pdev->dev));
+	if (ret) {
+		dev_err(dev, "Failed to register IOMMU in sysfs\n");
+		return ret;
+	}
+
+	iommu_device_set_ops(&gart->iommu, &gart_iommu_ops);
+
+	ret = iommu_device_register(&gart->iommu);
+	if (ret) {
+		dev_err(dev, "Failed to register IOMMU\n");
+		iommu_device_sysfs_remove(&gart->iommu);
+		return ret;
+	}
+
 	gart->dev = &pdev->dev;
 	spin_lock_init(&gart->pte_lock);
 	spin_lock_init(&gart->client_lock);
@@ -449,6 +472,9 @@ static int tegra_gart_remove(struct platform_device *pdev)
 {
 	struct gart_device *gart = platform_get_drvdata(pdev);
 
+	iommu_device_unregister(&gart->iommu);
+	iommu_device_sysfs_remove(&gart->iommu);
+
 	writel(0, gart->regs + GART_CONFIG);
 	if (gart->savedata)
 		vfree(gart->savedata);
-- 
2.7.4
