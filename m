From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 09/11] iommu/mediatek: Make use of iommu_device_register
	interface
Date: Thu,  9 Feb 2017 12:32:58 +0100
Message-ID: <1486639981-32368-10-git-send-email-joro@8bytes.org>
References: <1486639981-32368-1-git-send-email-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1486639981-32368-1-git-send-email-joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, Lorenzo Pieralisi <lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>, Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Cc: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

From: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>

Register individual Mediatek IOMMUs to the iommu core and
add sysfs entries.

Cc: Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Signed-off-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
---
 drivers/iommu/mtk_iommu.c | 26 ++++++++++++++++++++++++++
 drivers/iommu/mtk_iommu.h |  2 ++
 2 files changed, 28 insertions(+)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index 1479c76..d484fa6 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -360,11 +360,15 @@ static phys_addr_t mtk_iommu_iova_to_phys(struct iommu_domain *domain,
 
 static int mtk_iommu_add_device(struct device *dev)
 {
+	struct mtk_iommu_data *data;
 	struct iommu_group *group;
 
 	if (!dev->iommu_fwspec || dev->iommu_fwspec->ops != &mtk_iommu_ops)
 		return -ENODEV; /* Not a iommu client device */
 
+	data = dev->iommu_fwspec->iommu_priv;
+	iommu_device_link(&data->iommu, dev);
+
 	group = iommu_group_get_for_dev(dev);
 	if (IS_ERR(group))
 		return PTR_ERR(group);
@@ -375,9 +379,14 @@ static int mtk_iommu_add_device(struct device *dev)
 
 static void mtk_iommu_remove_device(struct device *dev)
 {
+	struct mtk_iommu_data *data;
+
 	if (!dev->iommu_fwspec || dev->iommu_fwspec->ops != &mtk_iommu_ops)
 		return;
 
+	data = dev->iommu_fwspec->iommu_priv;
+	iommu_device_unlink(&data->iommu, dev);
+
 	iommu_group_remove_device(dev);
 	iommu_fwspec_free(dev);
 }
@@ -497,6 +506,7 @@ static int mtk_iommu_probe(struct platform_device *pdev)
 	struct mtk_iommu_data   *data;
 	struct device           *dev = &pdev->dev;
 	struct resource         *res;
+	resource_size_t		ioaddr;
 	struct component_match  *match = NULL;
 	void                    *protect;
 	int                     i, larb_nr, ret;
@@ -519,6 +529,7 @@ static int mtk_iommu_probe(struct platform_device *pdev)
 	data->base = devm_ioremap_resource(dev, res);
 	if (IS_ERR(data->base))
 		return PTR_ERR(data->base);
+	ioaddr = res->start;
 
 	data->irq = platform_get_irq(pdev, 0);
 	if (data->irq < 0)
@@ -567,6 +578,18 @@ static int mtk_iommu_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	ret = iommu_device_sysfs_add(&data->iommu, dev, NULL,
+				     "mtk-iommu.%pa", &ioaddr);
+	if (ret)
+		return ret;
+
+	iommu_device_set_ops(&data->iommu, &mtk_iommu_ops);
+	iommu_device_set_fwnode(&data->iommu, &pdev->dev.of_node->fwnode);
+
+	ret = iommu_device_register(&data->iommu);
+	if (ret)
+		return ret;
+
 	if (!iommu_present(&platform_bus_type))
 		bus_set_iommu(&platform_bus_type, &mtk_iommu_ops);
 
@@ -577,6 +600,9 @@ static int mtk_iommu_remove(struct platform_device *pdev)
 {
 	struct mtk_iommu_data *data = platform_get_drvdata(pdev);
 
+	iommu_device_sysfs_remove(&data->iommu);
+	iommu_device_unregister(&data->iommu);
+
 	if (iommu_present(&platform_bus_type))
 		bus_set_iommu(&platform_bus_type, NULL);
 
diff --git a/drivers/iommu/mtk_iommu.h b/drivers/iommu/mtk_iommu.h
index 50177f7..2a28ead 100644
--- a/drivers/iommu/mtk_iommu.h
+++ b/drivers/iommu/mtk_iommu.h
@@ -47,6 +47,8 @@ struct mtk_iommu_data {
 	struct iommu_group		*m4u_group;
 	struct mtk_smi_iommu		smi_imu;      /* SMI larb iommu info */
 	bool                            enable_4GB;
+
+	struct iommu_device		iommu;
 };
 
 static inline int compare_of(struct device *dev, void *data)
-- 
1.9.1
