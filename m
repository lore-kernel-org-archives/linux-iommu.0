From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 4/5] iommu/omap: Make use of 'struct iommu_device'
Date: Fri, 31 Mar 2017 14:10:47 +0200
Message-ID: <1490962248-12602-5-git-send-email-joro@8bytes.org>
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

Modify the driver to register individual iommus and
establish links between devices and iommus in sysfs.

Signed-off-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
---
 drivers/iommu/omap-iommu.c | 25 +++++++++++++++++++++++++
 drivers/iommu/omap-iommu.h |  2 ++
 2 files changed, 27 insertions(+)

diff --git a/drivers/iommu/omap-iommu.c b/drivers/iommu/omap-iommu.c
index 04b3718..5e3a946 100644
--- a/drivers/iommu/omap-iommu.c
+++ b/drivers/iommu/omap-iommu.c
@@ -36,6 +36,8 @@
 #include "omap-iopgtable.h"
 #include "omap-iommu.h"
 
+static const struct iommu_ops omap_iommu_ops;
+
 #define to_iommu(dev)							\
 	((struct omap_iommu *)platform_get_drvdata(to_platform_device(dev)))
 
@@ -946,6 +948,16 @@ static int omap_iommu_probe(struct platform_device *pdev)
 	pm_runtime_irq_safe(obj->dev);
 	pm_runtime_enable(obj->dev);
 
+	err = iommu_device_sysfs_add(&obj->iommu, obj->dev, NULL, obj->name);
+	if (err)
+		return err;
+
+	iommu_device_set_ops(&obj->iommu, &omap_iommu_ops);
+
+	err = iommu_device_register(&obj->iommu);
+	if (err)
+		return err;
+
 	omap_iommu_debugfs_add(obj);
 
 	dev_info(&pdev->dev, "%s registered\n", obj->name);
@@ -956,6 +968,9 @@ static int omap_iommu_remove(struct platform_device *pdev)
 {
 	struct omap_iommu *obj = platform_get_drvdata(pdev);
 
+	iommu_device_sysfs_remove(&obj->iommu);
+	iommu_device_unregister(&obj->iommu);
+
 	omap_iommu_debugfs_remove(obj);
 
 	pm_runtime_disable(obj->dev);
@@ -1205,6 +1220,7 @@ static int omap_iommu_add_device(struct device *dev)
 	struct omap_iommu *iommu;
 	struct device_node *np;
 	struct platform_device *pdev;
+	int ret;
 
 	/*
 	 * Allocate the archdata iommu structure for DT-based devices.
@@ -1237,6 +1253,12 @@ static int omap_iommu_add_device(struct device *dev)
 		return -ENOMEM;
 	}
 
+	ret = iommu_device_link(&iommu->iommu, dev);
+	if (ret) {
+		of_node_put(np);
+		return ret;
+	}
+
 	arch_data->iommu_dev = iommu;
 	dev->archdata.iommu = arch_data;
 
@@ -1252,8 +1274,11 @@ static void omap_iommu_remove_device(struct device *dev)
 	if (!dev->of_node || !arch_data)
 		return;
 
+	iommu_device_unlink(&arch_data->iommu_dev->iommu, dev);
+
 	dev->archdata.iommu = NULL;
 	kfree(arch_data);
+
 }
 
 static const struct iommu_ops omap_iommu_ops = {
diff --git a/drivers/iommu/omap-iommu.h b/drivers/iommu/omap-iommu.h
index 05bd279..07e6ea1 100644
--- a/drivers/iommu/omap-iommu.h
+++ b/drivers/iommu/omap-iommu.h
@@ -67,6 +67,8 @@ struct omap_iommu {
 
 	int has_bus_err_back;
 	u32 id;
+
+	struct iommu_device iommu;
 };
 
 /**
-- 
1.9.1
