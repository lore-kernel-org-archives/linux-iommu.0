From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 05/10] iommu: Make iommu_device_link/unlink take a struct
	iommu_device
Date: Fri,  3 Feb 2017 16:17:43 +0100
Message-ID: <1486135068-23994-6-git-send-email-joro@8bytes.org>
References: <1486135068-23994-1-git-send-email-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1486135068-23994-1-git-send-email-joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
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
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

From: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>

This makes the interface more consistent with
iommu_device_sysfs_add/remove.

Signed-off-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
---
 drivers/iommu/amd_iommu.c   |  4 ++--
 drivers/iommu/intel-iommu.c |  4 ++--
 drivers/iommu/iommu-sysfs.c | 16 ++++++++--------
 include/linux/iommu.h       |  4 ++--
 4 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index a584ac2..b8adfcc 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -472,7 +472,7 @@ static int iommu_init_device(struct device *dev)
 
 	dev->archdata.iommu = dev_data;
 
-	iommu_device_link(&iommu->iommu.dev, dev);
+	iommu_device_link(&iommu->iommu, dev);
 
 	return 0;
 }
@@ -514,7 +514,7 @@ static void iommu_uninit_device(struct device *dev)
 	if (dev_data->domain)
 		detach_device(dev);
 
-	iommu_device_unlink(&iommu->iommu.dev, dev);
+	iommu_device_unlink(&iommu->iommu, dev);
 
 	iommu_group_remove_device(dev);
 
diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 3084837..364c54e 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -5181,7 +5181,7 @@ static int intel_iommu_add_device(struct device *dev)
 	if (!iommu)
 		return -ENODEV;
 
-	iommu_device_link(&iommu->iommu.dev, dev);
+	iommu_device_link(&iommu->iommu, dev);
 
 	group = iommu_group_get_for_dev(dev);
 
@@ -5203,7 +5203,7 @@ static void intel_iommu_remove_device(struct device *dev)
 
 	iommu_group_remove_device(dev);
 
-	iommu_device_unlink(&iommu->iommu.dev, dev);
+	iommu_device_unlink(&iommu->iommu, dev);
 }
 
 #ifdef CONFIG_INTEL_IOMMU_SVM
diff --git a/drivers/iommu/iommu-sysfs.c b/drivers/iommu/iommu-sysfs.c
index bb87d35..c58351e 100644
--- a/drivers/iommu/iommu-sysfs.c
+++ b/drivers/iommu/iommu-sysfs.c
@@ -95,31 +95,31 @@ void iommu_device_sysfs_remove(struct iommu_device *iommu)
  * directory of the IOMMU device in sysfs and an "iommu" link will be
  * created under the linked device, pointing back at the IOMMU device.
  */
-int iommu_device_link(struct device *dev, struct device *link)
+int iommu_device_link(struct iommu_device *iommu, struct device *link)
 {
 	int ret;
 
-	if (!dev || IS_ERR(dev))
+	if (!iommu || IS_ERR(iommu))
 		return -ENODEV;
 
-	ret = sysfs_add_link_to_group(&dev->kobj, "devices",
+	ret = sysfs_add_link_to_group(&iommu->dev.kobj, "devices",
 				      &link->kobj, dev_name(link));
 	if (ret)
 		return ret;
 
-	ret = sysfs_create_link_nowarn(&link->kobj, &dev->kobj, "iommu");
+	ret = sysfs_create_link_nowarn(&link->kobj, &iommu->dev.kobj, "iommu");
 	if (ret)
-		sysfs_remove_link_from_group(&dev->kobj, "devices",
+		sysfs_remove_link_from_group(&iommu->dev.kobj, "devices",
 					     dev_name(link));
 
 	return ret;
 }
 
-void iommu_device_unlink(struct device *dev, struct device *link)
+void iommu_device_unlink(struct iommu_device *iommu, struct device *link)
 {
-	if (!dev || IS_ERR(dev))
+	if (!iommu || IS_ERR(iommu))
 		return;
 
 	sysfs_remove_link(&link->kobj, "iommu");
-	sysfs_remove_link_from_group(&dev->kobj, "devices", dev_name(link));
+	sysfs_remove_link_from_group(&iommu->dev.kobj, "devices", dev_name(link));
 }
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 1b5fbbc..e53452f 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -224,6 +224,8 @@ int  iommu_device_sysfs_add(struct iommu_device *iommu,
 			    const struct attribute_group **groups,
 			    const char *fmt, ...) __printf(4, 5);
 void iommu_device_sysfs_remove(struct iommu_device *iommu);
+int  iommu_device_link(struct iommu_device   *iommu, struct device *link);
+void iommu_device_unlink(struct iommu_device *iommu, struct device *link);
 
 #define IOMMU_GROUP_NOTIFY_ADD_DEVICE		1 /* Device added */
 #define IOMMU_GROUP_NOTIFY_DEL_DEVICE		2 /* Pre Device removed */
@@ -288,8 +290,6 @@ extern int iommu_domain_get_attr(struct iommu_domain *domain, enum iommu_attr,
 				 void *data);
 extern int iommu_domain_set_attr(struct iommu_domain *domain, enum iommu_attr,
 				 void *data);
-int iommu_device_link(struct device *dev, struct device *link);
-void iommu_device_unlink(struct device *dev, struct device *link);
 
 /* Window handling function prototypes */
 extern int iommu_domain_window_enable(struct iommu_domain *domain, u32 wnd_nr,
-- 
1.9.1
