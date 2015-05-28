From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 07/22] iommu: Limit iommu_attach/detach_device to devices with
	their own group
Date: Thu, 28 May 2015 18:41:30 +0200
Message-ID: <1432831305-11126-8-git-send-email-joro@8bytes.org>
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

This patch changes the behavior of the iommu_attach_device
and iommu_detach_device functions. With this change these
functions only work on devices that have their own group.
For all other devices the iommu_group_attach/detach
functions must be used.

Signed-off-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
---
 drivers/iommu/iommu.c | 71 ++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 67 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index fbfc015..adeedd2 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -433,6 +433,17 @@ void iommu_group_remove_device(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(iommu_group_remove_device);
 
+static int iommu_group_device_count(struct iommu_group *group)
+{
+	struct iommu_device *entry;
+	int ret = 0;
+
+	list_for_each_entry(entry, &group->devices, list)
+		ret++;
+
+	return ret;
+}
+
 /**
  * iommu_group_for_each_dev - iterate over each device in the group
  * @group: the group
@@ -970,7 +981,8 @@ void iommu_domain_free(struct iommu_domain *domain)
 }
 EXPORT_SYMBOL_GPL(iommu_domain_free);
 
-int iommu_attach_device(struct iommu_domain *domain, struct device *dev)
+static int __iommu_attach_device(struct iommu_domain *domain,
+				 struct device *dev)
 {
 	int ret;
 	if (unlikely(domain->ops->attach_dev == NULL))
@@ -981,9 +993,38 @@ int iommu_attach_device(struct iommu_domain *domain, struct device *dev)
 		trace_attach_device_to_domain(dev);
 	return ret;
 }
+
+int iommu_attach_device(struct iommu_domain *domain, struct device *dev)
+{
+	struct iommu_group *group;
+	int ret;
+
+	group = iommu_group_get(dev);
+	/* FIXME: Remove this when groups a mandatory for iommu drivers */
+	if (group == NULL)
+		return __iommu_attach_device(domain, dev);
+
+	/*
+	 * We have a group - lock it to make sure the device-count doesn't
+	 * change while we are attaching
+	 */
+	mutex_lock(&group->mutex);
+	ret = -EINVAL;
+	if (iommu_group_device_count(group) != 1)
+		goto out_unlock;
+
+	ret = __iommu_attach_device(domain, dev);
+
+out_unlock:
+	mutex_unlock(&group->mutex);
+	iommu_group_put(group);
+
+	return ret;
+}
 EXPORT_SYMBOL_GPL(iommu_attach_device);
 
-void iommu_detach_device(struct iommu_domain *domain, struct device *dev)
+static void __iommu_detach_device(struct iommu_domain *domain,
+				  struct device *dev)
 {
 	if (unlikely(domain->ops->detach_dev == NULL))
 		return;
@@ -991,6 +1032,28 @@ void iommu_detach_device(struct iommu_domain *domain, struct device *dev)
 	domain->ops->detach_dev(domain, dev);
 	trace_detach_device_from_domain(dev);
 }
+
+void iommu_detach_device(struct iommu_domain *domain, struct device *dev)
+{
+	struct iommu_group *group;
+
+	group = iommu_group_get(dev);
+	/* FIXME: Remove this when groups a mandatory for iommu drivers */
+	if (group == NULL)
+		return __iommu_detach_device(domain, dev);
+
+	mutex_lock(&group->mutex);
+	if (iommu_group_device_count(group) != 1) {
+		WARN_ON(1);
+		goto out_unlock;
+	}
+
+	__iommu_detach_device(domain, dev);
+
+out_unlock:
+	mutex_unlock(&group->mutex);
+	iommu_group_put(group);
+}
 EXPORT_SYMBOL_GPL(iommu_detach_device);
 
 /*
@@ -1007,7 +1070,7 @@ static int iommu_group_do_attach_device(struct device *dev, void *data)
 {
 	struct iommu_domain *domain = data;
 
-	return iommu_attach_device(domain, dev);
+	return __iommu_attach_device(domain, dev);
 }
 
 int iommu_attach_group(struct iommu_domain *domain, struct iommu_group *group)
@@ -1021,7 +1084,7 @@ static int iommu_group_do_detach_device(struct device *dev, void *data)
 {
 	struct iommu_domain *domain = data;
 
-	iommu_detach_device(domain, dev);
+	__iommu_detach_device(domain, dev);
 
 	return 0;
 }
-- 
1.9.1
