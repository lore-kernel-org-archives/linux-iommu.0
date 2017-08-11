From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 5/8] iommu/iova: Add flush timer
Date: Fri, 11 Aug 2017 16:41:15 +0200
Message-ID: <1502462478-22045-6-git-send-email-joro@8bytes.org>
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

Add a timer to flush entries from the Flush-Queues every
10ms. This makes sure that no stale TLB entries remain for
too long after an IOVA has been unmapped.

Signed-off-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
---
 drivers/iommu/iova.c | 32 ++++++++++++++++++++++++++++++++
 include/linux/iova.h |  8 ++++++++
 2 files changed, 40 insertions(+)

diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
index 749d395..33edfa7 100644
--- a/drivers/iommu/iova.c
+++ b/drivers/iommu/iova.c
@@ -33,6 +33,7 @@ static unsigned long iova_rcache_get(struct iova_domain *iovad,
 static void init_iova_rcaches(struct iova_domain *iovad);
 static void free_iova_rcaches(struct iova_domain *iovad);
 static void fq_destroy_all_entries(struct iova_domain *iovad);
+static void fq_flush_timeout(unsigned long data);
 
 void
 init_iova_domain(struct iova_domain *iovad, unsigned long granule,
@@ -62,7 +63,11 @@ static void free_iova_flush_queue(struct iova_domain *iovad)
 	if (!iovad->fq)
 		return;
 
+	if (timer_pending(&iovad->fq_timer))
+		del_timer(&iovad->fq_timer);
+
 	fq_destroy_all_entries(iovad);
+
 	free_percpu(iovad->fq);
 
 	iovad->fq         = NULL;
@@ -95,6 +100,9 @@ int init_iova_flush_queue(struct iova_domain *iovad,
 		spin_lock_init(&fq->lock);
 	}
 
+	setup_timer(&iovad->fq_timer, fq_flush_timeout, (unsigned long)iovad);
+	atomic_set(&iovad->fq_timer_on, 0);
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(init_iova_flush_queue);
@@ -539,6 +547,25 @@ static void fq_destroy_all_entries(struct iova_domain *iovad)
 	}
 }
 
+static void fq_flush_timeout(unsigned long data)
+{
+	struct iova_domain *iovad = (struct iova_domain *)data;
+	int cpu;
+
+	atomic_set(&iovad->fq_timer_on, 0);
+	iova_domain_flush(iovad);
+
+	for_each_possible_cpu(cpu) {
+		unsigned long flags;
+		struct iova_fq *fq;
+
+		fq = per_cpu_ptr(iovad->fq, cpu);
+		spin_lock_irqsave(&fq->lock, flags);
+		fq_ring_free(iovad, fq);
+		spin_unlock_irqrestore(&fq->lock, flags);
+	}
+}
+
 void queue_iova(struct iova_domain *iovad,
 		unsigned long pfn, unsigned long pages,
 		unsigned long data)
@@ -569,6 +596,11 @@ void queue_iova(struct iova_domain *iovad,
 	fq->entries[idx].counter  = atomic64_read(&iovad->fq_flush_start_cnt);
 
 	spin_unlock_irqrestore(&fq->lock, flags);
+
+	if (atomic_cmpxchg(&iovad->fq_timer_on, 0, 1) == 0)
+		mod_timer(&iovad->fq_timer,
+			  jiffies + msecs_to_jiffies(IOVA_FQ_TIMEOUT));
+
 	put_cpu_ptr(iovad->fq);
 }
 EXPORT_SYMBOL_GPL(queue_iova);
diff --git a/include/linux/iova.h b/include/linux/iova.h
index 913a690..d179b9b 100644
--- a/include/linux/iova.h
+++ b/include/linux/iova.h
@@ -48,6 +48,9 @@ typedef void (* iova_entry_dtor)(unsigned long data);
 /* Number of entries per Flush Queue */
 #define IOVA_FQ_SIZE	256
 
+/* Timeout (in ms) after which entries are flushed from the Flush-Queue */
+#define IOVA_FQ_TIMEOUT	10
+
 /* Flush Queue entry for defered flushing */
 struct iova_fq_entry {
 	unsigned long iova_pfn;
@@ -86,6 +89,11 @@ struct iova_domain {
 
 	atomic64_t	fq_flush_finish_cnt;	/* Number of TLB flushes that
 						   have been finished */
+
+	struct timer_list fq_timer;		/* Timer to regularily empty the
+						   flush-queues */
+	atomic_t fq_timer_on;			/* 1 when timer is active, 0
+						   when not */
 };
 
 static inline unsigned long iova_size(struct iova *iova)
-- 
2.7.4
