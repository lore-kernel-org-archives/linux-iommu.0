From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 13/20] iommu/amd: Implement flush queue
Date: Fri,  8 Jul 2016 13:45:04 +0200
Message-ID: <1467978311-28322-14-git-send-email-joro@8bytes.org>
References: <1467978311-28322-1-git-send-email-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1467978311-28322-1-git-send-email-joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
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
Cc: Vincent.Wan-5C7GfCeVMHo@public.gmane.org, Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

From: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>

With the flush queue the IOMMU TLBs will not be flushed at
every dma-ops unmap operation. The unmapped ranges will be
queued and flushed at once, when the queue is full. This
makes unmapping operations a lot faster (on average) and
restores the performance of the old address allocator.

Signed-off-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
---
 drivers/iommu/amd_iommu.c | 71 ++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 67 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 7b8e1f8..a3e09cd 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -2128,6 +2128,66 @@ static struct iommu_group *amd_iommu_device_group(struct device *dev)
  *
  *****************************************************************************/
 
+static void __queue_flush(struct flush_queue *queue)
+{
+	struct protection_domain *domain;
+	unsigned long flags;
+	int idx;
+
+	/* First flush TLB of all known domains */
+	spin_lock_irqsave(&amd_iommu_pd_lock, flags);
+	list_for_each_entry(domain, &amd_iommu_pd_list, list)
+		domain_flush_tlb(domain);
+	spin_unlock_irqrestore(&amd_iommu_pd_lock, flags);
+
+	/* Wait until flushes have completed */
+	domain_flush_complete(NULL);
+
+	for (idx = 0; idx < queue->next; ++idx) {
+		struct flush_queue_entry *entry;
+
+		entry = queue->entries + idx;
+
+		free_iova_fast(&entry->dma_dom->iovad,
+				entry->iova_pfn,
+				entry->pages);
+
+		/* Not really necessary, just to make sure we catch any bugs */
+		entry->dma_dom = NULL;
+	}
+
+	queue->next = 0;
+}
+
+static void queue_add(struct dma_ops_domain *dma_dom,
+		      unsigned long address, unsigned long pages)
+{
+	struct flush_queue_entry *entry;
+	struct flush_queue *queue;
+	unsigned long flags;
+	int idx;
+
+	pages     = __roundup_pow_of_two(pages);
+	address >>= PAGE_SHIFT;
+
+	queue = get_cpu_ptr(&flush_queue);
+	spin_lock_irqsave(&queue->lock, flags);
+
+	if (queue->next == FLUSH_QUEUE_SIZE)
+		__queue_flush(queue);
+
+	idx   = queue->next++;
+	entry = queue->entries + idx;
+
+	entry->iova_pfn = address;
+	entry->pages    = pages;
+	entry->dma_dom  = dma_dom;
+
+	spin_unlock_irqrestore(&queue->lock, flags);
+	put_cpu_ptr(&flush_queue);
+}
+
+
 /*
  * In the dma_ops path we only have the struct device. This function
  * finds the corresponding IOMMU, the protection domain and the
@@ -2266,10 +2326,13 @@ static void __unmap_single(struct dma_ops_domain *dma_dom,
 		start += PAGE_SIZE;
 	}
 
-	domain_flush_tlb(&dma_dom->domain);
-	domain_flush_complete(&dma_dom->domain);
-
-	dma_ops_free_iova(dma_dom, dma_addr, pages);
+	if (amd_iommu_unmap_flush) {
+		dma_ops_free_iova(dma_dom, dma_addr, pages);
+		domain_flush_tlb(&dma_dom->domain);
+		domain_flush_complete(&dma_dom->domain);
+	} else {
+		queue_add(dma_dom, dma_addr, pages);
+	}
 }
 
 /*
-- 
1.9.1
