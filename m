From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 5/5] iommu/omap: Add iommu-group support
Date: Fri, 31 Mar 2017 14:10:48 +0200
Message-ID: <1490962248-12602-6-git-send-email-joro@8bytes.org>
References: <1490962248-12602-1-git-send-email-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1490962248-12602-1-git-send-email-joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

From: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>

Support for IOMMU groups will become mandatory for drivers,
so add it to the omap iommu driver.

Signed-off-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
---
 drivers/iommu/omap-iommu.c | 43 +++++++++++++++++++++++++++++++++++++++++--
 drivers/iommu/omap-iommu.h |  1 +
 2 files changed, 42 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/omap-iommu.c b/drivers/iommu/omap-iommu.c
index 5e3a946..bd5e014 100644
--- a/drivers/iommu/omap-iommu.c
+++ b/drivers/iommu/omap-iommu.c
@@ -948,26 +948,42 @@ static int omap_iommu_probe(struct platform_device *pdev)
 	pm_runtime_irq_safe(obj->dev);
 	pm_runtime_enable(obj->dev);
 
+	obj->group = iommu_group_alloc();
+	if (IS_ERR(obj->group))
+		return PTR_ERR(obj->group);
+
 	err = iommu_device_sysfs_add(&obj->iommu, obj->dev, NULL, obj->name);
 	if (err)
-		return err;
+		goto out_group;
 
 	iommu_device_set_ops(&obj->iommu, &omap_iommu_ops);
 
 	err = iommu_device_register(&obj->iommu);
 	if (err)
-		return err;
+		goto out_sysfs;
 
 	omap_iommu_debugfs_add(obj);
 
 	dev_info(&pdev->dev, "%s registered\n", obj->name);
+
 	return 0;
+
+out_sysfs:
+	iommu_device_sysfs_remove(&obj->iommu);
+
+out_group:
+	iommu_group_put(obj->group);
+
+	return err;
 }
 
 static int omap_iommu_remove(struct platform_device *pdev)
 {
 	struct omap_iommu *obj = platform_get_drvdata(pdev);
 
+	iommu_group_put(obj->group);
+	obj->group = NULL;
+
 	iommu_device_sysfs_remove(&obj->iommu);
 	iommu_device_unregister(&obj->iommu);
 
@@ -1217,6 +1233,7 @@ static phys_addr_t omap_iommu_iova_to_phys(struct iommu_domain *domain,
 static int omap_iommu_add_device(struct device *dev)
 {
 	struct omap_iommu_arch_data *arch_data;
+	struct iommu_group *group;
 	struct omap_iommu *iommu;
 	struct device_node *np;
 	struct platform_device *pdev;
@@ -1262,6 +1279,15 @@ static int omap_iommu_add_device(struct device *dev)
 	arch_data->iommu_dev = iommu;
 	dev->archdata.iommu = arch_data;
 
+	/*
+	 * IOMMU group initialization calls into omap_device_group, which needs
+	 * a valid dev->archdata.iommu pointer
+	 */
+	group = iommu_group_get_for_dev(dev);
+	if (IS_ERR(group))
+		return PTR_ERR(group);
+	iommu_group_put(group);
+
 	of_node_put(np);
 
 	return 0;
@@ -1275,12 +1301,24 @@ static void omap_iommu_remove_device(struct device *dev)
 		return;
 
 	iommu_device_unlink(&arch_data->iommu_dev->iommu, dev);
+	iommu_group_remove_device(dev);
 
 	dev->archdata.iommu = NULL;
 	kfree(arch_data);
 
 }
 
+static struct iommu_group *omap_device_group(struct device *dev)
+{
+	struct omap_iommu_arch_data *arch_data = dev->archdata.iommu;
+	struct iommu_group *group = NULL;
+
+	if (arch_data->iommu_dev)
+		group = arch_data->iommu_dev->group;
+
+	return group;
+}
+
 static const struct iommu_ops omap_iommu_ops = {
 	.domain_alloc	= omap_iommu_domain_alloc,
 	.domain_free	= omap_iommu_domain_free,
@@ -1292,6 +1330,7 @@ static void omap_iommu_remove_device(struct device *dev)
 	.iova_to_phys	= omap_iommu_iova_to_phys,
 	.add_device	= omap_iommu_add_device,
 	.remove_device	= omap_iommu_remove_device,
+	.device_group	= omap_device_group,
 	.pgsize_bitmap	= OMAP_IOMMU_PGSIZES,
 };
 
diff --git a/drivers/iommu/omap-iommu.h b/drivers/iommu/omap-iommu.h
index 07e6ea1..28483c5 100644
--- a/drivers/iommu/omap-iommu.h
+++ b/drivers/iommu/omap-iommu.h
@@ -69,6 +69,7 @@ struct omap_iommu {
 	u32 id;
 
 	struct iommu_device iommu;
+	struct iommu_group *group;
 };
 
 /**
-- 
1.9.1
