From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 2/8] iommu/iova: Implement Flush-Queue ring buffer
Date: Fri, 11 Aug 2017 16:41:12 +0200
Message-ID: <1502462478-22045-3-git-send-email-joro@8bytes.org>
References: <1502462478-22045-1-git-send-email-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1502462478-22045-1-git-send-email-joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
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
Cc: dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

From: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>

Add a function to add entries to the Flush-Queue ring
buffer. If the buffer is full, call the flush-callback and
free the entries.

Signed-off-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
---
 drivers/iommu/iova.c | 80 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/iova.h |  9 ++++++
 2 files changed, 89 insertions(+)

diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
index b9f6ce0..e5c9a7a 100644
--- a/drivers/iommu/iova.c
+++ b/drivers/iommu/iova.c
@@ -32,6 +32,7 @@ static unsigned long iova_rcache_get(struct iova_domain *iovad,
 				     unsigned long limit_pfn);
 static void init_iova_rcaches(struct iova_domain *iovad);
 static void free_iova_rcaches(struct iova_domain *iovad);
+static void fq_destroy_all_entries(struct iova_domain *iovad);
 
 void
 init_iova_domain(struct iova_domain *iovad, unsigned long granule,
@@ -61,6 +62,7 @@ static void free_iova_flush_queue(struct iova_domain *iovad)
 	if (!iovad->fq)
 		return;
 
+	fq_destroy_all_entries(iovad);
 	free_percpu(iovad->fq);
 
 	iovad->fq         = NULL;
@@ -461,6 +463,84 @@ free_iova_fast(struct iova_domain *iovad, unsigned long pfn, unsigned long size)
 }
 EXPORT_SYMBOL_GPL(free_iova_fast);
 
+#define fq_ring_for_each(i, fq) \
+	for ((i) = (fq)->head; (i) != (fq)->tail; (i) = ((i) + 1) % IOVA_FQ_SIZE)
+
+static inline bool fq_full(struct iova_fq *fq)
+{
+	return (((fq->tail + 1) % IOVA_FQ_SIZE) == fq->head);
+}
+
+static inline unsigned fq_ring_add(struct iova_fq *fq)
+{
+	unsigned idx = fq->tail;
+
+	fq->tail = (idx + 1) % IOVA_FQ_SIZE;
+
+	return idx;
+}
+
+static void fq_ring_free(struct iova_domain *iovad, struct iova_fq *fq)
+{
+	unsigned idx;
+
+	fq_ring_for_each(idx, fq) {
+
+		if (iovad->entry_dtor)
+			iovad->entry_dtor(fq->entries[idx].data);
+
+		free_iova_fast(iovad,
+			       fq->entries[idx].iova_pfn,
+			       fq->entries[idx].pages);
+	}
+
+	fq->head = 0;
+	fq->tail = 0;
+}
+
+static void fq_destroy_all_entries(struct iova_domain *iovad)
+{
+	int cpu;
+
+	/*
+	 * This code runs when the iova_domain is being detroyed, so don't
+	 * bother to free iovas, just call the entry_dtor on all remaining
+	 * entries.
+	 */
+	if (!iovad->entry_dtor)
+		return;
+
+	for_each_possible_cpu(cpu) {
+		struct iova_fq *fq = per_cpu_ptr(iovad->fq, cpu);
+		int idx;
+
+		fq_ring_for_each(idx, fq)
+			iovad->entry_dtor(fq->entries[idx].data);
+	}
+}
+
+void queue_iova(struct iova_domain *iovad,
+		unsigned long pfn, unsigned long pages,
+		unsigned long data)
+{
+	struct iova_fq *fq = get_cpu_ptr(iovad->fq);
+	unsigned idx;
+
+	if (fq_full(fq)) {
+		iovad->flush_cb(iovad);
+		fq_ring_free(iovad, fq);
+	}
+
+	idx = fq_ring_add(fq);
+
+	fq->entries[idx].iova_pfn = pfn;
+	fq->entries[idx].pages    = pages;
+	fq->entries[idx].data     = data;
+
+	put_cpu_ptr(iovad->fq);
+}
+EXPORT_SYMBOL_GPL(queue_iova);
+
 /**
  * put_iova_domain - destroys the iova doamin
  * @iovad: - iova domain in question.
diff --git a/include/linux/iova.h b/include/linux/iova.h
index 8aa1089..1ae8524 100644
--- a/include/linux/iova.h
+++ b/include/linux/iova.h
@@ -127,6 +127,9 @@ struct iova *alloc_iova(struct iova_domain *iovad, unsigned long size,
 	bool size_aligned);
 void free_iova_fast(struct iova_domain *iovad, unsigned long pfn,
 		    unsigned long size);
+void queue_iova(struct iova_domain *iovad,
+		unsigned long pfn, unsigned long pages,
+		unsigned long data);
 unsigned long alloc_iova_fast(struct iova_domain *iovad, unsigned long size,
 			      unsigned long limit_pfn);
 struct iova *reserve_iova(struct iova_domain *iovad, unsigned long pfn_lo,
@@ -182,6 +185,12 @@ static inline void free_iova_fast(struct iova_domain *iovad,
 {
 }
 
+static inline void queue_iova(struct iova_domain *iovad,
+			      unsigned long pfn, unsigned long pages,
+			      unsigned long data)
+{
+}
+
 static inline unsigned long alloc_iova_fast(struct iova_domain *iovad,
 					    unsigned long size,
 					    unsigned long limit_pfn)
-- 
2.7.4
