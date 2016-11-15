From: Eric Auger <eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [RFC v3 06/10] iommu: iommu_get_group_resv_regions
Date: Tue, 15 Nov 2016 13:09:19 +0000
Message-ID: <1479215363-2898-7-git-send-email-eric.auger@redhat.com>
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

Introduce iommu_get_group_resv_regions whose role consists in
enumerating all devices from the group and collecting their
reserved regions. It checks duplicates.

Signed-off-by: Eric Auger <eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

---

- we do not move list elements from device to group list since
  the iommu_put_resv_regions() could not be called.
- at the moment I did not introduce any iommu_put_group_resv_regions
  since it simply consists in voiding/freeing the list
---
 drivers/iommu/iommu.c | 53 +++++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/iommu.h |  8 ++++++++
 2 files changed, 61 insertions(+)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index a4530ad..e0fbcc5 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -133,6 +133,59 @@ static ssize_t iommu_group_show_name(struct iommu_group *group, char *buf)
 	return sprintf(buf, "%s\n", group->name);
 }
 
+static bool iommu_resv_region_present(struct iommu_resv_region *region,
+				      struct list_head *head)
+{
+	struct iommu_resv_region *entry;
+
+	list_for_each_entry(entry, head, list) {
+		if ((region->start == entry->start) &&
+		    (region->length == entry->length) &&
+		    (region->prot == entry->prot))
+			return true;
+	}
+	return false;
+}
+
+static int
+iommu_insert_device_resv_regions(struct list_head *dev_resv_regions,
+				 struct list_head *group_resv_regions)
+{
+	struct iommu_resv_region *entry, *region;
+
+	list_for_each_entry(entry, dev_resv_regions, list) {
+		if (iommu_resv_region_present(entry, group_resv_regions))
+			continue;
+		region = iommu_alloc_resv_region(entry->start, entry->length,
+					       entry->prot);
+		if (!region)
+			return -ENOMEM;
+
+		list_add_tail(&region->list, group_resv_regions);
+	}
+	return 0;
+}
+
+int iommu_get_group_resv_regions(struct iommu_group *group,
+				 struct list_head *head)
+{
+	struct iommu_device *device;
+	int ret = 0;
+
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
+	return ret;
+}
+EXPORT_SYMBOL_GPL(iommu_get_group_resv_regions);
+
 static IOMMU_GROUP_ATTR(name, S_IRUGO, iommu_group_show_name, NULL);
 
 static void iommu_group_release(struct kobject *kobj)
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 0aea877..0f7ae2c 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -243,6 +243,8 @@ extern void iommu_set_fault_handler(struct iommu_domain *domain,
 extern int iommu_request_dm_for_dev(struct device *dev);
 extern struct iommu_resv_region *
 iommu_alloc_resv_region(phys_addr_t start, size_t length, unsigned int prot);
+extern int iommu_get_group_resv_regions(struct iommu_group *group,
+					struct list_head *head);
 
 extern int iommu_attach_group(struct iommu_domain *domain,
 			      struct iommu_group *group);
@@ -462,6 +464,12 @@ static inline void iommu_put_resv_regions(struct device *dev,
 	return NULL;
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
