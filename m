From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 08/22] iommu: Make sure a device is always attached to a domain
Date: Thu, 28 May 2015 18:41:31 +0200
Message-ID: <1432831305-11126-9-git-send-email-joro@8bytes.org>
References: <1432831305-11126-1-git-send-email-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1432831305-11126-1-git-send-email-joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
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
Cc: jroedel-l3A5Bk7waGM@public.gmane.org, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Kukjin Kim <kgene-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

From: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>

Make use of the default domain and re-attach a device to it
when it is detached from another domain. Also enforce that a
device has to be in the default domain before it can be
attached to a different domain.

Signed-off-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
---
 drivers/iommu/iommu.c | 83 ++++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 75 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index adeedd2..7bce522 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -52,6 +52,7 @@ struct iommu_group {
 	char *name;
 	int id;
 	struct iommu_domain *default_domain;
+	struct iommu_domain *domain;
 };
 
 struct iommu_device {
@@ -78,6 +79,12 @@ struct iommu_group_attribute iommu_group_attr_##_name =		\
 
 static struct iommu_domain *__iommu_domain_alloc(struct bus_type *bus,
 						 unsigned type);
+static int __iommu_attach_device(struct iommu_domain *domain,
+				 struct device *dev);
+static int __iommu_attach_group(struct iommu_domain *domain,
+				struct iommu_group *group);
+static void __iommu_detach_group(struct iommu_domain *domain,
+				 struct iommu_group *group);
 
 static ssize_t iommu_group_attr_show(struct kobject *kobj,
 				     struct attribute *__attr, char *buf)
@@ -376,6 +383,8 @@ rename:
 
 	mutex_lock(&group->mutex);
 	list_add_tail(&device->list, &group->devices);
+	if (group->domain)
+		__iommu_attach_device(group->domain, dev);
 	mutex_unlock(&group->mutex);
 
 	/* Notify any listeners about change to group. */
@@ -455,19 +464,30 @@ static int iommu_group_device_count(struct iommu_group *group)
  * The group->mutex is held across callbacks, which will block calls to
  * iommu_group_add/remove_device.
  */
-int iommu_group_for_each_dev(struct iommu_group *group, void *data,
-			     int (*fn)(struct device *, void *))
+static int __iommu_group_for_each_dev(struct iommu_group *group, void *data,
+				      int (*fn)(struct device *, void *))
 {
 	struct iommu_device *device;
 	int ret = 0;
 
-	mutex_lock(&group->mutex);
 	list_for_each_entry(device, &group->devices, list) {
 		ret = fn(device->dev, data);
 		if (ret)
 			break;
 	}
+	return ret;
+}
+
+
+int iommu_group_for_each_dev(struct iommu_group *group, void *data,
+			     int (*fn)(struct device *, void *))
+{
+	int ret;
+
+	mutex_lock(&group->mutex);
+	ret = __iommu_group_for_each_dev(group, data, fn);
 	mutex_unlock(&group->mutex);
+
 	return ret;
 }
 EXPORT_SYMBOL_GPL(iommu_group_for_each_dev);
@@ -1013,7 +1033,7 @@ int iommu_attach_device(struct iommu_domain *domain, struct device *dev)
 	if (iommu_group_device_count(group) != 1)
 		goto out_unlock;
 
-	ret = __iommu_attach_device(domain, dev);
+	ret = __iommu_attach_group(domain, group);
 
 out_unlock:
 	mutex_unlock(&group->mutex);
@@ -1048,7 +1068,7 @@ void iommu_detach_device(struct iommu_domain *domain, struct device *dev)
 		goto out_unlock;
 	}
 
-	__iommu_detach_device(domain, dev);
+	__iommu_detach_group(domain, group);
 
 out_unlock:
 	mutex_unlock(&group->mutex);
@@ -1073,10 +1093,31 @@ static int iommu_group_do_attach_device(struct device *dev, void *data)
 	return __iommu_attach_device(domain, dev);
 }
 
+static int __iommu_attach_group(struct iommu_domain *domain,
+				struct iommu_group *group)
+{
+	int ret;
+
+	if (group->default_domain && group->domain != group->default_domain)
+		return -EBUSY;
+
+	ret = __iommu_group_for_each_dev(group, domain,
+					 iommu_group_do_attach_device);
+	if (ret == 0)
+		group->domain = domain;
+
+	return ret;
+}
+
 int iommu_attach_group(struct iommu_domain *domain, struct iommu_group *group)
 {
-	return iommu_group_for_each_dev(group, domain,
-					iommu_group_do_attach_device);
+	int ret;
+
+	mutex_lock(&group->mutex);
+	ret = __iommu_attach_group(domain, group);
+	mutex_unlock(&group->mutex);
+
+	return ret;
 }
 EXPORT_SYMBOL_GPL(iommu_attach_group);
 
@@ -1089,9 +1130,35 @@ static int iommu_group_do_detach_device(struct device *dev, void *data)
 	return 0;
 }
 
+static void __iommu_detach_group(struct iommu_domain *domain,
+				 struct iommu_group *group)
+{
+	int ret;
+
+	if (!group->default_domain) {
+		__iommu_group_for_each_dev(group, domain,
+					   iommu_group_do_detach_device);
+		group->domain = NULL;
+		return;
+	}
+
+	if (group->domain == group->default_domain)
+		return;
+
+	/* Detach by re-attaching to the default domain */
+	ret = __iommu_group_for_each_dev(group, group->default_domain,
+					 iommu_group_do_attach_device);
+	if (ret != 0)
+		WARN_ON(1);
+	else
+		group->domain = group->default_domain;
+}
+
 void iommu_detach_group(struct iommu_domain *domain, struct iommu_group *group)
 {
-	iommu_group_for_each_dev(group, domain, iommu_group_do_detach_device);
+	mutex_lock(&group->mutex);
+	__iommu_detach_group(domain, group);
+	mutex_unlock(&group->mutex);
 }
 EXPORT_SYMBOL_GPL(iommu_detach_group);
 
-- 
1.9.1
