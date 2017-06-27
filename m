From: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Subject: [PATCH 3/3] iommu/vt-d: don't disable preemption while accessing
	deferred_flush()
Date: Tue, 27 Jun 2017 18:16:48 +0200
Message-ID: <20170627161648.30302-3-bigeasy@linutronix.de>
References: <20170627161648.30302-1-bigeasy@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20170627161648.30302-1-bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org
Cc: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

get_cpu() disables preemption and returns the current CPU number. The
CPU number is only used once while retrieving the address of the local's
CPU deferred_flush pointer.
We can instead use raw_cpu_ptr() while we remain preemptible. The worst
thing that can happen is that flush_unmaps_timeout() is invoked multiple
times: once by taskA after seeing HIGH_WATER_MARK and then preempted to
another CPU and then by taskB which saw HIGH_WATER_MARK on the same CPU
as taskA. It is also likely that ->size got from HIGH_WATER_MARK to 0
right after its read because another CPU invoked flush_unmaps_timeout()
for this CPU.
The access to flush_data is protected by a spinlock so even if we get
migrated to another CPU or preempted - the data structure is protected.

While at it, I marked deferred_flush static since I can't find a
reference to it outside of this file.

Cc: David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Cc: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
---
 drivers/iommu/intel-iommu.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 8500deda9175..1c7118d1525e 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -481,7 +481,7 @@ struct deferred_flush_data {
 	struct deferred_flush_table *tables;
 };
 
-DEFINE_PER_CPU(struct deferred_flush_data, deferred_flush);
+static DEFINE_PER_CPU(struct deferred_flush_data, deferred_flush);
 
 /* bitmap for indexing intel_iommus */
 static int g_num_of_iommus;
@@ -3725,10 +3725,8 @@ static void add_unmap(struct dmar_domain *dom, unsigned long iova_pfn,
 	struct intel_iommu *iommu;
 	struct deferred_flush_entry *entry;
 	struct deferred_flush_data *flush_data;
-	unsigned int cpuid;
 
-	cpuid = get_cpu();
-	flush_data = per_cpu_ptr(&deferred_flush, cpuid);
+	flush_data = raw_cpu_ptr(&deferred_flush);
 
 	/* Flush all CPUs' entries to avoid deferring too much.  If
 	 * this becomes a bottleneck, can just flush us, and rely on
@@ -3761,8 +3759,6 @@ static void add_unmap(struct dmar_domain *dom, unsigned long iova_pfn,
 	}
 	flush_data->size++;
 	spin_unlock_irqrestore(&flush_data->lock, flags);
-
-	put_cpu();
 }
 
 static void intel_unmap(struct device *dev, dma_addr_t dev_addr, size_t size)
-- 
2.13.1
