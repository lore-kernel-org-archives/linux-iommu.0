From: Suravee Suthikulpanit <suravee.suthikulpanit-5C7GfCeVMHo@public.gmane.org>
Subject: [RFC PATCH v2 2/2] iommu/amd: Add support for fast IOTLB flushing
Date: Wed, 27 Dec 2017 04:20:35 -0500
Message-ID: <1514366435-12723-3-git-send-email-suravee.suthikulpanit@amd.com>
References: <1514366435-12723-1-git-send-email-suravee.suthikulpanit@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1514366435-12723-1-git-send-email-suravee.suthikulpanit-5C7GfCeVMHo@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: jroedel-l3A5Bk7waGM@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Implement the newly added IOTLB flushing interface for AMD IOMMU.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit-5C7GfCeVMHo@public.gmane.org>
---
 drivers/iommu/amd_iommu.c       | 73 ++++++++++++++++++++++++++++++++++++++++-
 drivers/iommu/amd_iommu_init.c  |  7 ++++
 drivers/iommu/amd_iommu_types.h |  7 ++++
 3 files changed, 86 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 7d5eb00..42fe365 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -129,6 +129,12 @@ struct dma_ops_domain {
 static struct iova_domain reserved_iova_ranges;
 static struct lock_class_key reserved_rbtree_key;
 
+struct amd_iommu_flush_entries {
+	struct list_head list;
+	unsigned long iova;
+	size_t size;
+};
+
 /****************************************************************************
  *
  * Helper functions
@@ -3043,7 +3049,6 @@ static size_t amd_iommu_unmap(struct iommu_domain *dom, unsigned long iova,
 	unmap_size = iommu_unmap_page(domain, iova, page_size);
 	mutex_unlock(&domain->api_lock);
 
-	domain_flush_tlb_pde(domain);
 	domain_flush_complete(domain);
 
 	return unmap_size;
@@ -3163,6 +3168,69 @@ static bool amd_iommu_is_attach_deferred(struct iommu_domain *domain,
 	return dev_data->defer_attach;
 }
 
+static void amd_iommu_flush_iotlb_all(struct iommu_domain *domain)
+{
+	struct protection_domain *dom = to_pdomain(domain);
+
+	domain_flush_tlb_pde(dom);
+}
+
+static void amd_iommu_iotlb_range_add(struct iommu_domain *domain,
+				      unsigned long iova, size_t size)
+{
+	struct amd_iommu_flush_entries *entry, *p;
+	unsigned long flags;
+	bool found = false;
+
+	spin_lock_irqsave(&amd_iommu_flush_list_lock, flags);
+	list_for_each_entry(p, &amd_iommu_flush_list, list) {
+		if (iova != p->iova)
+			continue;
+
+		if (size > p->size) {
+			p->size = size;
+			pr_debug("%s: update range: iova=%#lx, size = %#lx\n",
+				 __func__, p->iova, p->size);
+		}
+		found = true;
+		break;
+	}
+
+	if (!found) {
+		entry = kzalloc(sizeof(struct amd_iommu_flush_entries),
+				GFP_KERNEL);
+		if (entry) {
+			pr_debug("%s: new range: iova=%lx, size=%#lx\n",
+				 __func__, iova, size);
+
+			entry->iova = iova;
+			entry->size = size;
+			list_add(&entry->list, &amd_iommu_flush_list);
+		}
+	}
+	spin_unlock_irqrestore(&amd_iommu_flush_list_lock, flags);
+}
+
+static void amd_iommu_iotlb_sync(struct iommu_domain *domain)
+{
+	struct protection_domain *pdom = to_pdomain(domain);
+	struct amd_iommu_flush_entries *entry, *next;
+	unsigned long flags;
+
+	/* Note:
+	 * Currently, IOMMU driver just flushes the whole IO/TLB for
+	 * a given domain. So, just remove entries from the list here.
+	 */
+	spin_lock_irqsave(&amd_iommu_flush_list_lock, flags);
+	list_for_each_entry_safe(entry, next, &amd_iommu_flush_list, list) {
+		list_del(&entry->list);
+		kfree(entry);
+	}
+	spin_unlock_irqrestore(&amd_iommu_flush_list_lock, flags);
+
+	domain_flush_tlb_pde(pdom);
+}
+
 const struct iommu_ops amd_iommu_ops = {
 	.capable = amd_iommu_capable,
 	.domain_alloc = amd_iommu_domain_alloc,
@@ -3181,6 +3249,9 @@ static bool amd_iommu_is_attach_deferred(struct iommu_domain *domain,
 	.apply_resv_region = amd_iommu_apply_resv_region,
 	.is_attach_deferred = amd_iommu_is_attach_deferred,
 	.pgsize_bitmap	= AMD_IOMMU_PGSIZES,
+	.flush_iotlb_all = amd_iommu_flush_iotlb_all,
+	.iotlb_range_add = amd_iommu_iotlb_range_add,
+	.iotlb_sync = amd_iommu_iotlb_sync,
 };
 
 /*****************************************************************************
diff --git a/drivers/iommu/amd_iommu_init.c b/drivers/iommu/amd_iommu_init.c
index 6fe2d03..e8f8cee 100644
--- a/drivers/iommu/amd_iommu_init.c
+++ b/drivers/iommu/amd_iommu_init.c
@@ -185,6 +185,12 @@ struct ivmd_header {
 bool amd_iommu_force_isolation __read_mostly;
 
 /*
+ * IOTLB flush list
+ */
+LIST_HEAD(amd_iommu_flush_list);
+spinlock_t amd_iommu_flush_list_lock;
+
+/*
  * List of protection domains - used during resume
  */
 LIST_HEAD(amd_iommu_pd_list);
@@ -2490,6 +2496,7 @@ static int __init early_amd_iommu_init(void)
 	__set_bit(0, amd_iommu_pd_alloc_bitmap);
 
 	spin_lock_init(&amd_iommu_pd_lock);
+	spin_lock_init(&amd_iommu_flush_list_lock);
 
 	/*
 	 * now the data structures are allocated and basically initialized
diff --git a/drivers/iommu/amd_iommu_types.h b/drivers/iommu/amd_iommu_types.h
index f6b24c7..c3f4a7e 100644
--- a/drivers/iommu/amd_iommu_types.h
+++ b/drivers/iommu/amd_iommu_types.h
@@ -668,6 +668,13 @@ struct iommu_dev_data {
 extern struct list_head amd_iommu_pd_list;
 
 /*
+ * Declarations for the global flush list to support
+ * iotlb_range_add() and iotlb_sync.
+ */
+extern spinlock_t amd_iommu_flush_list_lock;
+extern struct list_head amd_iommu_flush_list;
+
+/*
  * Structure defining one entry in the device table
  */
 struct dev_table_entry {
-- 
1.8.3.1
