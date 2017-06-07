From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 3/7] iommu/amd: Make use of the per-domain flush queue
Date: Wed,  7 Jun 2017 16:58:16 +0200
Message-ID: <1496847500-6781-4-git-send-email-joro@8bytes.org>
References: <1496847500-6781-1-git-send-email-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1496847500-6781-1-git-send-email-joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
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
Cc: Arindam Nath <arindam.nath-5C7GfCeVMHo@public.gmane.org>, Tom Lendacky <thomas.lendacky-5C7GfCeVMHo@public.gmane.org>, Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

From: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>

Fill the flush-queue on unmap and only flush the IOMMU and
device TLBs when a per-cpu queue gets full.

Signed-off-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
---
 drivers/iommu/amd_iommu.c | 60 +++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 56 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 71c688a..6a5c858 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -1778,6 +1778,61 @@ static int dma_ops_domain_alloc_flush_queue(struct dma_ops_domain *dom)
 	return 0;
 }
 
+static inline bool queue_ring_full(struct flush_queue *queue)
+{
+	return (((queue->tail + 1) % FLUSH_QUEUE_SIZE) == queue->head);
+}
+
+#define queue_ring_for_each(i, q) \
+	for (i = (q)->head; i != (q)->tail; i = (i + 1) % FLUSH_QUEUE_SIZE)
+
+static void queue_release(struct dma_ops_domain *dom,
+			  struct flush_queue *queue)
+{
+	unsigned i;
+
+	queue_ring_for_each(i, queue)
+		free_iova_fast(&dom->iovad,
+			       queue->entries[i].iova_pfn,
+			       queue->entries[i].pages);
+
+	queue->head = queue->tail = 0;
+}
+
+static inline unsigned queue_ring_add(struct flush_queue *queue)
+{
+	unsigned idx = queue->tail;
+
+	queue->tail = (idx + 1) % FLUSH_QUEUE_SIZE;
+
+	return idx;
+}
+
+static void queue_add(struct dma_ops_domain *dom,
+		      unsigned long address, unsigned long pages)
+{
+	struct flush_queue *queue;
+	int idx;
+
+	pages     = __roundup_pow_of_two(pages);
+	address >>= PAGE_SHIFT;
+
+	queue = get_cpu_ptr(dom->flush_queue);
+
+	if (queue_ring_full(queue)) {
+		domain_flush_tlb(&dom->domain);
+		domain_flush_complete(&dom->domain);
+		queue_release(dom, queue);
+	}
+
+	idx = queue_ring_add(queue);
+
+	queue->entries[idx].iova_pfn = address;
+	queue->entries[idx].pages    = pages;
+
+	put_cpu_ptr(dom->flush_queue);
+}
+
 /*
  * Free a domain, only used if something went wrong in the
  * allocation path and we need to free an already allocated page table
@@ -2426,10 +2481,7 @@ static void __unmap_single(struct dma_ops_domain *dma_dom,
 		domain_flush_tlb(&dma_dom->domain);
 		domain_flush_complete(&dma_dom->domain);
 	} else {
-		/* Keep the if() around, we need it later again */
-		dma_ops_free_iova(dma_dom, dma_addr, pages);
-		domain_flush_tlb(&dma_dom->domain);
-		domain_flush_complete(&dma_dom->domain);
+		queue_add(dma_dom, dma_addr, pages);
 	}
 }
 
-- 
2.7.4
