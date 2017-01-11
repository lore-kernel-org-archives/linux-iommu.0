From: Eric Auger <eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH v8 07/18] iommu: Implement reserved_regions iommu-group sysfs
	file
Date: Wed, 11 Jan 2017 09:41:43 +0000
Message-ID: <1484127714-3263-8-git-send-email-eric.auger@redhat.com>
References: <1484127714-3263-1-git-send-email-eric.auger@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1484127714-3263-1-git-send-email-eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
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
Cc: drjones-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, punit.agrawal-5wv7dgnIgG8@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, geethasowjanya.akula-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, pranav.sawargaonkar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, shankerd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, gpkulkarni-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

A new iommu-group sysfs attribute file is introduced. It contains
the list of reserved regions for the iommu-group. Each reserved
region is described on a separate line:
- first field is the start IOVA address,
- second is the end IOVA address,
- third is the type.

Signed-off-by: Eric Auger <eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

---
v7 -> v8:
- remove iommu_group_remove_file() in iommu_group_release since
  the /sys/kernel/iommu_groups/n directory seems to be removed
  already

v6 -> v7:
- also report the type of the reserved region as a string
- updated ABI documentation

v3 -> v4:
- add cast to long long int when printing to avoid warning on
  i386
- change S_IRUGO into 0444
- remove sort. The list is natively sorted now.

The file layout is inspired of /sys/bus/pci/devices/BDF/resource.
I also read Documentation/filesystems/sysfs.txt so I expect this
to be frowned upon.
---
 .../ABI/testing/sysfs-kernel-iommu_groups          | 12 ++++++++
 drivers/iommu/iommu.c                              | 36 ++++++++++++++++++++++
 2 files changed, 48 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-kernel-iommu_groups b/Documentation/ABI/testing/sysfs-kernel-iommu_groups
index 9b31556..35c64e0 100644
--- a/Documentation/ABI/testing/sysfs-kernel-iommu_groups
+++ b/Documentation/ABI/testing/sysfs-kernel-iommu_groups
@@ -12,3 +12,15 @@ Description:	/sys/kernel/iommu_groups/ contains a number of sub-
 		file if the IOMMU driver has chosen to register a more
 		common name for the group.
 Users:
+
+What:		/sys/kernel/iommu_groups/reserved_regions
+Date: 		January 2017
+KernelVersion:  v4.11
+Contact: 	Eric Auger <eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
+Description:    /sys/kernel/iommu_groups/reserved_regions list IOVA
+		regions that are reserved. Not necessarily all
+		reserved regions are listed. This is typically used to
+		output direct-mapped, MSI, non mappable regions. Each
+		region is described on a single line: the 1st field is
+		the base IOVA, the second is the end IOVA and the third
+		field describes the type of the region.
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 640056b..f4a176e 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -68,6 +68,12 @@ struct iommu_group_attribute {
 			 const char *buf, size_t count);
 };
 
+static const char * const iommu_group_resv_type_string[] = {
+	[IOMMU_RESV_DIRECT]	= "direct",
+	[IOMMU_RESV_RESERVED]	= "reserved",
+	[IOMMU_RESV_MSI]	= "msi",
+};
+
 #define IOMMU_GROUP_ATTR(_name, _mode, _show, _store)		\
 struct iommu_group_attribute iommu_group_attr_##_name =		\
 	__ATTR(_name, _mode, _show, _store)
@@ -231,8 +237,33 @@ int iommu_get_group_resv_regions(struct iommu_group *group,
 }
 EXPORT_SYMBOL_GPL(iommu_get_group_resv_regions);
 
+static ssize_t iommu_group_show_resv_regions(struct iommu_group *group,
+					     char *buf)
+{
+	struct iommu_resv_region *region, *next;
+	struct list_head group_resv_regions;
+	char *str = buf;
+
+	INIT_LIST_HEAD(&group_resv_regions);
+	iommu_get_group_resv_regions(group, &group_resv_regions);
+
+	list_for_each_entry_safe(region, next, &group_resv_regions, list) {
+		str += sprintf(str, "0x%016llx 0x%016llx %s\n",
+			       (long long int)region->start,
+			       (long long int)(region->start +
+						region->length - 1),
+			       iommu_group_resv_type_string[region->type]);
+		kfree(region);
+	}
+
+	return (str - buf);
+}
+
 static IOMMU_GROUP_ATTR(name, S_IRUGO, iommu_group_show_name, NULL);
 
+static IOMMU_GROUP_ATTR(reserved_regions, 0444,
+			iommu_group_show_resv_regions, NULL);
+
 static void iommu_group_release(struct kobject *kobj)
 {
 	struct iommu_group *group = to_iommu_group(kobj);
@@ -310,6 +341,11 @@ struct iommu_group *iommu_group_alloc(void)
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
