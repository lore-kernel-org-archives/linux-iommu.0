From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 2/7] iommu/amd: Add per-domain flush-queue data structures
Date: Wed,  7 Jun 2017 16:58:15 +0200
Message-ID: <1496847500-6781-3-git-send-email-joro@8bytes.org>
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

Make the flush-queue per dma-ops domain and add code
allocate and free the flush-queues;

Signed-off-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
---
 drivers/iommu/amd_iommu.c | 69 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 69 insertions(+)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 6304a6e..71c688a 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -134,6 +134,18 @@ static void update_domain(struct protection_domain *domain);
 static int protection_domain_init(struct protection_domain *domain);
 static void detach_device(struct device *dev);
 
+#define FLUSH_QUEUE_SIZE 256
+
+struct flush_queue_entry {
+	unsigned long iova_pfn;
+	unsigned long pages;
+};
+
+struct flush_queue {
+	struct flush_queue_entry *entries;
+	unsigned head, tail;
+};
+
 /*
  * Data container for a dma_ops specific protection domain
  */
@@ -143,6 +155,8 @@ struct dma_ops_domain {
 
 	/* IOVA RB-Tree */
 	struct iova_domain iovad;
+
+	struct flush_queue __percpu *flush_queue;
 };
 
 static struct iova_domain reserved_iova_ranges;
@@ -1714,6 +1728,56 @@ static void free_gcr3_table(struct protection_domain *domain)
 	free_page((unsigned long)domain->gcr3_tbl);
 }
 
+static void dma_ops_domain_free_flush_queue(struct dma_ops_domain *dom)
+{
+	int cpu;
+
+	for_each_possible_cpu(cpu) {
+		struct flush_queue *queue;
+
+		queue = per_cpu_ptr(dom->flush_queue, cpu);
+		kfree(queue->entries);
+	}
+
+	free_percpu(dom->flush_queue);
+
+	dom->flush_queue = NULL;
+}
+
+static int dma_ops_domain_alloc_flush_queue(struct dma_ops_domain *dom)
+{
+	int cpu;
+
+	dom->flush_queue = alloc_percpu(struct flush_queue);
+	if (!dom->flush_queue)
+		return -ENOMEM;
+
+	/* First make sure everything is cleared */
+	for_each_possible_cpu(cpu) {
+		struct flush_queue *queue;
+
+		queue = per_cpu_ptr(dom->flush_queue, cpu);
+		queue->head    = 0;
+		queue->tail    = 0;
+		queue->entries = NULL;
+	}
+
+	/* Now start doing the allocation */
+	for_each_possible_cpu(cpu) {
+		struct flush_queue *queue;
+
+		queue = per_cpu_ptr(dom->flush_queue, cpu);
+		queue->entries = kzalloc(FLUSH_QUEUE_SIZE * sizeof(*queue->entries),
+					 GFP_KERNEL);
+		if (!queue->entries) {
+			dma_ops_domain_free_flush_queue(dom);
+			return -ENOMEM;
+		}
+	}
+
+	return 0;
+}
+
 /*
  * Free a domain, only used if something went wrong in the
  * allocation path and we need to free an already allocated page table
@@ -1725,6 +1789,8 @@ static void dma_ops_domain_free(struct dma_ops_domain *dom)
 
 	del_domain_from_list(&dom->domain);
 
+	dma_ops_domain_free_flush_queue(dom);
+
 	put_iova_domain(&dom->iovad);
 
 	free_pagetable(&dom->domain);
@@ -1763,6 +1829,9 @@ static struct dma_ops_domain *dma_ops_domain_alloc(void)
 	/* Initialize reserved ranges */
 	copy_reserved_iova(&reserved_iova_ranges, &dma_dom->iovad);
 
+	if (dma_ops_domain_alloc_flush_queue(dma_dom))
+		goto free_dma_dom;
+
 	add_domain_to_list(&dma_dom->domain);
 
 	return dma_dom;
-- 
2.7.4
