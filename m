From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [PATCH] iommu/mediatek: Teach MTK-IOMMUv1 about 'struct iommu_device'
Date: Fri, 31 Mar 2017 16:29:13 +0200
Message-ID: <1490970553-19787-1-git-send-email-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

From: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>

Make use of the iommu_device_register() interface.

Signed-off-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
---
 drivers/iommu/mtk_iommu_v1.c | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/mtk_iommu_v1.c b/drivers/iommu/mtk_iommu_v1.c
index 19e0100..a27ef57 100644
--- a/drivers/iommu/mtk_iommu_v1.c
+++ b/drivers/iommu/mtk_iommu_v1.c
@@ -431,9 +431,10 @@ static int mtk_iommu_create_mapping(struct device *dev,
 
 static int mtk_iommu_add_device(struct device *dev)
 {
-	struct iommu_group *group;
 	struct of_phandle_args iommu_spec;
 	struct of_phandle_iterator it;
+	struct mtk_iommu_data *data;
+	struct iommu_group *group;
 	int err;
 
 	of_for_each_phandle(&it, err, dev->of_node, "iommus",
@@ -450,6 +451,9 @@ static int mtk_iommu_add_device(struct device *dev)
 	if (!dev->iommu_fwspec || dev->iommu_fwspec->ops != &mtk_iommu_ops)
 		return -ENODEV; /* Not a iommu client device */
 
+	data = dev->iommu_fwspec->iommu_priv;
+	iommu_device_link(&data->iommu, dev);
+
 	group = iommu_group_get_for_dev(dev);
 	if (IS_ERR(group))
 		return PTR_ERR(group);
@@ -460,9 +464,14 @@ static int mtk_iommu_add_device(struct device *dev)
 
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
@@ -627,6 +636,17 @@ static int mtk_iommu_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	ret = iommu_device_sysfs_add(&data->iommu, &pdev->dev, NULL,
+				     dev_name(&pdev->dev));
+	if (ret)
+		return ret;
+
+	iommu_device_set_ops(&data->iommu, &mtk_iommu_ops);
+
+	ret = iommu_device_register(&data->iommu);
+	if (ret)
+		return ret;
+
 	if (!iommu_present(&platform_bus_type))
 		bus_set_iommu(&platform_bus_type,  &mtk_iommu_ops);
 
@@ -637,6 +657,9 @@ static int mtk_iommu_remove(struct platform_device *pdev)
 {
 	struct mtk_iommu_data *data = platform_get_drvdata(pdev);
 
+	iommu_device_sysfs_remove(&data->iommu);
+	iommu_device_unregister(&data->iommu);
+
 	if (iommu_present(&platform_bus_type))
 		bus_set_iommu(&platform_bus_type, NULL);
 
-- 
1.9.1
