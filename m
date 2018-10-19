From: Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>
Subject: [RFC PATCH 1/6] iommu: Adapt attach/detach_dev() for auxiliary domains
Date: Fri, 19 Oct 2018 19:11:53 +0100
Message-ID: <20181019181158.2395-2-jean-philippe.brucker@arm.com>
References: <20181019181158.2395-1-jean-philippe.brucker@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20181019181158.2395-1-jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>
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
Cc: kevin.tian-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, rafael-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, christian.koenig-5C7GfCeVMHo@public.gmane.org, alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, robin.murphy-5wv7dgnIgG8@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

The same set of functions, iommu_attach/detach_device/group, is used
both to change a device's domain (let's call it "main domain") and to
add auxiliary domains. The former is used by vfio-pci for example, to
assign the whole device to userspace. The latter is used by vfio-mdev to
assign partitions of devices using PASIDs. Device drivers set or unset
the 'AUXD' device attribute to switch between these modes.

Supporting both auxiliary and main domain through the same callback
requires some core changes. For an IOMMU driver that supports both, the
new semantics of attach_dev() and detach_dev() ops are:

attach_dev(dev, new_domain)
 (1) When auxd is disabled, detach from the current domain and attach to
     the new domain.

 (2) When auxd is enabled, keep the current domain and attach to the new
     domain.

detach_dev(dev, new_domain)
 (3) When auxd is disabled, detach from the domain. Previously the core
     didn't call detach_dev explicitly when a device has a default domain,
     since case (1) already takes care of it. But in order to also handle
     case (4), we now need to always call detach_dev.

 (4) When auxd is enabled, detach from the given domain, but stay attached
     to the default domain.

attach_dev() now returns a value greater than 0 if the domain is in
auxiliary mode. This allows the core to know if the main domain
(group->domain) is affected. detach_dev() should probably do the same
(currently group->domain is always cleared on detach), but that requires
changing all IOMMU drivers.

Since the core doesn't know about auxiliary domains when attaching, we
have to relax attach_dev a bit: we can't check if the user is trying to
replace the main domain with a new unmanaged domain anymore.

IOMMU drivers that don't support auxiliary domains are also affected by
the change in (3). Those that support default_domain now get
detach_dev() followed by attach_dev() callback on iommu_detach_device(),
instead of just attach_dev().

Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>
---
 drivers/iommu/iommu.c | 58 ++++++++++++++++++++++++++++++-------------
 1 file changed, 41 insertions(+), 17 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index a8a144dded52..667ccfc6d3fd 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1553,7 +1553,7 @@ static int __iommu_attach_device(struct iommu_domain *domain,
 		return -ENODEV;
 
 	ret = domain->ops->attach_dev(domain, dev);
-	if (!ret)
+	if (ret >= 0)
 		trace_attach_device_to_domain(dev);
 	return ret;
 }
@@ -1726,6 +1726,12 @@ struct iommu_domain *iommu_get_domain_for_dev(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(iommu_get_domain_for_dev);
 
+struct iommu_attach_group_info {
+	struct iommu_domain *domain;
+	unsigned long count;
+	int ret;
+};
+
 /*
  * IOMMU groups are really the natrual working unit of the IOMMU, but
  * the IOMMU API works on domains and devices.  Bridge that gap by
@@ -1738,20 +1744,31 @@ EXPORT_SYMBOL_GPL(iommu_get_domain_for_dev);
  */
 static int iommu_group_do_attach_device(struct device *dev, void *data)
 {
-	struct iommu_domain *domain = data;
+	int ret;
+	struct iommu_attach_group_info *info = data;
 
-	return __iommu_attach_device(domain, dev);
+	ret = __iommu_attach_device(info->domain, dev);
+	if (ret < 0)
+		return ret;
+
+	/* Can't mix auxiliary and main domain within a group */
+	if (info->count++ && ret != info->ret)
+		/* TODO: rollback */
+		return -ENODEV;
+	info->ret = ret;
+
+	return 0;
 }
 
 static int __iommu_attach_group(struct iommu_domain *domain,
 				struct iommu_group *group)
 {
 	int ret;
+	struct iommu_attach_group_info info = {
+		.domain = domain,
+	};
 
-	if (group->default_domain && group->domain != group->default_domain)
-		return -EBUSY;
-
-	ret = __iommu_group_for_each_dev(group, domain,
+	ret = __iommu_group_for_each_dev(group, &info,
 					 iommu_group_do_attach_device);
 	if (ret == 0)
 		group->domain = domain;
@@ -1784,23 +1801,30 @@ static void __iommu_detach_group(struct iommu_domain *domain,
 				 struct iommu_group *group)
 {
 	int ret;
+	struct iommu_attach_group_info info = {
+		.domain = group->default_domain,
+	};
 
+	__iommu_group_for_each_dev(group, domain, iommu_group_do_detach_device);
 	if (!group->default_domain) {
-		__iommu_group_for_each_dev(group, domain,
-					   iommu_group_do_detach_device);
+		/*
+		 * If detach returned, then we're not removing the main domain
+		 * but an auxiliary one.
+		 *
+		 * FIXME: don't clear domain!
+		 */
 		group->domain = NULL;
 		return;
 	}
 
-	if (group->domain == group->default_domain)
-		return;
-
-	/* Detach by re-attaching to the default domain */
-	ret = __iommu_group_for_each_dev(group, group->default_domain,
+	/*
+	 * Detach by re-attaching to the default domain. If the device is
+	 * already attached, then @domain was in auxiliary mode and the driver
+	 * returns a value > 0.
+	 */
+	ret = __iommu_group_for_each_dev(group, &info,
 					 iommu_group_do_attach_device);
-	if (ret != 0)
-		WARN_ON(1);
-	else
+	if (ret == 0)
 		group->domain = group->default_domain;
 }
 
-- 
2.19.1
