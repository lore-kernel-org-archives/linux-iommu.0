From: Eric Auger <eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [RFC v3 07/10] iommu: Implement reserved_regions iommu-group sysfs
	file
Date: Tue, 15 Nov 2016 13:09:20 +0000
Message-ID: <1479215363-2898-8-git-send-email-eric.auger@redhat.com>
References: <1479215363-2898-1-git-send-email-eric.auger@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1479215363-2898-1-git-send-email-eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, eric.auger.pro-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, christoffer.dall-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, marc.zyngier-5wv7dgnIgG8@public.gmane.org, robin.murphy-5wv7dgnIgG8@public.gmane.org, alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: drjones-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, punit.agrawal-5wv7dgnIgG8@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, pranav.sawargaonkar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

A new iommu-group sysfs attribute file is introduced. It contains
the list of reserved regions for the iommu-group. Each reserved
region is described on a separate line:
- first field is the start IOVA address,
- second is the end IOVA address,

Signed-off-by: Eric Auger <eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

---

The file layout is inspired of /sys/bus/pci/devices/BDF/resource.
I also read Documentation/filesystems/sysfs.txt so I expect this
to be frowned upon.
---
 drivers/iommu/iommu.c | 47 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index e0fbcc5..ce9a465 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -32,6 +32,7 @@
 #include <linux/pci.h>
 #include <linux/bitops.h>
 #include <linux/property.h>
+#include <linux/list_sort.h>
 #include <trace/events/iommu.h>
 
 static struct kset *iommu_group_kset;
@@ -186,8 +187,47 @@ int iommu_get_group_resv_regions(struct iommu_group *group,
 }
 EXPORT_SYMBOL_GPL(iommu_get_group_resv_regions);
 
+static int iommu_resv_region_cmp(void *priv, struct list_head *a,
+			       struct list_head *b)
+{
+	struct iommu_resv_region *rega, *regb;
+
+	rega = container_of(a, struct iommu_resv_region, list);
+	regb = container_of(b, struct iommu_resv_region, list);
+
+	if (rega->start + rega->length - 1 < regb->start)
+		return -1;
+	if (regb->start + regb->length - 1 < rega->start)
+		return 1;
+	else
+		return 0;
+}
+
+static ssize_t iommu_group_show_resv_regions(struct iommu_group *group,
+					     char *buf)
+{
+	struct iommu_resv_region *region, *next;
+	struct list_head group_resv_regions;
+	char *str = buf;
+
+	INIT_LIST_HEAD(&group_resv_regions);
+	iommu_get_group_resv_regions(group, &group_resv_regions);
+	list_sort(NULL, &group_resv_regions, iommu_resv_region_cmp);
+
+	list_for_each_entry_safe(region, next, &group_resv_regions, list) {
+		str += sprintf(str, "0x%016llx 0x%016llx\n", region->start,
+			       region->start + region->length - 1);
+		kfree(region);
+	}
+
+	return (str - buf);
+}
+
 static IOMMU_GROUP_ATTR(name, S_IRUGO, iommu_group_show_name, NULL);
 
+static IOMMU_GROUP_ATTR(reserved_regions, S_IRUGO,
+			iommu_group_show_resv_regions, NULL);
+
 static void iommu_group_release(struct kobject *kobj)
 {
 	struct iommu_group *group = to_iommu_group(kobj);
@@ -202,6 +242,8 @@ static void iommu_group_release(struct kobject *kobj)
 	if (group->default_domain)
 		iommu_domain_free(group->default_domain);
 
+	iommu_group_remove_file(group, &iommu_group_attr_reserved_regions);
+
 	kfree(group->name);
 	kfree(group);
 }
@@ -265,6 +307,11 @@ struct iommu_group *iommu_group_alloc(void)
 	 */
 	kobject_put(&group->kobj);
 
+	ret = iommu_group_create_file(group,
+				      &iommu_group_attr_reserved_regions);
+	if (ret)
+		return ERR_PTR(ret);
+
 	pr_debug("Allocated group %d\n", group->id);
 
 	return group;
-- 
1.9.1
