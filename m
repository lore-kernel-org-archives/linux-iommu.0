From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 3/8] iommu/iova: Add flush counters to Flush-Queue
	implementation
Date: Fri, 11 Aug 2017 16:41:13 +0200
Message-ID: <1502462478-22045-4-git-send-email-joro@8bytes.org>
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

There are two counters:

	* fq_flush_start_cnt  - Increased when a TLB flush
	                        is started.

	* fq_flush_finish_cnt - Increased when a TLB flush
				is finished.

The fq_flush_start_cnt is assigned to every Flush-Queue
entry on its creation. When freeing entries from the
Flush-Queue, the value in the entry is compared to the
fq_flush_finish_cnt. The entry can only be freed when its
value is less than the value of fq_flush_finish_cnt.

The reason for these counters it to take advantage of IOMMU
TLB flushes that happened on other CPUs. These already
flushed the TLB for Flush-Queue entries on other CPUs so
that they can already be freed without flushing the TLB
again.

This makes it less likely that the Flush-Queue is full and
saves IOMMU TLB flushes.

Signed-off-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
---
 drivers/iommu/iova.c | 27 ++++++++++++++++++++++++---
 include/linux/iova.h |  8 ++++++++
 2 files changed, 32 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
index e5c9a7a..47b144e 100644
--- a/drivers/iommu/iova.c
+++ b/drivers/iommu/iova.c
@@ -75,6 +75,9 @@ int init_iova_flush_queue(struct iova_domain *iovad,
 {
 	int cpu;
 
+	atomic64_set(&iovad->fq_flush_start_cnt,  0);
+	atomic64_set(&iovad->fq_flush_finish_cnt, 0);
+
 	iovad->fq = alloc_percpu(struct iova_fq);
 	if (!iovad->fq)
 		return -ENOMEM;
@@ -482,20 +485,30 @@ static inline unsigned fq_ring_add(struct iova_fq *fq)
 
 static void fq_ring_free(struct iova_domain *iovad, struct iova_fq *fq)
 {
+	u64 counter = atomic64_read(&iovad->fq_flush_finish_cnt);
 	unsigned idx;
 
 	fq_ring_for_each(idx, fq) {
 
+		if (fq->entries[idx].counter >= counter)
+			break;
+
 		if (iovad->entry_dtor)
 			iovad->entry_dtor(fq->entries[idx].data);
 
 		free_iova_fast(iovad,
 			       fq->entries[idx].iova_pfn,
 			       fq->entries[idx].pages);
+
+		fq->head = (fq->head + 1) % IOVA_FQ_SIZE;
 	}
+}
 
-	fq->head = 0;
-	fq->tail = 0;
+static void iova_domain_flush(struct iova_domain *iovad)
+{
+	atomic64_inc(&iovad->fq_flush_start_cnt);
+	iovad->flush_cb(iovad);
+	atomic64_inc(&iovad->fq_flush_finish_cnt);
 }
 
 static void fq_destroy_all_entries(struct iova_domain *iovad)
@@ -526,8 +539,15 @@ void queue_iova(struct iova_domain *iovad,
 	struct iova_fq *fq = get_cpu_ptr(iovad->fq);
 	unsigned idx;
 
+	/*
+	 * First remove all entries from the flush queue that have already been
+	 * flushed out on another CPU. This makes the fq_full() check below less
+	 * likely to be true.
+	 */
+	fq_ring_free(iovad, fq);
+
 	if (fq_full(fq)) {
-		iovad->flush_cb(iovad);
+		iova_domain_flush(iovad);
 		fq_ring_free(iovad, fq);
 	}
 
@@ -536,6 +556,7 @@ void queue_iova(struct iova_domain *iovad,
 	fq->entries[idx].iova_pfn = pfn;
 	fq->entries[idx].pages    = pages;
 	fq->entries[idx].data     = data;
+	fq->entries[idx].counter  = atomic64_read(&iovad->fq_flush_start_cnt);
 
 	put_cpu_ptr(iovad->fq);
 }
diff --git a/include/linux/iova.h b/include/linux/iova.h
index 1ae8524..985b800 100644
--- a/include/linux/iova.h
+++ b/include/linux/iova.h
@@ -14,6 +14,7 @@
 #include <linux/types.h>
 #include <linux/kernel.h>
 #include <linux/rbtree.h>
+#include <linux/atomic.h>
 #include <linux/dma-mapping.h>
 
 /* iova structure */
@@ -52,6 +53,7 @@ struct iova_fq_entry {
 	unsigned long iova_pfn;
 	unsigned long pages;
 	unsigned long data;
+	u64 counter; /* Flush counter when this entrie was added */
 };
 
 /* Per-CPU Flush Queue structure */
@@ -77,6 +79,12 @@ struct iova_domain {
 					   iova entry */
 
 	struct iova_fq __percpu *fq;	/* Flush Queue */
+
+	atomic64_t	fq_flush_start_cnt;	/* Number of TLB flushes that
+						   have been started */
+
+	atomic64_t	fq_flush_finish_cnt;	/* Number of TLB flushes that
+						   have been finished */
 };
 
 static inline unsigned long iova_size(struct iova *iova)
-- 
2.7.4
