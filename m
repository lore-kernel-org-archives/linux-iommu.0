From: Eric Auger <eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH v5 09/17] iommu/amd: Declare MSI and HT regions as reserved
	IOVA regions
Date: Wed,  4 Jan 2017 13:32:18 +0000
Message-ID: <1483536746-2725-10-git-send-email-eric.auger@redhat.com>
References: <1483536746-2725-1-git-send-email-eric.auger@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1483536746-2725-1-git-send-email-eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
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

This patch registers the MSI and HT regions as non mappable
reserved regions. They will be exposed in the iommu-group sysfs.

For direct-mapped regions let's also use iommu_alloc_resv_region().

Signed-off-by: Eric Auger <eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

---

v5: creation
---
 drivers/iommu/amd_iommu.c | 37 ++++++++++++++++++++++++++-----------
 1 file changed, 26 insertions(+), 11 deletions(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index c6c3f1e..24c752d 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -3164,6 +3164,7 @@ static bool amd_iommu_capable(enum iommu_cap cap)
 static void amd_iommu_get_resv_regions(struct device *dev,
 				       struct list_head *head)
 {
+	struct iommu_resv_region *region;
 	struct unity_map_entry *entry;
 	int devid;
 
@@ -3172,28 +3173,42 @@ static void amd_iommu_get_resv_regions(struct device *dev,
 		return;
 
 	list_for_each_entry(entry, &amd_iommu_unity_map, list) {
-		struct iommu_resv_region *region;
+		size_t length;
+		int prot = 0;
 
 		if (devid < entry->devid_start || devid > entry->devid_end)
 			continue;
 
-		region = kzalloc(sizeof(*region), GFP_KERNEL);
+		length = entry->address_end - entry->address_start;
+		if (entry->prot & IOMMU_PROT_IR)
+			prot |= IOMMU_READ;
+		if (entry->prot & IOMMU_PROT_IW)
+			prot |= IOMMU_WRITE;
+
+		region = iommu_alloc_resv_region(entry->address_start,
+						 length, prot,
+						 IOMMU_RESV_DIRECT);
 		if (!region) {
 			pr_err("Out of memory allocating dm-regions for %s\n",
 				dev_name(dev));
 			return;
 		}
-
-		region->start = entry->address_start;
-		region->length = entry->address_end - entry->address_start;
-		region->type = IOMMU_RESV_DIRECT;
-		if (entry->prot & IOMMU_PROT_IR)
-			region->prot |= IOMMU_READ;
-		if (entry->prot & IOMMU_PROT_IW)
-			region->prot |= IOMMU_WRITE;
-
 		list_add_tail(&region->list, head);
 	}
+
+	region = iommu_alloc_resv_region(MSI_RANGE_START,
+					 MSI_RANGE_END - MSI_RANGE_START + 1,
+					 0, IOMMU_RESV_NOMAP);
+	if (!region)
+		return;
+	list_add_tail(&region->list, head);
+
+	region = iommu_alloc_resv_region(HT_RANGE_START,
+					 HT_RANGE_END - HT_RANGE_START + 1,
+					 0, IOMMU_RESV_NOMAP);
+	if (!region)
+		return;
+	list_add_tail(&region->list, head);
 }
 
 static void amd_iommu_put_resv_regions(struct device *dev,
-- 
1.9.1
