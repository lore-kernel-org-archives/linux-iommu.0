From: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Subject: [PATCH] iommu/amd: Use raw_cpu_ptr() instead of get_cpu_ptr() for
	->flush_queue
Date: Wed, 6 Sep 2017 12:34:59 +0200
Message-ID: <20170906103459.oi2nn7jondjqdo5m@linutronix.de>
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
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, vinadhy-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

get_cpu_ptr() disables preemption and returns the ->flush_queue object
of the current CPU. raw_cpu_ptr() does the same except that it not
disable preemption which means the scheduler can move it to another CPU
after it obtained the per-CPU object.
In this case this is not bad because the data structure itself is
protected with a spin_lock. This change shouldn't matter in general
but on RT it does because the sleeping lock can't be accessed with
disabled preemption.

Cc: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Reported-by: vinadhy-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Signed-off-by: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
---
 drivers/iommu/amd_iommu.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 4ad7e5e31943..943efbc08128 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -1911,7 +1911,7 @@ static void queue_add(struct dma_ops_domain *dom,
 	pages     = __roundup_pow_of_two(pages);
 	address >>= PAGE_SHIFT;
 
-	queue = get_cpu_ptr(dom->flush_queue);
+	queue = raw_cpu_ptr(dom->flush_queue);
 	spin_lock_irqsave(&queue->lock, flags);
 
 	/*
@@ -1940,8 +1940,6 @@ static void queue_add(struct dma_ops_domain *dom,
 
 	if (atomic_cmpxchg(&dom->flush_timer_on, 0, 1) == 0)
 		mod_timer(&dom->flush_timer, jiffies + msecs_to_jiffies(10));
-
-	put_cpu_ptr(dom->flush_queue);
 }
 
 static void queue_flush_timeout(unsigned long data)
-- 
2.14.1
