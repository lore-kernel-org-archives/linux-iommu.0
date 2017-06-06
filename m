From: "Nath, Arindam" <Arindam.Nath-5C7GfCeVMHo@public.gmane.org>
Subject: RE: [PATCH v1 3/3] iommu/amd: Optimize the IOMMU queue flush
Date: Tue, 6 Jun 2017 10:02:31 +0000
Message-ID: <MWHPR12MB15181A6A020ACA2F53DF70339CCB0@MWHPR12MB1518.namprd12.prod.outlook.com>
References: <20170605195203.11512.20579.stgit@tlendack-t1.amdoffice.net>
	<20170605195235.11512.52995.stgit@tlendack-t1.amdoffice.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20170605195235.11512.52995.stgit-qCXWGYdRb2BnqfbPTmsdiZQ+2ll4COg0XqFh9Ls21Oc@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Craig Stein <stein12c-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jan Vesely <jv356-nChP9VK/LToysehGhLVACCmkPJUwDNjP@public.gmane.org>, "Lendacky, Thomas" <Thomas.Lendacky-5C7GfCeVMHo@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

>-----Original Message-----
>From: Lendacky, Thomas
>Sent: Tuesday, June 06, 2017 1:23 AM
>To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
>Cc: Nath, Arindam <Arindam.Nath-5C7GfCeVMHo@public.gmane.org>; Joerg Roedel
><joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>; Duran, Leo <leo.duran-5C7GfCeVMHo@public.gmane.org>; Suthikulpanit,
>Suravee <Suravee.Suthikulpanit-5C7GfCeVMHo@public.gmane.org>
>Subject: [PATCH v1 3/3] iommu/amd: Optimize the IOMMU queue flush
>
>After reducing the amount of MMIO performed by the IOMMU during
>operation,
>perf data shows that flushing the TLB for all protection domains during
>DMA unmapping is a performance issue. It is not necessary to flush the
>TLBs for all protection domains, only the protection domains associated
>with iova's on the flush queue.
>
>Create a separate queue that tracks the protection domains associated with
>the iova's on the flush queue. This new queue optimizes the flushing of
>TLBs to the required protection domains.
>
>Reviewed-by: Arindam Nath <arindam.nath-5C7GfCeVMHo@public.gmane.org>
>Signed-off-by: Tom Lendacky <thomas.lendacky-5C7GfCeVMHo@public.gmane.org>
>---
> drivers/iommu/amd_iommu.c |   56
>++++++++++++++++++++++++++++++++++++++++-----
> 1 file changed, 50 insertions(+), 6 deletions(-)
>
>diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
>index 856103b..a5e77f0 100644
>--- a/drivers/iommu/amd_iommu.c
>+++ b/drivers/iommu/amd_iommu.c
>@@ -103,7 +103,18 @@ struct flush_queue {
> 	struct flush_queue_entry *entries;
> };
>
>+struct flush_pd_queue_entry {
>+	struct protection_domain *pd;
>+};
>+
>+struct flush_pd_queue {
>+	/* No lock needed, protected by flush_queue lock */
>+	unsigned next;
>+	struct flush_pd_queue_entry *entries;
>+};
>+
> static DEFINE_PER_CPU(struct flush_queue, flush_queue);
>+static DEFINE_PER_CPU(struct flush_pd_queue, flush_pd_queue);
>
> static atomic_t queue_timer_on;
> static struct timer_list queue_timer;
>@@ -2227,16 +2238,20 @@ static struct iommu_group
>*amd_iommu_device_group(struct device *dev)
>  *
>
>***********************************************************
>******************/
>
>-static void __queue_flush(struct flush_queue *queue)
>+static void __queue_flush(struct flush_queue *queue,
>+			  struct flush_pd_queue *pd_queue)
> {
>-	struct protection_domain *domain;
> 	unsigned long flags;
> 	int idx;
>
> 	/* First flush TLB of all known domains */
> 	spin_lock_irqsave(&amd_iommu_pd_lock, flags);
>-	list_for_each_entry(domain, &amd_iommu_pd_list, list)
>-		domain_flush_tlb(domain);
>+	for (idx = 0; idx < pd_queue->next; ++idx) {
>+		struct flush_pd_queue_entry *entry;
>+
>+		entry = pd_queue->entries + idx;
>+		domain_flush_tlb(entry->pd);
>+	}
> 	spin_unlock_irqrestore(&amd_iommu_pd_lock, flags);
>
> 	/* Wait until flushes have completed */
>@@ -2255,6 +2270,7 @@ static void __queue_flush(struct flush_queue
>*queue)
> 		entry->dma_dom = NULL;
> 	}
>
>+	pd_queue->next = 0;
> 	queue->next = 0;
> }
>
>@@ -2263,13 +2279,15 @@ static void queue_flush_all(void)
> 	int cpu;
>
> 	for_each_possible_cpu(cpu) {
>+		struct flush_pd_queue *pd_queue;
> 		struct flush_queue *queue;
> 		unsigned long flags;
>
> 		queue = per_cpu_ptr(&flush_queue, cpu);
>+		pd_queue = per_cpu_ptr(&flush_pd_queue, cpu);
> 		spin_lock_irqsave(&queue->lock, flags);
> 		if (queue->next > 0)
>-			__queue_flush(queue);
>+			__queue_flush(queue, pd_queue);
> 		spin_unlock_irqrestore(&queue->lock, flags);
> 	}
> }
>@@ -2283,6 +2301,8 @@ static void queue_flush_timeout(unsigned long
>unsused)
> static void queue_add(struct dma_ops_domain *dma_dom,
> 		      unsigned long address, unsigned long pages)
> {
>+	struct flush_pd_queue_entry *pd_entry;
>+	struct flush_pd_queue *pd_queue;
> 	struct flush_queue_entry *entry;
> 	struct flush_queue *queue;
> 	unsigned long flags;
>@@ -2292,10 +2312,22 @@ static void queue_add(struct dma_ops_domain
>*dma_dom,
> 	address >>= PAGE_SHIFT;
>
> 	queue = get_cpu_ptr(&flush_queue);
>+	pd_queue = get_cpu_ptr(&flush_pd_queue);
> 	spin_lock_irqsave(&queue->lock, flags);
>
> 	if (queue->next == FLUSH_QUEUE_SIZE)
>-		__queue_flush(queue);
>+		__queue_flush(queue, pd_queue);
>+
>+	for (idx = 0; idx < pd_queue->next; ++idx) {
>+		pd_entry = pd_queue->entries + idx;
>+		if (pd_entry->pd == &dma_dom->domain)
>+			break;
>+	}
>+	if (idx == pd_queue->next) {
>+		/* New protection domain, add it to the list */
>+		pd_entry = pd_queue->entries + pd_queue->next++;
>+		pd_entry->pd = &dma_dom->domain;
>+	}
>
> 	idx   = queue->next++;
> 	entry = queue->entries + idx;
>@@ -2309,6 +2341,7 @@ static void queue_add(struct dma_ops_domain
>*dma_dom,
> 	if (atomic_cmpxchg(&queue_timer_on, 0, 1) == 0)
> 		mod_timer(&queue_timer, jiffies + msecs_to_jiffies(10));
>
>+	put_cpu_ptr(&flush_pd_queue);
> 	put_cpu_ptr(&flush_queue);
> }
>
>@@ -2810,6 +2843,8 @@ int __init amd_iommu_init_api(void)
> 		return ret;
>
> 	for_each_possible_cpu(cpu) {
>+		struct flush_pd_queue *pd_queue =
>per_cpu_ptr(&flush_pd_queue,
>+							      cpu);
> 		struct flush_queue *queue = per_cpu_ptr(&flush_queue,
>cpu);
>
> 		queue->entries = kzalloc(FLUSH_QUEUE_SIZE *
>@@ -2819,6 +2854,12 @@ int __init amd_iommu_init_api(void)
> 			goto out_put_iova;
>
> 		spin_lock_init(&queue->lock);
>+
>+		pd_queue->entries = kzalloc(FLUSH_QUEUE_SIZE *
>+					    sizeof(*pd_queue->entries),
>+					    GFP_KERNEL);
>+		if (!pd_queue->entries)
>+			goto out_put_iova;
> 	}
>
> 	err = bus_set_iommu(&pci_bus_type, &amd_iommu_ops);
>@@ -2836,9 +2877,12 @@ int __init amd_iommu_init_api(void)
>
> out_put_iova:
> 	for_each_possible_cpu(cpu) {
>+		struct flush_pd_queue *pd_queue =
>per_cpu_ptr(&flush_pd_queue,
>+							      cpu);
> 		struct flush_queue *queue = per_cpu_ptr(&flush_queue,
>cpu);
>
> 		kfree(queue->entries);
>+		kfree(pd_queue->entries);
> 	}
>
> 	return -ENOMEM;

Craig and Jan, can you please confirm whether this patch fixes the IOMMU timeout errors you encountered before? If it does, then this is a better implementation of the fix I provided few weeks back.

Thanks,
Arindam
