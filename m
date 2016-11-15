From: Eric Auger <eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [RFC v3 02/10] iommu: Rename iommu_dm_regions into iommu_resv_regions
Date: Tue, 15 Nov 2016 13:09:15 +0000
Message-ID: <1479215363-2898-3-git-send-email-eric.auger@redhat.com>
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

We want to extend the callbacks used for dm regions and
use them for reserved regions. Reserved regions can be
- directly mapped regions
- regions that cannot be iommu mapped (PCI host bridge windows, ...)
- MSI regions (because they belong to another address space or because
  they are not translated by the IOMMU and need special handling)

So let's rename the struct and also the callbacks.

Signed-off-by: Eric Auger <eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
 drivers/iommu/amd_iommu.c | 20 ++++++++++----------
 drivers/iommu/iommu.c     | 22 +++++++++++-----------
 include/linux/iommu.h     | 29 +++++++++++++++--------------
 3 files changed, 36 insertions(+), 35 deletions(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 754595e..a6c351d 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -3159,8 +3159,8 @@ static bool amd_iommu_capable(enum iommu_cap cap)
 	return false;
 }
 
-static void amd_iommu_get_dm_regions(struct device *dev,
-				     struct list_head *head)
+static void amd_iommu_get_resv_regions(struct device *dev,
+				       struct list_head *head)
 {
 	struct unity_map_entry *entry;
 	int devid;
@@ -3170,7 +3170,7 @@ static void amd_iommu_get_dm_regions(struct device *dev,
 		return;
 
 	list_for_each_entry(entry, &amd_iommu_unity_map, list) {
-		struct iommu_dm_region *region;
+		struct iommu_resv_region *region;
 
 		if (devid < entry->devid_start || devid > entry->devid_end)
 			continue;
@@ -3193,18 +3193,18 @@ static void amd_iommu_get_dm_regions(struct device *dev,
 	}
 }
 
-static void amd_iommu_put_dm_regions(struct device *dev,
+static void amd_iommu_put_resv_regions(struct device *dev,
 				     struct list_head *head)
 {
-	struct iommu_dm_region *entry, *next;
+	struct iommu_resv_region *entry, *next;
 
 	list_for_each_entry_safe(entry, next, head, list)
 		kfree(entry);
 }
 
-static void amd_iommu_apply_dm_region(struct device *dev,
+static void amd_iommu_apply_resv_region(struct device *dev,
 				      struct iommu_domain *domain,
-				      struct iommu_dm_region *region)
+				      struct iommu_resv_region *region)
 {
 	struct dma_ops_domain *dma_dom = to_dma_ops_domain(to_pdomain(domain));
 	unsigned long start, end;
@@ -3228,9 +3228,9 @@ static void amd_iommu_apply_dm_region(struct device *dev,
 	.add_device = amd_iommu_add_device,
 	.remove_device = amd_iommu_remove_device,
 	.device_group = amd_iommu_device_group,
-	.get_dm_regions = amd_iommu_get_dm_regions,
-	.put_dm_regions = amd_iommu_put_dm_regions,
-	.apply_dm_region = amd_iommu_apply_dm_region,
+	.get_resv_regions = amd_iommu_get_resv_regions,
+	.put_resv_regions = amd_iommu_put_resv_regions,
+	.apply_resv_region = amd_iommu_apply_resv_region,
 	.pgsize_bitmap	= AMD_IOMMU_PGSIZES,
 };
 
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 9a2f196..c7ed334 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -318,7 +318,7 @@ static int iommu_group_create_direct_mappings(struct iommu_group *group,
 					      struct device *dev)
 {
 	struct iommu_domain *domain = group->default_domain;
-	struct iommu_dm_region *entry;
+	struct iommu_resv_region *entry;
 	struct list_head mappings;
 	unsigned long pg_size;
 	int ret = 0;
@@ -331,14 +331,14 @@ static int iommu_group_create_direct_mappings(struct iommu_group *group,
 	pg_size = 1UL << __ffs(domain->pgsize_bitmap);
 	INIT_LIST_HEAD(&mappings);
 
-	iommu_get_dm_regions(dev, &mappings);
+	iommu_get_resv_regions(dev, &mappings);
 
 	/* We need to consider overlapping regions for different devices */
 	list_for_each_entry(entry, &mappings, list) {
 		dma_addr_t start, end, addr;
 
-		if (domain->ops->apply_dm_region)
-			domain->ops->apply_dm_region(dev, domain, entry);
+		if (domain->ops->apply_resv_region)
+			domain->ops->apply_resv_region(dev, domain, entry);
 
 		start = ALIGN(entry->start, pg_size);
 		end   = ALIGN(entry->start + entry->length, pg_size);
@@ -358,7 +358,7 @@ static int iommu_group_create_direct_mappings(struct iommu_group *group,
 	}
 
 out:
-	iommu_put_dm_regions(dev, &mappings);
+	iommu_put_resv_regions(dev, &mappings);
 
 	return ret;
 }
@@ -1546,20 +1546,20 @@ int iommu_domain_set_attr(struct iommu_domain *domain,
 }
 EXPORT_SYMBOL_GPL(iommu_domain_set_attr);
 
-void iommu_get_dm_regions(struct device *dev, struct list_head *list)
+void iommu_get_resv_regions(struct device *dev, struct list_head *list)
 {
 	const struct iommu_ops *ops = dev->bus->iommu_ops;
 
-	if (ops && ops->get_dm_regions)
-		ops->get_dm_regions(dev, list);
+	if (ops && ops->get_resv_regions)
+		ops->get_resv_regions(dev, list);
 }
 
-void iommu_put_dm_regions(struct device *dev, struct list_head *list)
+void iommu_put_resv_regions(struct device *dev, struct list_head *list)
 {
 	const struct iommu_ops *ops = dev->bus->iommu_ops;
 
-	if (ops && ops->put_dm_regions)
-		ops->put_dm_regions(dev, list);
+	if (ops && ops->put_resv_regions)
+		ops->put_resv_regions(dev, list);
 }
 
 /* Request that a device is direct mapped by the IOMMU */
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 436dc21..7f6ebd0 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -118,13 +118,13 @@ enum iommu_attr {
 };
 
 /**
- * struct iommu_dm_region - descriptor for a direct mapped memory region
+ * struct iommu_resv_region - descriptor for a reserved memory region
  * @list: Linked list pointers
  * @start: System physical start address of the region
  * @length: Length of the region in bytes
  * @prot: IOMMU Protection flags (READ/WRITE/...)
  */
-struct iommu_dm_region {
+struct iommu_resv_region {
 	struct list_head	list;
 	phys_addr_t		start;
 	size_t			length;
@@ -150,9 +150,9 @@ struct iommu_dm_region {
  * @device_group: find iommu group for a particular device
  * @domain_get_attr: Query domain attributes
  * @domain_set_attr: Change domain attributes
- * @get_dm_regions: Request list of direct mapping requirements for a device
- * @put_dm_regions: Free list of direct mapping requirements for a device
- * @apply_dm_region: Temporary helper call-back for iova reserved ranges
+ * @get_resv_regions: Request list of reserved regions for a device
+ * @put_resv_regions: Free list of reserved regions for a device
+ * @apply_resv_region: Temporary helper call-back for iova reserved ranges
  * @domain_window_enable: Configure and enable a particular window for a domain
  * @domain_window_disable: Disable a particular window for a domain
  * @domain_set_windows: Set the number of windows for a domain
@@ -184,11 +184,12 @@ struct iommu_ops {
 	int (*domain_set_attr)(struct iommu_domain *domain,
 			       enum iommu_attr attr, void *data);
 
-	/* Request/Free a list of direct mapping requirements for a device */
-	void (*get_dm_regions)(struct device *dev, struct list_head *list);
-	void (*put_dm_regions)(struct device *dev, struct list_head *list);
-	void (*apply_dm_region)(struct device *dev, struct iommu_domain *domain,
-				struct iommu_dm_region *region);
+	/* Request/Free a list of reserved regions for a device */
+	void (*get_resv_regions)(struct device *dev, struct list_head *list);
+	void (*put_resv_regions)(struct device *dev, struct list_head *list);
+	void (*apply_resv_region)(struct device *dev,
+				  struct iommu_domain *domain,
+				  struct iommu_resv_region *region);
 
 	/* Window handling functions */
 	int (*domain_window_enable)(struct iommu_domain *domain, u32 wnd_nr,
@@ -233,8 +234,8 @@ extern size_t default_iommu_map_sg(struct iommu_domain *domain, unsigned long io
 extern void iommu_set_fault_handler(struct iommu_domain *domain,
 			iommu_fault_handler_t handler, void *token);
 
-extern void iommu_get_dm_regions(struct device *dev, struct list_head *list);
-extern void iommu_put_dm_regions(struct device *dev, struct list_head *list);
+extern void iommu_get_resv_regions(struct device *dev, struct list_head *list);
+extern void iommu_put_resv_regions(struct device *dev, struct list_head *list);
 extern int iommu_request_dm_for_dev(struct device *dev);
 
 extern int iommu_attach_group(struct iommu_domain *domain,
@@ -439,12 +440,12 @@ static inline void iommu_set_fault_handler(struct iommu_domain *domain,
 {
 }
 
-static inline void iommu_get_dm_regions(struct device *dev,
+static inline void iommu_get_resv_regions(struct device *dev,
 					struct list_head *list)
 {
 }
 
-static inline void iommu_put_dm_regions(struct device *dev,
+static inline void iommu_put_resv_regions(struct device *dev,
 					struct list_head *list)
 {
 }
-- 
1.9.1
