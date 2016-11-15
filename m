From: Eric Auger <eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [RFC v3 10/10] vfio/type1: Get MSI cookie
Date: Tue, 15 Nov 2016 13:09:23 +0000
Message-ID: <1479215363-2898-11-git-send-email-eric.auger@redhat.com>
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

When attaching a group to the container, handle the group's
reserved regions and particularly the IOMMU_RESV_MSI region
which requires an IOVA allocator to be initialized through
the iommu_get_msi_cookie API. This will allow the MSI IOVAs
to be transparently allocated on MSI controller's compose().

Signed-off-by: Eric Auger <eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
 drivers/vfio/vfio_iommu_type1.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
index 2ba1942..701d8a8 100644
--- a/drivers/vfio/vfio_iommu_type1.c
+++ b/drivers/vfio/vfio_iommu_type1.c
@@ -36,6 +36,7 @@
 #include <linux/uaccess.h>
 #include <linux/vfio.h>
 #include <linux/workqueue.h>
+#include <linux/dma-iommu.h>
 
 #define DRIVER_VERSION  "0.2"
 #define DRIVER_AUTHOR   "Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>"
@@ -734,6 +735,27 @@ static void vfio_test_domain_fgsp(struct vfio_domain *domain)
 	__free_pages(pages, order);
 }
 
+static int vfio_iommu_handle_resv_regions(struct iommu_domain *domain,
+					  struct iommu_group *group)
+{
+	struct list_head group_resv_regions;
+	struct iommu_resv_region *region, *next;
+	int ret = 0;
+
+	INIT_LIST_HEAD(&group_resv_regions);
+	iommu_get_group_resv_regions(group, &group_resv_regions);
+	list_for_each_entry(region, &group_resv_regions, list) {
+		if (region->prot & IOMMU_RESV_MSI) {
+			ret = iommu_get_msi_cookie(domain, region->start);
+			if (ret)
+				break;
+		}
+	}
+	list_for_each_entry_safe(region, next, &group_resv_regions, list)
+		kfree(region);
+	return ret;
+}
+
 static int vfio_iommu_type1_attach_group(void *iommu_data,
 					 struct iommu_group *iommu_group)
 {
@@ -834,6 +856,10 @@ static int vfio_iommu_type1_attach_group(void *iommu_data,
 	if (ret)
 		goto out_detach;
 
+	ret = vfio_iommu_handle_resv_regions(domain->domain, iommu_group);
+	if (ret)
+		goto out_detach;
+
 	list_add(&domain->next, &iommu->domain_list);
 
 	mutex_unlock(&iommu->lock);
-- 
1.9.1
