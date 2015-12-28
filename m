From: Adam Morrison <mad-FrESSTt7Abv7r6psnUbsSmZHpeb/A1Y/@public.gmane.org>
Subject: [PATCH 1/7] iommu: refactoring of deferred flush entries
Date: Mon, 28 Dec 2015 18:15:23 +0200
Message-ID: <20151228161523.GA27844@cs.technion.ac.il>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: serebrin-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, dan-FrESSTt7Abv7r6psnUbsSmZHpeb/A1Y/@public.gmane.org, omer-FrESSTt7Abv7r6psnUbsSmZHpeb/A1Y/@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

From: Omer Peleg <omer-FrESSTt7Abv7r6psnUbsSmZHpeb/A1Y/@public.gmane.org>

Currently, deferred flushes' info is striped between several lists in
the flush tables. Instead, move all information about a specific flush
to a single entry in this table.

This patch does not introduce any functional change.

Signed-off-by: Omer Peleg <omer-FrESSTt7Abv7r6psnUbsSmZHpeb/A1Y/@public.gmane.org>
[mad-FrESSTt7Abv7r6psnUbsSmZHpeb/A1Y/@public.gmane.org: rebased and reworded the commit message]
Signed-off-by: Adam Morrison <mad-FrESSTt7Abv7r6psnUbsSmZHpeb/A1Y/@public.gmane.org>
---
 drivers/iommu/intel-iommu.c | 48 +++++++++++++++++++++++++++------------------
 1 file changed, 29 insertions(+), 19 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 16b243e..de7a9fc 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -455,15 +455,19 @@ static void flush_unmaps_timeout(unsigned long data);
 
 static DEFINE_TIMER(unmap_timer,  flush_unmaps_timeout, 0, 0);
 
+struct deferred_flush_entry {
+	struct iova *iova;
+	struct dmar_domain *domain;
+	struct page *freelist;
+};
+
 #define HIGH_WATER_MARK 250
-struct deferred_flush_tables {
+struct deferred_flush_table {
 	int next;
-	struct iova *iova[HIGH_WATER_MARK];
-	struct dmar_domain *domain[HIGH_WATER_MARK];
-	struct page *freelist[HIGH_WATER_MARK];
+	struct deferred_flush_entry entries[HIGH_WATER_MARK];
 };
 
-static struct deferred_flush_tables *deferred_flush;
+static struct deferred_flush_table *deferred_flush;
 
 /* bitmap for indexing intel_iommus */
 static int g_num_of_iommus;
@@ -3039,7 +3043,7 @@ static int __init init_dmars(void)
 	}
 
 	deferred_flush = kzalloc(g_num_of_iommus *
-		sizeof(struct deferred_flush_tables), GFP_KERNEL);
+		sizeof(struct deferred_flush_table), GFP_KERNEL);
 	if (!deferred_flush) {
 		ret = -ENOMEM;
 		goto free_g_iommus;
@@ -3435,22 +3439,25 @@ static void flush_unmaps(void)
 					 DMA_TLB_GLOBAL_FLUSH);
 		for (j = 0; j < deferred_flush[i].next; j++) {
 			unsigned long mask;
-			struct iova *iova = deferred_flush[i].iova[j];
-			struct dmar_domain *domain = deferred_flush[i].domain[j];
+			struct deferred_flush_entry *entry =
+						&deferred_flush->entries[j];
+			struct iova *iova = entry->iova;
+			struct dmar_domain *domain = entry->domain;
+			struct page *freelist = entry->freelist;
 
 			/* On real hardware multiple invalidations are expensive */
 			if (cap_caching_mode(iommu->cap))
 				iommu_flush_iotlb_psi(iommu, domain,
 					iova->pfn_lo, iova_size(iova),
-					!deferred_flush[i].freelist[j], 0);
+					!freelist, 0);
 			else {
 				mask = ilog2(mm_to_dma_pfn(iova_size(iova)));
-				iommu_flush_dev_iotlb(deferred_flush[i].domain[j],
+				iommu_flush_dev_iotlb(domain,
 						(uint64_t)iova->pfn_lo << PAGE_SHIFT, mask);
 			}
-			__free_iova(&deferred_flush[i].domain[j]->iovad, iova);
-			if (deferred_flush[i].freelist[j])
-				dma_free_pagelist(deferred_flush[i].freelist[j]);
+			__free_iova(&domain->iovad, iova);
+			if (freelist)
+				dma_free_pagelist(freelist);
 		}
 		deferred_flush[i].next = 0;
 	}
@@ -3470,8 +3477,9 @@ static void flush_unmaps_timeout(unsigned long data)
 static void add_unmap(struct dmar_domain *dom, struct iova *iova, struct page *freelist)
 {
 	unsigned long flags;
-	int next, iommu_id;
+	int entry_id, iommu_id;
 	struct intel_iommu *iommu;
+	struct deferred_flush_entry *entry;
 
 	spin_lock_irqsave(&async_umap_flush_lock, flags);
 	if (list_size == HIGH_WATER_MARK)
@@ -3480,11 +3488,13 @@ static void add_unmap(struct dmar_domain *dom, struct iova *iova, struct page *f
 	iommu = domain_get_iommu(dom);
 	iommu_id = iommu->seq_id;
 
-	next = deferred_flush[iommu_id].next;
-	deferred_flush[iommu_id].domain[next] = dom;
-	deferred_flush[iommu_id].iova[next] = iova;
-	deferred_flush[iommu_id].freelist[next] = freelist;
-	deferred_flush[iommu_id].next++;
+	entry_id = deferred_flush[iommu_id].next;
+	++(deferred_flush[iommu_id].next);
+
+	entry = &deferred_flush[iommu_id].entries[entry_id];
+	entry->domain = dom;
+	entry->iova = iova;
+	entry->freelist = freelist;
 
 	if (!timer_on) {
 		mod_timer(&unmap_timer, jiffies + msecs_to_jiffies(10));
-- 
1.9.1
