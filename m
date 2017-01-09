From: Eric Auger <eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH v7 07/19] iommu: iommu_get_group_resv_regions
Date: Mon,  9 Jan 2017 13:45:58 +0000
Message-ID: <1483969570-3154-8-git-send-email-eric.auger@redhat.com>
References: <1483969570-3154-1-git-send-email-eric.auger@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1483969570-3154-1-git-send-email-eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
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

Introduce iommu_get_group_resv_regions whose role consists in
enumerating all devices from the group and collecting their
reserved regions. The list is sorted and overlaps between
regions of the same type are handled by merging the regions.

Signed-off-by: Eric Auger <eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

---
v6 -> v7:
- avoid merge of regions of different type

v3 -> v4:
- take the iommu_group lock in iommu_get_group_resv_regions
- the list now is sorted and overlaps are checked

NOTE:
- we do not move list elements from device to group list since
  the iommu_put_resv_regions() could not be called.
- at the moment I did not introduce any iommu_put_group_resv_regions
  since it simply consists in voiding/freeing the list
---
 drivers/iommu/iommu.c | 98 +++++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/iommu.h |  8 +++++
 2 files changed, 106 insertions(+)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 41c1906..640056b 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -133,6 +133,104 @@ static ssize_t iommu_group_show_name(struct iommu_group *group, char *buf)
 	return sprintf(buf, "%s\n", group->name);
 }
 
+/**
+ * iommu_insert_resv_region - Insert a new region in the
+ * list of reserved regions.
+ * @new: new region to insert
+ * @regions: list of regions
+ *
+ * The new element is sorted by address with respect to the other
+ * regions of the same type. In case it overlaps with another
+ * region of the same type, regions are merged. In case it
+ * overlaps with another region of different type, regions are
+ * not merged.
+ */
+static int iommu_insert_resv_region(struct iommu_resv_region *new,
+				    struct list_head *regions)
+{
+	struct iommu_resv_region *region;
+	phys_addr_t start = new->start;
+	phys_addr_t end = new->start + new->length - 1;
+	struct list_head *pos = regions->next;
+
+	while (pos != regions) {
+		struct iommu_resv_region *entry =
+			list_entry(pos, struct iommu_resv_region, list);
+		phys_addr_t a = entry->start;
+		phys_addr_t b = entry->start + entry->length - 1;
+		int type = entry->type;
+
+		if (end < a) {
+			goto insert;
+		} else if (start > b) {
+			pos = pos->next;
+		} else if ((start >= a) && (end <= b)) {
+			if (new->type == type)
+				goto done;
+			else
+				pos = pos->next;
+		} else {
+			if (new->type == type) {
+				phys_addr_t new_start = min(a, start);
+				phys_addr_t new_end = max(b, end);
+
+				list_del(&entry->list);
+				entry->start = new_start;
+				entry->length = new_end - new_start + 1;
+				iommu_insert_resv_region(entry, regions);
+			} else {
+				pos = pos->next;
+			}
+		}
+	}
+insert:
+	region = iommu_alloc_resv_region(new->start, new->length,
+					 new->prot, new->type);
+	if (!region)
+		return -ENOMEM;
+
+	list_add_tail(&region->list, pos);
+done:
+	return 0;
+}
+
+static int
+iommu_insert_device_resv_regions(struct list_head *dev_resv_regions,
+				 struct list_head *group_resv_regions)
+{
+	struct iommu_resv_region *entry;
+	int ret;
+
+	list_for_each_entry(entry, dev_resv_regions, list) {
+		ret = iommu_insert_resv_region(entry, group_resv_regions);
+		if (ret)
+			break;
+	}
+	return ret;
+}
+
+int iommu_get_group_resv_regions(struct iommu_group *group,
+				 struct list_head *head)
+{
+	struct iommu_device *device;
+	int ret = 0;
+
+	mutex_lock(&group->mutex);
+	list_for_each_entry(device, &group->devices, list) {
+		struct list_head dev_resv_regions;
+
+		INIT_LIST_HEAD(&dev_resv_regions);
+		iommu_get_resv_regions(device->dev, &dev_resv_regions);
+		ret = iommu_insert_device_resv_regions(&dev_resv_regions, head);
+		iommu_put_resv_regions(device->dev, &dev_resv_regions);
+		if (ret)
+			break;
+	}
+	mutex_unlock(&group->mutex);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(iommu_get_group_resv_regions);
+
 static IOMMU_GROUP_ATTR(name, S_IRUGO, iommu_group_show_name, NULL);
 
 static void iommu_group_release(struct kobject *kobj)
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index f6bb55d3..bec3730 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -246,6 +246,8 @@ extern void iommu_set_fault_handler(struct iommu_domain *domain,
 extern int iommu_request_dm_for_dev(struct device *dev);
 extern struct iommu_resv_region *
 iommu_alloc_resv_region(phys_addr_t start, size_t length, int prot, int type);
+extern int iommu_get_group_resv_regions(struct iommu_group *group,
+					struct list_head *head);
 
 extern int iommu_attach_group(struct iommu_domain *domain,
 			      struct iommu_group *group);
@@ -463,6 +465,12 @@ static inline void iommu_put_resv_regions(struct device *dev,
 {
 }
 
+static inline int iommu_get_group_resv_regions(struct iommu_group *group,
+					       struct list_head *head)
+{
+	return -ENODEV;
+}
+
 static inline int iommu_request_dm_for_dev(struct device *dev)
 {
 	return -ENODEV;
-- 
1.9.1
