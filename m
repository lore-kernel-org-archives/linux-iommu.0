From: Benjamin Serebrin via iommu <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Subject: Re: [PATCH 2/7] iommu: per-cpu deferred invalidation queues
Date: Mon, 11 Apr 2016 13:10:41 -0700
Message-ID: <CAN+hb0Wrzfyp7b9iE-FqcMhR+kP+Aq=OJDF8LkVKJb_jOGVaBQ@mail.gmail.com>
References: <20151228161603.GA27859@cs.technion.ac.il>
Reply-To: Benjamin Serebrin <serebrin-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20151228161603.GA27859-FrESSTt7Abv7r6psnUbsSmZHpeb/A1Y/@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Adam Morrison <mad-FrESSTt7Abv7r6psnUbsSmZHpeb/A1Y/@public.gmane.org>
Cc: Omer Peleg <omer-FrESSTt7Abv7r6psnUbsSmZHpeb/A1Y/@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Dan Tsafrir <dan-FrESSTt7Abv7r6psnUbsSmZHpeb/A1Y/@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Reviewed-by: Ben Serebrin <serebrin-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>

Commit message nit: s/defererred/deferred/

intel-iommu.c Line 3615: I'd suggest making the 10ms into a #defined constant.

On Mon, Dec 28, 2015 at 8:16 AM, Adam Morrison <mad-FrESSTt7Abv7r6psnUbsSmZHpeb/A1Y/@public.gmane.org> wrote:
> From: Omer Peleg <omer-FrESSTt7Abv7r6psnUbsSmZHpeb/A1Y/@public.gmane.org>
>
> The IOMMU's IOTLB invalidation is a costly process.  When iommu mode
> is not set to "strict", it is done asynchronously. Current code
> amortizes the cost of invalidating IOTLB entries by batching all the
> invalidations in the system and performing a single global invalidation
> instead. The code queues pending invalidations in a global queue that
> is accessed under the global "async_umap_flush_lock" spinlock, which
> can result is significant spinlock contention.
>
> This patch splits this deferred queue into multiple per-cpu defererred
> queues, and thus gets rid of the "async_umap_flush_lock" and its
> contention.
>
> Signed-off-by: Omer Peleg <omer-FrESSTt7Abv7r6psnUbsSmZHpeb/A1Y/@public.gmane.org>
> [mad-FrESSTt7Abv7r6psnUbsSmZHpeb/A1Y/@public.gmane.org: rebased, cleaned up and reworded the commit message]
> Signed-off-by: Adam Morrison <mad-FrESSTt7Abv7r6psnUbsSmZHpeb/A1Y/@public.gmane.org>
> ---
>  drivers/iommu/intel-iommu.c | 105 +++++++++++++++++++++++++++-----------------
>  1 file changed, 64 insertions(+), 41 deletions(-)
>
> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
> index de7a9fc..7118ed3 100644
> --- a/drivers/iommu/intel-iommu.c
> +++ b/drivers/iommu/intel-iommu.c
> @@ -453,8 +453,6 @@ static LIST_HEAD(dmar_rmrr_units);
>
>  static void flush_unmaps_timeout(unsigned long data);
>
> -static DEFINE_TIMER(unmap_timer,  flush_unmaps_timeout, 0, 0);
> -
>  struct deferred_flush_entry {
>         struct iova *iova;
>         struct dmar_domain *domain;
> @@ -467,17 +465,19 @@ struct deferred_flush_table {
>         struct deferred_flush_entry entries[HIGH_WATER_MARK];
>  };
>
> -static struct deferred_flush_table *deferred_flush;
> +struct deferred_flush_data {
> +       spinlock_t lock;
> +       int timer_on;
> +       struct timer_list timer;
> +       long size;
> +       struct deferred_flush_table *tables;
> +};
> +
> +DEFINE_PER_CPU(struct deferred_flush_data, deferred_flush);
>
>  /* bitmap for indexing intel_iommus */
>  static int g_num_of_iommus;
>
> -static DEFINE_SPINLOCK(async_umap_flush_lock);
> -static LIST_HEAD(unmaps_to_do);
> -
> -static int timer_on;
> -static long list_size;
> -
>  static void domain_exit(struct dmar_domain *domain);
>  static void domain_remove_dev_info(struct dmar_domain *domain);
>  static void dmar_remove_one_dev_info(struct dmar_domain *domain,
> @@ -1869,8 +1869,12 @@ static void domain_exit(struct dmar_domain *domain)
>                 return;
>
>         /* Flush any lazy unmaps that may reference this domain */
> -       if (!intel_iommu_strict)
> -               flush_unmaps_timeout(0);
> +       if (!intel_iommu_strict) {
> +               int cpu;
> +
> +               for_each_possible_cpu(cpu)
> +                       flush_unmaps_timeout(cpu);
> +       }
>
>         /* Remove associated devices and clear attached or cached domains */
>         rcu_read_lock();
> @@ -3009,7 +3013,7 @@ static int __init init_dmars(void)
>         bool copied_tables = false;
>         struct device *dev;
>         struct intel_iommu *iommu;
> -       int i, ret;
> +       int i, ret, cpu;
>
>         /*
>          * for each drhd
> @@ -3042,11 +3046,20 @@ static int __init init_dmars(void)
>                 goto error;
>         }
>
> -       deferred_flush = kzalloc(g_num_of_iommus *
> -               sizeof(struct deferred_flush_table), GFP_KERNEL);
> -       if (!deferred_flush) {
> -               ret = -ENOMEM;
> -               goto free_g_iommus;
> +       for_each_possible_cpu(cpu) {
> +               struct deferred_flush_data *dfd = per_cpu_ptr(&deferred_flush,
> +                                                             cpu);
> +
> +               dfd->tables = kzalloc(g_num_of_iommus *
> +                                     sizeof(struct deferred_flush_table),
> +                                     GFP_KERNEL);
> +               if (!dfd->tables) {
> +                       ret = -ENOMEM;
> +                       goto free_g_iommus;
> +               }
> +
> +               spin_lock_init(&dfd->lock);
> +               setup_timer(&dfd->timer, flush_unmaps_timeout, cpu);
>         }
>
>         for_each_active_iommu(iommu, drhd) {
> @@ -3212,8 +3225,9 @@ free_iommu:
>                 disable_dmar_iommu(iommu);
>                 free_dmar_iommu(iommu);
>         }
> -       kfree(deferred_flush);
>  free_g_iommus:
> +       for_each_possible_cpu(cpu)
> +               kfree(per_cpu_ptr(&deferred_flush, cpu)->tables);
>         kfree(g_iommus);
>  error:
>         return ret;
> @@ -3418,29 +3432,31 @@ static dma_addr_t intel_map_page(struct device *dev, struct page *page,
>                                   dir, *dev->dma_mask);
>  }
>
> -static void flush_unmaps(void)
> +static void flush_unmaps(struct deferred_flush_data *flush_data)
>  {
>         int i, j;
>
> -       timer_on = 0;
> +       flush_data->timer_on = 0;
>
>         /* just flush them all */
>         for (i = 0; i < g_num_of_iommus; i++) {
>                 struct intel_iommu *iommu = g_iommus[i];
> +               struct deferred_flush_table *flush_table =
> +                               &flush_data->tables[i];
>                 if (!iommu)
>                         continue;
>
> -               if (!deferred_flush[i].next)
> +               if (!flush_table->next)
>                         continue;
>
>                 /* In caching mode, global flushes turn emulation expensive */
>                 if (!cap_caching_mode(iommu->cap))
>                         iommu->flush.flush_iotlb(iommu, 0, 0, 0,
>                                          DMA_TLB_GLOBAL_FLUSH);
> -               for (j = 0; j < deferred_flush[i].next; j++) {
> +               for (j = 0; j < flush_table->next; j++) {
>                         unsigned long mask;
>                         struct deferred_flush_entry *entry =
> -                                               &deferred_flush->entries[j];
> +                                               &flush_table->entries[j];
>                         struct iova *iova = entry->iova;
>                         struct dmar_domain *domain = entry->domain;
>                         struct page *freelist = entry->freelist;
> @@ -3459,19 +3475,20 @@ static void flush_unmaps(void)
>                         if (freelist)
>                                 dma_free_pagelist(freelist);
>                 }
> -               deferred_flush[i].next = 0;
> +               flush_table->next = 0;
>         }
>
> -       list_size = 0;
> +       flush_data->size = 0;
>  }
>
> -static void flush_unmaps_timeout(unsigned long data)
> +static void flush_unmaps_timeout(unsigned long cpuid)
>  {
> +       struct deferred_flush_data *flush_data = this_cpu_ptr(&deferred_flush);
>         unsigned long flags;
>
> -       spin_lock_irqsave(&async_umap_flush_lock, flags);
> -       flush_unmaps();
> -       spin_unlock_irqrestore(&async_umap_flush_lock, flags);
> +       spin_lock_irqsave(&flush_data->lock, flags);
> +       flush_unmaps(flush_data);
> +       spin_unlock_irqrestore(&flush_data->lock, flags);
>  }
>
>  static void add_unmap(struct dmar_domain *dom, struct iova *iova, struct page *freelist)
> @@ -3480,28 +3497,35 @@ static void add_unmap(struct dmar_domain *dom, struct iova *iova, struct page *f
>         int entry_id, iommu_id;
>         struct intel_iommu *iommu;
>         struct deferred_flush_entry *entry;
> +       struct deferred_flush_data *flush_data;
> +       unsigned int cpuid;
> +
> +       cpuid = get_cpu();
> +       flush_data = per_cpu_ptr(&deferred_flush, cpuid);
>
> -       spin_lock_irqsave(&async_umap_flush_lock, flags);
> -       if (list_size == HIGH_WATER_MARK)
> -               flush_unmaps();
> +       spin_lock_irqsave(&flush_data->lock, flags);
> +       if (flush_data->size == HIGH_WATER_MARK)
> +               flush_unmaps(flush_data);
>
>         iommu = domain_get_iommu(dom);
>         iommu_id = iommu->seq_id;
>
> -       entry_id = deferred_flush[iommu_id].next;
> -       ++(deferred_flush[iommu_id].next);
> +       entry_id = flush_data->tables[iommu_id].next;
> +       ++(flush_data->tables[iommu_id].next);
>
> -       entry = &deferred_flush[iommu_id].entries[entry_id];
> +       entry = &flush_data->tables[iommu_id].entries[entry_id];
>         entry->domain = dom;
>         entry->iova = iova;
>         entry->freelist = freelist;
>
> -       if (!timer_on) {
> -               mod_timer(&unmap_timer, jiffies + msecs_to_jiffies(10));
> -               timer_on = 1;
> +       if (!flush_data->timer_on) {
> +               mod_timer(&flush_data->timer, jiffies + msecs_to_jiffies(10));
> +               flush_data->timer_on = 1;
>         }
> -       list_size++;
> -       spin_unlock_irqrestore(&async_umap_flush_lock, flags);
> +       flush_data->size++;
> +       spin_unlock_irqrestore(&flush_data->lock, flags);
> +
> +       put_cpu();
>  }
>
>  static void intel_unmap(struct device *dev, dma_addr_t dev_addr)
> @@ -4542,7 +4566,6 @@ int __init intel_iommu_init(void)
>         up_write(&dmar_global_lock);
>         pr_info("Intel(R) Virtualization Technology for Directed I/O\n");
>
> -       init_timer(&unmap_timer);
>  #ifdef CONFIG_SWIOTLB
>         swiotlb = 0;
>  #endif
> --
> 1.9.1
>
