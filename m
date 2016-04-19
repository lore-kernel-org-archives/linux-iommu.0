From: Benjamin Serebrin via iommu <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Subject: Re: [PATCH v3 7/7] iommu: introduce per-cpu caching to iova allocation
Date: Tue, 19 Apr 2016 13:50:58 -0700
Message-ID: <CAN+hb0V-=TTJj2oeH2vTfX__5RHMoKj+uh9_eE5FXzHubYP-Dg@mail.gmail.com>
References: <cover.1460733778.git.mad@cs.technion.ac.il>
	<0923752fb142601d6c2b58bcf7cdceea6ec9305e.1460733778.git.mad@cs.technion.ac.il>
Reply-To: Benjamin Serebrin <serebrin-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3344777097621181596=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <0923752fb142601d6c2b58bcf7cdceea6ec9305e.1460733778.git.mad-FrESSTt7Abv7r6psnUbsSmZHpeb/A1Y/@public.gmane.org>
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
Cc: Dan Tsafrir <dan-FrESSTt7Abv7r6psnUbsSmZHpeb/A1Y/@public.gmane.org>, Omer Peleg <omer-FrESSTt7Abv7r6psnUbsSmZHpeb/A1Y/@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Shaohua Li <shli-b10kYP2dOMg@public.gmane.org>, Godfrey van der Linden <gvdl-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Kernel-team-b10kYP2dOMg@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

--===============3344777097621181596==
Content-Type: multipart/alternative; boundary=001a11416d4060937c0530dca29b

--001a11416d4060937c0530dca29b
Content-Type: text/plain; charset=UTF-8

Thanks, Adam, looks very good!  One tiny nit inline below.



On Tue, Apr 19, 2016 at 9:49 AM, Adam Morrison <mad-FrESSTt7Abv7r6psnUbsSmZHpeb/A1Y/@public.gmane.org>
wrote:

> From: Omer Peleg <omer-FrESSTt7Abv7r6psnUbsSmZHpeb/A1Y/@public.gmane.org>
>
> IOVA allocation has two problems that impede high-throughput I/O.
> First, it can do a linear search over the allocated IOVA ranges.
> Second, the rbtree spinlock that serializes IOVA allocations becomes
> contended.
>
> Address these problems by creating an API for caching allocated IOVA
> ranges, so that the IOVA allocator isn't accessed frequently.  This
> patch adds a per-CPU cache, from which CPUs can alloc/free IOVAs
> without taking the rbtree spinlock.  The per-CPU caches are backed by
> a global cache, to avoid invoking the (linear-time) IOVA allocator
> without needing to make the per-CPU cache size excessive.  This design
> is based on magazines, as described in "Magazines and Vmem: Extending
> the Slab Allocator to Many CPUs and Arbitrary Resources" (currently
> available at https://www.usenix.org/legacy/event/usenix01/bonwick.html)
>
> Adding caching on top of the existing rbtree allocator maintains the
> property that IOVAs are densely packed in the IO virtual address space,
> which is important for keeping IOMMU page table usage low.
>
> To keep the cache size reasonable, we limit caching to ranges of
> size <= 128 KB.  Overall, a CPU can cache at most 32 MB and the global
> cache is bounded by 4 MB.
>
> Signed-off-by: Omer Peleg <omer-FrESSTt7Abv7r6psnUbsSmZHpeb/A1Y/@public.gmane.org>
> [mad-FrESSTt7Abv7r6psnUbsSmZHpeb/A1Y/@public.gmane.org: rebased, cleaned up and reworded the commit
> message]
> Signed-off-by: Adam Morrison <mad-FrESSTt7Abv7r6psnUbsSmZHpeb/A1Y/@public.gmane.org>
> ---
>  drivers/iommu/intel-iommu.c |  47 +++--
>  drivers/iommu/iova.c        | 416
> +++++++++++++++++++++++++++++++++++++++++---
>  include/linux/iova.h        |  23 ++-
>  3 files changed, 448 insertions(+), 38 deletions(-)
>
> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
> index 3c3ccd9..1f495dd 100644
> --- a/drivers/iommu/intel-iommu.c
> +++ b/drivers/iommu/intel-iommu.c
> @@ -3357,7 +3357,7 @@ static unsigned long intel_alloc_iova(struct device
> *dev,
>                                      struct dmar_domain *domain,
>                                      unsigned long nrpages, uint64_t
> dma_mask)
>  {
> -       struct iova *iova = NULL;
> +       unsigned long iova_pfn = 0;
>
>         /* Restrict dma_mask to the width that the iommu can handle */
>         dma_mask = min_t(uint64_t, DOMAIN_MAX_ADDR(domain->gaw), dma_mask);
> @@ -3370,19 +3370,19 @@ static unsigned long intel_alloc_iova(struct
> device *dev,
>                  * DMA_BIT_MASK(32) and if that fails then try allocating
>                  * from higher range
>                  */
> -               iova = alloc_iova(&domain->iovad, nrpages,
> -                                 IOVA_PFN(DMA_BIT_MASK(32)), 1);
> -               if (iova)
> -                       return iova->pfn_lo;
> +               iova_pfn = alloc_iova_fast(&domain->iovad, nrpages,
> +                                          IOVA_PFN(DMA_BIT_MASK(32)));
> +               if (iova_pfn)
> +                       return iova_pfn;
>         }
> -       iova = alloc_iova(&domain->iovad, nrpages, IOVA_PFN(dma_mask), 1);
> -       if (unlikely(!iova)) {
> +       iova_pfn = alloc_iova_fast(&domain->iovad, nrpages,
> IOVA_PFN(dma_mask));
> +       if (unlikely(!iova_pfn)) {
>                 pr_err("Allocating %ld-page iova for %s failed",
>                        nrpages, dev_name(dev));
>                 return 0;
>         }
>
> -       return iova->pfn_lo;
> +       return iova_pfn;
>  }
>
>  static struct dmar_domain *__get_valid_domain_for_dev(struct device *dev)
> @@ -3536,7 +3536,7 @@ static dma_addr_t __intel_map_single(struct device
> *dev, phys_addr_t paddr,
>
>  error:
>         if (iova_pfn)
> -               free_iova(&domain->iovad, iova_pfn);
> +               free_iova_fast(&domain->iovad, iova_pfn,
> dma_to_mm_pfn(size));
>         pr_err("Device %s request: %zx@%llx dir %d --- failed\n",
>                 dev_name(dev), size, (unsigned long long)paddr, dir);
>         return 0;
> @@ -3591,7 +3591,7 @@ static void flush_unmaps(struct deferred_flush_data
> *flush_data)
>                                 iommu_flush_dev_iotlb(domain,
>                                                 (uint64_t)iova_pfn <<
> PAGE_SHIFT, mask);
>                         }
> -                       free_iova(&domain->iovad, iova_pfn);
> +                       free_iova_fast(&domain->iovad, iova_pfn, nrpages);
>                         if (freelist)
>                                 dma_free_pagelist(freelist);
>                 }
> @@ -3691,7 +3691,7 @@ static void intel_unmap(struct device *dev,
> dma_addr_t dev_addr, size_t size)
>                 iommu_flush_iotlb_psi(iommu, domain, start_pfn,
>                                       nrpages, !freelist, 0);
>                 /* free iova */
> -               free_iova(&domain->iovad, iova_pfn);
> +               free_iova_fast(&domain->iovad, iova_pfn,
> dma_to_mm_pfn(nrpages));
>                 dma_free_pagelist(freelist);
>         } else {
>                 add_unmap(domain, iova_pfn, nrpages, freelist);
> @@ -3849,7 +3849,7 @@ static int intel_map_sg(struct device *dev, struct
> scatterlist *sglist, int nele
>         if (unlikely(ret)) {
>                 dma_pte_free_pagetable(domain, start_vpfn,
>                                        start_vpfn + size - 1);
> -               free_iova(&domain->iovad, iova_pfn);
> +               free_iova_fast(&domain->iovad, iova_pfn,
> dma_to_mm_pfn(size));
>                 return 0;
>         }
>
> @@ -4588,6 +4588,28 @@ static struct notifier_block intel_iommu_memory_nb
> = {
>         .priority = 0
>  };
>
> +static void free_all_cpu_cached_iovas(unsigned int cpu)
> +{
> +       int i;
> +
> +       for (i = 0; i < g_num_of_iommus; i++) {
> +               struct intel_iommu *iommu = g_iommus[i];
> +               struct dmar_domain *domain;
> +               u16 did;
> +
> +               if (!iommu)
> +                       continue;
> +
> +               for (did = 0; did < 0xffff; did++) {
> +                       domain = get_iommu_domain(iommu, did);
> +
> +                       if (!domain)
> +                               continue;
> +                       free_cpu_cached_iovas(cpu, &domain->iovad);
> +               }
> +       }
> +}
> +
>  static int intel_iommu_cpu_notifier(struct notifier_block *nfb,
>                                     unsigned long action, void *v)
>  {
> @@ -4596,6 +4618,7 @@ static int intel_iommu_cpu_notifier(struct
> notifier_block *nfb,
>         switch (action) {
>         case CPU_DEAD:
>         case CPU_DEAD_FROZEN:
> +               free_all_cpu_cached_iovas(cpu);
>                 flush_unmaps_timeout(cpu);
>                 break;
>         }
> diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
> index fa0adef..dbcb923 100644
> --- a/drivers/iommu/iova.c
> +++ b/drivers/iommu/iova.c
> @@ -20,6 +20,17 @@
>  #include <linux/iova.h>
>  #include <linux/module.h>
>  #include <linux/slab.h>
> +#include <linux/smp.h>
> +#include <linux/bitops.h>
> +
> +static bool iova_rcache_insert(struct iova_domain *iovad,
> +                              unsigned long pfn,
> +                              unsigned long size);
> +static unsigned long iova_rcache_get(struct iova_domain *iovad,
> +                                    unsigned long size,
> +                                    unsigned long limit_pfn);
> +static void init_iova_rcaches(struct iova_domain *iovad);
> +static void free_iova_rcaches(struct iova_domain *iovad);
>
>  void
>  init_iova_domain(struct iova_domain *iovad, unsigned long granule,
> @@ -38,6 +49,7 @@ init_iova_domain(struct iova_domain *iovad, unsigned
> long granule,
>         iovad->granule = granule;
>         iovad->start_pfn = start_pfn;
>         iovad->dma_32bit_pfn = pfn_32bit;
> +       init_iova_rcaches(iovad);
>  }
>  EXPORT_SYMBOL_GPL(init_iova_domain);
>
> @@ -291,33 +303,18 @@ alloc_iova(struct iova_domain *iovad, unsigned long
> size,
>  }
>  EXPORT_SYMBOL_GPL(alloc_iova);
>
> -/**
> - * find_iova - find's an iova for a given pfn
> - * @iovad: - iova domain in question.
> - * @pfn: - page frame number
> - * This function finds and returns an iova belonging to the
> - * given doamin which matches the given pfn.
> - */
> -struct iova *find_iova(struct iova_domain *iovad, unsigned long pfn)
> +static struct iova *
> +private_find_iova(struct iova_domain *iovad, unsigned long pfn)
>  {
> -       unsigned long flags;
> -       struct rb_node *node;
> +       struct rb_node *node = iovad->rbroot.rb_node;
> +
> +       assert_spin_locked(&iovad->iova_rbtree_lock);
>
> -       /* Take the lock so that no other thread is manipulating the
> rbtree */
> -       spin_lock_irqsave(&iovad->iova_rbtree_lock, flags);
> -       node = iovad->rbroot.rb_node;
>         while (node) {
>                 struct iova *iova = container_of(node, struct iova, node);
>
>                 /* If pfn falls within iova's range, return iova */
>                 if ((pfn >= iova->pfn_lo) && (pfn <= iova->pfn_hi)) {
> -                       spin_unlock_irqrestore(&iovad->iova_rbtree_lock,
> flags);
> -                       /* We are not holding the lock while this iova
> -                        * is referenced by the caller as the same thread
> -                        * which called this function also calls
> __free_iova()
> -                        * and it is by design that only one thread can
> possibly
> -                        * reference a particular iova and hence no
> conflict.
> -                        */
>                         return iova;
>                 }
>
> @@ -327,9 +324,35 @@ struct iova *find_iova(struct iova_domain *iovad,
> unsigned long pfn)
>                         node = node->rb_right;
>         }
>
> -       spin_unlock_irqrestore(&iovad->iova_rbtree_lock, flags);
>         return NULL;
>  }
> +
> +static void private_free_iova(struct iova_domain *iovad, struct iova
> *iova)
> +{
> +       assert_spin_locked(&iovad->iova_rbtree_lock);
> +       __cached_rbnode_delete_update(iovad, iova);
> +       rb_erase(&iova->node, &iovad->rbroot);
> +       free_iova_mem(iova);
> +}
> +
> +/**
> + * find_iova - finds an iova for a given pfn
> + * @iovad: - iova domain in question.
> + * @pfn: - page frame number
> + * This function finds and returns an iova belonging to the
> + * given doamin which matches the given pfn.
> + */
> +struct iova *find_iova(struct iova_domain *iovad, unsigned long pfn)
> +{
> +       unsigned long flags;
> +       struct iova *iova;
> +
> +       /* Take the lock so that no other thread is manipulating the
> rbtree */
> +       spin_lock_irqsave(&iovad->iova_rbtree_lock, flags);
> +       iova = private_find_iova(iovad, pfn);
> +       spin_unlock_irqrestore(&iovad->iova_rbtree_lock, flags);
> +       return iova;
> +}
>  EXPORT_SYMBOL_GPL(find_iova);
>
>  /**
> @@ -344,10 +367,8 @@ __free_iova(struct iova_domain *iovad, struct iova
> *iova)
>         unsigned long flags;
>
>         spin_lock_irqsave(&iovad->iova_rbtree_lock, flags);
> -       __cached_rbnode_delete_update(iovad, iova);
> -       rb_erase(&iova->node, &iovad->rbroot);
> +       private_free_iova(iovad, iova);
>         spin_unlock_irqrestore(&iovad->iova_rbtree_lock, flags);
> -       free_iova_mem(iova);
>  }
>  EXPORT_SYMBOL_GPL(__free_iova);
>
> @@ -370,6 +391,63 @@ free_iova(struct iova_domain *iovad, unsigned long
> pfn)
>  EXPORT_SYMBOL_GPL(free_iova);
>
>  /**
> + * alloc_iova_fast - allocates an iova from rcache
> + * @iovad: - iova domain in question
> + * @size: - size of page frames to allocate
> + * @limit_pfn: - max limit address
> + * This function tries to satisfy an iova allocation from the rcache,
> + * and falls back to regular allocation on failure.
> +*/
> +unsigned long
> +alloc_iova_fast(struct iova_domain *iovad, unsigned long size,
> +               unsigned long limit_pfn)
> +{
> +       bool flushed_rcache = false;
> +       unsigned long iova_pfn;
> +       struct iova *new_iova;
> +
> +       iova_pfn = iova_rcache_get(iovad, size, limit_pfn);
> +       if (iova_pfn)
> +               return iova_pfn;
> +
> +retry:
> +       new_iova = alloc_iova(iovad, size, limit_pfn, true);
> +       if (!new_iova) {
> +               unsigned int cpu;
> +
> +               if (flushed_rcache)
> +                       return 0;
> +
> +               /* Try replenishing IOVAs by flushing rcache. */
> +               flushed_rcache = true;
> +               for_each_online_cpu(cpu)
> +                       free_cpu_cached_iovas(cpu, iovad);
> +               goto retry;
> +       }
> +
> +       return new_iova->pfn_lo;
> +}
> +EXPORT_SYMBOL_GPL(alloc_iova_fast);
> +
> +/**
> + * free_iova_fast - free iova pfn range into rcache
> + * @iovad: - iova domain in question.
> + * @pfn: - pfn that is allocated previously
> + * @size: - # of pages in range
> + * This functions frees an iova range by trying to put it into the rcache,
> + * falling back to regular iova deallocation via free_iova() if this
> fails.
> + */
> +void
> +free_iova_fast(struct iova_domain *iovad, unsigned long pfn, unsigned
> long size)
> +{
> +       if (iova_rcache_insert(iovad, pfn, size))
> +               return;
> +
> +       free_iova(iovad, pfn);
> +}
> +EXPORT_SYMBOL_GPL(free_iova_fast);
> +
> +/**
>   * put_iova_domain - destroys the iova doamin
>   * @iovad: - iova domain in question.
>   * All the iova's in that domain are destroyed.
> @@ -379,6 +457,7 @@ void put_iova_domain(struct iova_domain *iovad)
>         struct rb_node *node;
>         unsigned long flags;
>
> +       free_iova_rcaches(iovad);
>         spin_lock_irqsave(&iovad->iova_rbtree_lock, flags);
>         node = rb_first(&iovad->rbroot);
>         while (node) {
> @@ -550,5 +629,294 @@ error:
>         return NULL;
>  }
>
> +/*
> + * Magazine caches for IOVA ranges.  For an introduction to magazines,
> + * see the USENIX 2001 paper "Magazines and Vmem: Extending the Slab
> + * Allocator to Many CPUs and Arbitrary Resources" by Bonwick and Adams.
> + * For simplicity, we use a static magazine size and don't implement the
> + * dynamic size tuning described in the paper.
> + */
> +
> +#define IOVA_MAG_SIZE 128
> +
> +struct iova_magazine {
> +       unsigned long size;
> +       unsigned long pfns[IOVA_MAG_SIZE];
> +};
> +
> +struct iova_cpu_rcache {
> +       spinlock_t lock;
> +       struct iova_magazine *loaded;
> +       struct iova_magazine *prev;
> +};
> +
> +static struct iova_magazine *iova_magazine_alloc(gfp_t flags)
> +{
> +       return kzalloc(sizeof(struct iova_magazine), flags);
> +}
> +
> +static void iova_magazine_free(struct iova_magazine *mag)
> +{
> +       kfree(mag);
> +}
> +
> +static void
> +iova_magazine_free_pfns(struct iova_magazine *mag, struct iova_domain
> *iovad)
> +{
> +       unsigned long flags;
> +       int i;
> +
> +       if (!mag)
> +               return;
> +
> +       spin_lock_irqsave(&iovad->iova_rbtree_lock, flags);
> +
> +       for (i = 0 ; i < mag->size; ++i) {
> +               struct iova *iova = private_find_iova(iovad, mag->pfns[i]);
> +
> +               BUG_ON(!iova);
> +               private_free_iova(iovad, iova);
> +       }
> +
> +       spin_unlock_irqrestore(&iovad->iova_rbtree_lock, flags);
> +
> +       mag->size = 0;
> +}
> +
> +static bool iova_magazine_full(struct iova_magazine *mag)
> +{
> +       return (mag && mag->size == IOVA_MAG_SIZE);
> +}
> +
> +static bool iova_magazine_empty(struct iova_magazine *mag)
> +{
> +       return (!mag || mag->size == 0);
> +}
> +
> +static unsigned long iova_magazine_pop(struct iova_magazine *mag,
> +                                      unsigned long limit_pfn)
> +{
> +       BUG_ON(iova_magazine_empty(mag));
> +
> +       if (mag->pfns[mag->size - 1] >= limit_pfn)
> +               return 0;
> +
> +       return mag->pfns[--mag->size];
> +}
> +
> +static void iova_magazine_push(struct iova_magazine *mag, unsigned long
> pfn)
> +{
> +       BUG_ON(iova_magazine_full(mag));
> +
> +       mag->pfns[mag->size++] = pfn;
> +}
> +
> +static void init_iova_rcaches(struct iova_domain *iovad)
> +{
> +       struct iova_cpu_rcache *cpu_rcache;
> +       struct iova_rcache *rcache;
> +       unsigned int cpu;
> +       int i;
> +
> +       for (i = 0; i < IOVA_RANGE_CACHE_MAX_SIZE; ++i) {
> +               rcache = &iovad->rcaches[i];
> +               spin_lock_init(&rcache->lock);
> +               rcache->depot_size = 0;
> +               rcache->cpu_rcaches = __alloc_percpu(sizeof(*cpu_rcache),
> cache_line_size());
> +               if (WARN_ON(!rcache->cpu_rcaches))
> +                       continue;
> +               for_each_possible_cpu(cpu) {
> +                       cpu_rcache = per_cpu_ptr(rcache->cpu_rcaches, cpu);
> +                       spin_lock_init(&cpu_rcache->lock);
> +                       cpu_rcache->loaded =
> iova_magazine_alloc(GFP_KERNEL);
> +                       cpu_rcache->prev = iova_magazine_alloc(GFP_KERNEL);
> +               }
> +       }
> +}
> +
> +/*
> + * Try inserting IOVA range starting with 'iova_pfn' into 'rcache', and
> + * return true on success.  Can fail if rcache is full and we can't free
> + * space, and free_iova() (our only caller) will then return the IOVA
> + * range to the rbtree instead.
> + */
> +static bool __iova_rcache_insert(struct iova_domain *iovad,
> +                                struct iova_rcache *rcache,
> +                                unsigned long iova_pfn)
> +{
> +       struct iova_magazine *mag_to_free = NULL;
> +       struct iova_cpu_rcache *cpu_rcache;
> +       bool can_insert = false;
> +       unsigned long flags;
> +
> +       cpu_rcache = this_cpu_ptr(rcache->cpu_rcaches);
> +       spin_lock_irqsave(&cpu_rcache->lock, flags);
> +
> +       if (!iova_magazine_full(cpu_rcache->loaded)) {
> +               can_insert = true;
> +       } else if (!iova_magazine_full(cpu_rcache->prev)) {
> +               swap(cpu_rcache->prev, cpu_rcache->loaded);
> +               can_insert = true;
> +       } else {
> +               struct iova_magazine *new_mag =
> iova_magazine_alloc(GFP_ATOMIC);
> +
> +               if (new_mag) {
> +                       spin_lock(&rcache->lock);
> +                       if (rcache->depot_size < MAX_GLOBAL_MAGS) {
> +                               rcache->depot[rcache->depot_size++] =
> +                                               cpu_rcache->loaded;
> +                       } else {
> +                               mag_to_free = cpu_rcache->loaded;
> +                       }
> +                       spin_unlock(&rcache->lock);
> +
> +                       cpu_rcache->loaded = new_mag;
> +                       can_insert = true;
> +               }
> +       }
> +
> +       if (can_insert)
> +               iova_magazine_push(cpu_rcache->loaded, iova_pfn);
> +
> +       spin_unlock_irqrestore(&cpu_rcache->lock, flags);
> +
> +       if (mag_to_free) {
> +               iova_magazine_free_pfns(mag_to_free, iovad);
> +               iova_magazine_free(mag_to_free);
> +       }
> +
> +       return can_insert;
> +}
> +
> +static bool iova_rcache_insert(struct iova_domain *iovad, unsigned long
> pfn,
> +                              unsigned long size)
> +{
> +       unsigned int log_size = order_base_2(size);
> +
> +       if (log_size >= IOVA_RANGE_CACHE_MAX_SIZE)
> +               return false;
> +
> +       return __iova_rcache_insert(iovad, &iovad->rcaches[log_size], pfn);
> +}
> +
> +/*
> + * Caller wants to allocate a new IOVA range from 'rcache'.  If we can
> + * satisfy the request, return a matching non-NULL range and remove
> + * it from the 'rcache'.
> + */
> +static unsigned long __iova_rcache_get(struct iova_rcache *rcache,
> +                                      unsigned long limit_pfn)
> +{
> +       struct iova_cpu_rcache *cpu_rcache;
> +       unsigned long iova_pfn = 0;
> +       bool has_pfn = false;
> +       unsigned long flags;
> +
> +       cpu_rcache = this_cpu_ptr(rcache->cpu_rcaches);
> +       spin_lock_irqsave(&cpu_rcache->lock, flags);
> +
> +       if (!iova_magazine_empty(cpu_rcache->loaded)) {
> +               has_pfn = true;
> +       } else if (!iova_magazine_empty(cpu_rcache->prev)) {
> +               swap(cpu_rcache->prev, cpu_rcache->loaded);
> +               has_pfn = true;
> +       } else {
> +               spin_lock(&rcache->lock);
> +               if (rcache->depot_size > 0) {
> +                       iova_magazine_free(cpu_rcache->loaded);
> +                       cpu_rcache->loaded =
> rcache->depot[--rcache->depot_size];
> +                       has_pfn = true;
> +               }
> +               spin_unlock(&rcache->lock);
> +       }
> +
> +       if (has_pfn)
> +               iova_pfn = iova_magazine_pop(cpu_rcache->loaded,
> limit_pfn);
> +
> +       spin_unlock_irqrestore(&cpu_rcache->lock, flags);
> +
> +       return iova_pfn;
> +}
> +
> +/*
> + * Try to satisfy IOVA allocation range from rcache.  Fail if requested
> + * size is too big or the DMA limit we are given isn't 32-bit or 64-bit.
> + */
>

 There's no code checking for 32- or 64-bit masks, so I think the comment
is misleading.  How about
"or the DMA limit we are given isn't satisfied by the first element of the
magazine"?

+static unsigned long iova_rcache_get(struct iova_domain *iovad,
> +                                    unsigned long size,
> +                                    unsigned long limit_pfn)
> +{
> +       unsigned int log_size = order_base_2(size);
> +
> +       if (log_size >= IOVA_RANGE_CACHE_MAX_SIZE)
> +               return 0;
> +
> +       return __iova_rcache_get(&iovad->rcaches[log_size], limit_pfn);
> +}
> +
> +/*
> + * Free a cpu's rcache.
> + */
> +static void free_cpu_iova_rcache(unsigned int cpu, struct iova_domain
> *iovad,
> +                                struct iova_rcache *rcache)
> +{
> +       struct iova_cpu_rcache *cpu_rcache =
> per_cpu_ptr(rcache->cpu_rcaches, cpu);
> +       unsigned long flags;
> +
> +       spin_lock_irqsave(&cpu_rcache->lock, flags);
> +
> +       iova_magazine_free_pfns(cpu_rcache->loaded, iovad);
> +       iova_magazine_free(cpu_rcache->loaded);
> +
> +       iova_magazine_free_pfns(cpu_rcache->prev, iovad);
> +       iova_magazine_free(cpu_rcache->prev);
> +
> +       spin_unlock_irqrestore(&cpu_rcache->lock, flags);
> +}
> +
> +/*
> + * free rcache data structures.
> + */
> +static void free_iova_rcaches(struct iova_domain *iovad)
> +{
> +       struct iova_rcache *rcache;
> +       unsigned long flags;
> +       unsigned int cpu;
> +       int i, j;
> +
> +       for (i = 0; i < IOVA_RANGE_CACHE_MAX_SIZE; ++i) {
> +               rcache = &iovad->rcaches[i];
> +               for_each_possible_cpu(cpu)
> +                       free_cpu_iova_rcache(cpu, iovad, rcache);
> +               spin_lock_irqsave(&rcache->lock, flags);
> +               free_percpu(rcache->cpu_rcaches);
> +               for (j = 0; j < rcache->depot_size; ++j) {
> +                       iova_magazine_free_pfns(rcache->depot[j], iovad);
> +                       iova_magazine_free(rcache->depot[j]);
> +               }
> +               spin_unlock_irqrestore(&rcache->lock, flags);
> +       }
> +}
> +
> +/*
> + * free all the IOVA ranges cached by a cpu (used when cpu is unplugged)
> + */
> +void free_cpu_cached_iovas(unsigned int cpu, struct iova_domain *iovad)
> +{
> +       struct iova_cpu_rcache *cpu_rcache;
> +       struct iova_rcache *rcache;
> +       unsigned long flags;
> +       int i;
> +
> +       for (i = 0; i < IOVA_RANGE_CACHE_MAX_SIZE; ++i) {
> +               rcache = &iovad->rcaches[i];
> +               cpu_rcache = per_cpu_ptr(rcache->cpu_rcaches, cpu);
> +               spin_lock_irqsave(&cpu_rcache->lock, flags);
> +               iova_magazine_free_pfns(cpu_rcache->loaded, iovad);
> +               iova_magazine_free_pfns(cpu_rcache->prev, iovad);
> +               spin_unlock_irqrestore(&cpu_rcache->lock, flags);
> +       }
> +}
> +
>  MODULE_AUTHOR("Anil S Keshavamurthy <anil.s.keshavamurthy-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>");
>  MODULE_LICENSE("GPL");
> diff --git a/include/linux/iova.h b/include/linux/iova.h
> index 92f7177..f27bb2c 100644
> --- a/include/linux/iova.h
> +++ b/include/linux/iova.h
> @@ -19,8 +19,21 @@
>  /* iova structure */
>  struct iova {
>         struct rb_node  node;
> -       unsigned long   pfn_hi; /* IOMMU dish out addr hi */
> -       unsigned long   pfn_lo; /* IOMMU dish out addr lo */
> +       unsigned long   pfn_hi; /* Highest allocated pfn */
> +       unsigned long   pfn_lo; /* Lowest allocated pfn */
> +};
> +
> +struct iova_magazine;
> +struct iova_cpu_rcache;
> +
> +#define IOVA_RANGE_CACHE_MAX_SIZE 6    /* log of max cached IOVA range
> size (in pages) */
> +#define MAX_GLOBAL_MAGS 32     /* magazines per bin */
> +
> +struct iova_rcache {
> +       spinlock_t lock;
> +       unsigned long depot_size;
> +       struct iova_magazine *depot[MAX_GLOBAL_MAGS];
> +       struct iova_cpu_rcache __percpu *cpu_rcaches;
>  };
>
>  /* holds all the iova translations for a domain */
> @@ -31,6 +44,7 @@ struct iova_domain {
>         unsigned long   granule;        /* pfn granularity for this domain
> */
>         unsigned long   start_pfn;      /* Lower limit for this domain */
>         unsigned long   dma_32bit_pfn;
> +       struct iova_rcache rcaches[IOVA_RANGE_CACHE_MAX_SIZE];  /* IOVA
> range caches */
>  };
>
>  static inline unsigned long iova_size(struct iova *iova)
> @@ -78,6 +92,10 @@ void __free_iova(struct iova_domain *iovad, struct iova
> *iova);
>  struct iova *alloc_iova(struct iova_domain *iovad, unsigned long size,
>         unsigned long limit_pfn,
>         bool size_aligned);
> +void free_iova_fast(struct iova_domain *iovad, unsigned long pfn,
> +                   unsigned long size);
> +unsigned long alloc_iova_fast(struct iova_domain *iovad, unsigned long
> size,
> +                             unsigned long limit_pfn);
>  struct iova *reserve_iova(struct iova_domain *iovad, unsigned long pfn_lo,
>         unsigned long pfn_hi);
>  void copy_reserved_iova(struct iova_domain *from, struct iova_domain *to);
> @@ -87,5 +105,6 @@ struct iova *find_iova(struct iova_domain *iovad,
> unsigned long pfn);
>  void put_iova_domain(struct iova_domain *iovad);
>  struct iova *split_and_remove_iova(struct iova_domain *iovad,
>         struct iova *iova, unsigned long pfn_lo, unsigned long pfn_hi);
> +void free_cpu_cached_iovas(unsigned int cpu, struct iova_domain *iovad);
>
>  #endif
> --
> 1.9.1
>
>

--001a11416d4060937c0530dca29b
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Thanks, Adam, looks very good!=C2=A0 One tiny nit inl=
ine below.</div><div><br></div><br><div class=3D"gmail_extra"><br><div clas=
s=3D"gmail_quote">On Tue, Apr 19, 2016 at 9:49 AM, Adam Morrison <span dir=
=3D"ltr">&lt;<a href=3D"mailto:mad-FrESSTt7Abv7r6psnUbsSmZHpeb/A1Y/@public.gmane.org">mad-FrESSTt7Abv7r6psnUbsSmZHpeb/A1Y/@public.gmane.org=
</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin=
:0px 0px 0px 0.8ex;border-left-width:1px;border-left-color:rgb(204,204,204)=
;border-left-style:solid;padding-left:1ex">From: Omer Peleg &lt;<a href=3D"=
mailto:omer-FrESSTt7Abv7r6psnUbsSmZHpeb/A1Y/@public.gmane.org">omer-FrESSTt7Abv7r6psnUbsSmZHpeb/A1Y/@public.gmane.org</a>&gt;<br>
<br>
IOVA allocation has two problems that impede high-throughput I/O.<br>
First, it can do a linear search over the allocated IOVA ranges.<br>
Second, the rbtree spinlock that serializes IOVA allocations becomes<br>
contended.<br>
<br>
Address these problems by creating an API for caching allocated IOVA<br>
ranges, so that the IOVA allocator isn&#39;t accessed frequently.=C2=A0 Thi=
s<br>
patch adds a per-CPU cache, from which CPUs can alloc/free IOVAs<br>
without taking the rbtree spinlock.=C2=A0 The per-CPU caches are backed by<=
br>
a global cache, to avoid invoking the (linear-time) IOVA allocator<br>
without needing to make the per-CPU cache size excessive.=C2=A0 This design=
<br>
is based on magazines, as described in &quot;Magazines and Vmem: Extending<=
br>
the Slab Allocator to Many CPUs and Arbitrary Resources&quot; (currently<br=
>
available at <a href=3D"https://www.usenix.org/legacy/event/usenix01/bonwic=
k.html" rel=3D"noreferrer">https://www.usenix.org/legacy/event/usenix01/bon=
wick.html</a>)<br>
<br>
Adding caching on top of the existing rbtree allocator maintains the<br>
property that IOVAs are densely packed in the IO virtual address space,<br>
which is important for keeping IOMMU page table usage low.<br>
<br>
To keep the cache size reasonable, we limit caching to ranges of<br>
size &lt;=3D 128 KB.=C2=A0 Overall, a CPU can cache at most 32 MB and the g=
lobal<br>
cache is bounded by 4 MB.<br>
<br>
Signed-off-by: Omer Peleg &lt;<a href=3D"mailto:omer-FrESSTt7Abv7r6psnUbsSmZHpeb/A1Y/@public.gmane.org">ome=
r@cs.technion.ac.il</a>&gt;<br>
[<a href=3D"mailto:mad-FrESSTt7Abv7r6psnUbsSmZHpeb/A1Y/@public.gmane.org">mad-FrESSTt7Abv7r6psnUbsSmZHpeb/A1Y/@public.gmane.org</a>: rebase=
d, cleaned up and reworded the commit message]<br>
Signed-off-by: Adam Morrison &lt;<a href=3D"mailto:mad-FrESSTt7Abv7r6psnUbsSmZHpeb/A1Y/@public.gmane.org">m=
ad-FrESSTt7Abv7r6psnUbsSmZHpeb/A1Y/@public.gmane.org</a>&gt;<br>
---<br>
=C2=A0drivers/iommu/intel-iommu.c |=C2=A0 47 +++--<br>
=C2=A0drivers/iommu/iova.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 | 416 +++++++++++++++=
++++++++++++++++++++++++++---<br>
=C2=A0include/linux/iova.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 23 ++-<br>
=C2=A03 files changed, 448 insertions(+), 38 deletions(-)<br>
<br>
diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c<br>
index 3c3ccd9..1f495dd 100644<br>
--- a/drivers/iommu/intel-iommu.c<br>
+++ b/drivers/iommu/intel-iommu.c<br>
@@ -3357,7 +3357,7 @@ static unsigned long intel_alloc_iova(struct device *=
dev,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct dmar_doma=
in *domain,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned long nr=
pages, uint64_t dma_mask)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0struct iova *iova =3D NULL;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned long iova_pfn =3D 0;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Restrict dma_mask to the width that the iomm=
u can handle */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 dma_mask =3D min_t(uint64_t, DOMAIN_MAX_ADDR(do=
main-&gt;gaw), dma_mask);<br>
@@ -3370,19 +3370,19 @@ static unsigned long intel_alloc_iova(struct device=
 *dev,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* DMA_BIT_MAS=
K(32) and if that fails then try allocating<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* from higher=
 range<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0iova =3D alloc_iova=
(&amp;domain-&gt;iovad, nrpages,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0IOVA_PFN(DMA_BIT_MASK(32)), 1)=
;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (iova)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0return iova-&gt;pfn_lo;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0iova_pfn =3D alloc_=
iova_fast(&amp;domain-&gt;iovad, nrpages,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 I=
OVA_PFN(DMA_BIT_MASK(32)));<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (iova_pfn)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0return iova_pfn;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0iova =3D alloc_iova(&amp;domain-&gt;iovad, nrpa=
ges, IOVA_PFN(dma_mask), 1);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if (unlikely(!iova)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0iova_pfn =3D alloc_iova_fast(&amp;domain-&gt;io=
vad, nrpages, IOVA_PFN(dma_mask));<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (unlikely(!iova_pfn)) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pr_err(&quot;Alloca=
ting %ld-page iova for %s failed&quot;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0nrpages, dev_name(dev));<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0return iova-&gt;pfn_lo;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0return iova_pfn;<br>
=C2=A0}<br>
<br>
=C2=A0static struct dmar_domain *__get_valid_domain_for_dev(struct device *=
dev)<br>
@@ -3536,7 +3536,7 @@ static dma_addr_t __intel_map_single(struct device *d=
ev, phys_addr_t paddr,<br>
<br>
=C2=A0error:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (iova_pfn)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0free_iova(&amp;doma=
in-&gt;iovad, iova_pfn);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0free_iova_fast(&amp=
;domain-&gt;iovad, iova_pfn, dma_to_mm_pfn(size));<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 pr_err(&quot;Device %s request: %zx@%llx dir %d=
 --- failed\n&quot;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_name(dev), size=
, (unsigned long long)paddr, dir);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;<br>
@@ -3591,7 +3591,7 @@ static void flush_unmaps(struct deferred_flush_data *=
flush_data)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 iommu_flush_dev_iotlb(domain,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 (uint64_t)iova_pfn &lt;&lt; PAGE_SHIFT, mask);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 }<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0free_iova(&amp;domain-&gt;iovad, iova_pfn);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0free_iova_fast(&amp;domain-&gt;iovad, iova_pfn, nrpages);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 if (freelist)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dma_free_pagelist(freelist);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
@@ -3691,7 +3691,7 @@ static void intel_unmap(struct device *dev, dma_addr_=
t dev_addr, size_t size)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 iommu_flush_iotlb_p=
si(iommu, domain, start_pfn,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 nrpages, !freel=
ist, 0);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* free iova */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0free_iova(&amp;doma=
in-&gt;iovad, iova_pfn);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0free_iova_fast(&amp=
;domain-&gt;iovad, iova_pfn, dma_to_mm_pfn(nrpages));<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dma_free_pagelist(f=
reelist);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 add_unmap(domain, i=
ova_pfn, nrpages, freelist);<br>
@@ -3849,7 +3849,7 @@ static int intel_map_sg(struct device *dev, struct sc=
atterlist *sglist, int nele<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (unlikely(ret)) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dma_pte_free_pageta=
ble(domain, start_vpfn,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0start_vpf=
n + size - 1);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0free_iova(&amp;doma=
in-&gt;iovad, iova_pfn);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0free_iova_fast(&amp=
;domain-&gt;iovad, iova_pfn, dma_to_mm_pfn(size));<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
<br>
@@ -4588,6 +4588,28 @@ static struct notifier_block intel_iommu_memory_nb =
=3D {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 .priority =3D 0<br>
=C2=A0};<br>
<br>
+static void free_all_cpu_cached_iovas(unsigned int cpu)<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0int i;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0for (i =3D 0; i &lt; g_num_of_iommus; i++) {<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct intel_iommu =
*iommu =3D g_iommus[i];<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct dmar_domain =
*domain;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0u16 did;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!iommu)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0continue;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0for (did =3D 0; did=
 &lt; 0xffff; did++) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0domain =3D get_iommu_domain(iommu, did);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0if (!domain)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0continue;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0free_cpu_cached_iovas(cpu, &amp;domain-&gt;iovad);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+}<br>
+<br>
=C2=A0static int intel_iommu_cpu_notifier(struct notifier_block *nfb,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned long action, =
void *v)<br>
=C2=A0{<br>
@@ -4596,6 +4618,7 @@ static int intel_iommu_cpu_notifier(struct notifier_b=
lock *nfb,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 switch (action) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 case CPU_DEAD:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 case CPU_DEAD_FROZEN:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0free_all_cpu_cached=
_iovas(cpu);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 flush_unmaps_timeou=
t(cpu);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c<br>
index fa0adef..dbcb923 100644<br>
--- a/drivers/iommu/iova.c<br>
+++ b/drivers/iommu/iova.c<br>
@@ -20,6 +20,17 @@<br>
=C2=A0#include &lt;linux/iova.h&gt;<br>
=C2=A0#include &lt;linux/module.h&gt;<br>
=C2=A0#include &lt;linux/slab.h&gt;<br>
+#include &lt;linux/smp.h&gt;<br>
+#include &lt;linux/bitops.h&gt;<br>
+<br>
+static bool iova_rcache_insert(struct iova_domain *iovad,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned long pfn,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned long size);<br>
+static unsigned long iova_rcache_get(struct iova_domain *iovad,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned long size,<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned long limit_pf=
n);<br>
+static void init_iova_rcaches(struct iova_domain *iovad);<br>
+static void free_iova_rcaches(struct iova_domain *iovad);<br>
<br>
=C2=A0void<br>
=C2=A0init_iova_domain(struct iova_domain *iovad, unsigned long granule,<br=
>
@@ -38,6 +49,7 @@ init_iova_domain(struct iova_domain *iovad, unsigned long=
 granule,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 iovad-&gt;granule =3D granule;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 iovad-&gt;start_pfn =3D start_pfn;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 iovad-&gt;dma_32bit_pfn =3D pfn_32bit;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0init_iova_rcaches(iovad);<br>
=C2=A0}<br>
=C2=A0EXPORT_SYMBOL_GPL(init_iova_domain);<br>
<br>
@@ -291,33 +303,18 @@ alloc_iova(struct iova_domain *iovad, unsigned long s=
ize,<br>
=C2=A0}<br>
=C2=A0EXPORT_SYMBOL_GPL(alloc_iova);<br>
<br>
-/**<br>
- * find_iova - find&#39;s an iova for a given pfn<br>
- * @iovad: - iova domain in question.<br>
- * @pfn: - page frame number<br>
- * This function finds and returns an iova belonging to the<br>
- * given doamin which matches the given pfn.<br>
- */<br>
-struct iova *find_iova(struct iova_domain *iovad, unsigned long pfn)<br>
+static struct iova *<br>
+private_find_iova(struct iova_domain *iovad, unsigned long pfn)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned long flags;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0struct rb_node *node;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct rb_node *node =3D iovad-&gt;rbroot.rb_no=
de;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0assert_spin_locked(&amp;iovad-&gt;iova_rbtree_l=
ock);<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0/* Take the lock so that no other thread is man=
ipulating the rbtree */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0spin_lock_irqsave(&amp;iovad-&gt;iova_rbtree_lo=
ck, flags);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0node =3D iovad-&gt;rbroot.rb_node;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 while (node) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct iova *iova =
=3D container_of(node, struct iova, node);<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* If pfn falls wit=
hin iova&#39;s range, return iova */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if ((pfn &gt;=3D io=
va-&gt;pfn_lo) &amp;&amp; (pfn &lt;=3D iova-&gt;pfn_hi)) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0spin_unlock_irqrestore(&amp;iovad-&gt;iova_rbtree_lock, flags);<b=
r>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0/* We are not holding the lock while this iova<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 * is referenced by the caller as the same thread<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 * which called this function also calls __free_iova()<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 * and it is by design that only one thread can possibly<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 * reference a particular iova and hence no conflict.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 return iova;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
<br>
@@ -327,9 +324,35 @@ struct iova *find_iova(struct iova_domain *iovad, unsi=
gned long pfn)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 node =3D node-&gt;rb_right;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0spin_unlock_irqrestore(&amp;iovad-&gt;iova_rbtr=
ee_lock, flags);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 return NULL;<br>
=C2=A0}<br>
+<br>
+static void private_free_iova(struct iova_domain *iovad, struct iova *iova=
)<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0assert_spin_locked(&amp;iovad-&gt;iova_rbtree_l=
ock);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0__cached_rbnode_delete_update(iovad, iova);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0rb_erase(&amp;iova-&gt;node, &amp;iovad-&gt;rbr=
oot);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0free_iova_mem(iova);<br>
+}<br>
+<br>
+/**<br>
+ * find_iova - finds an iova for a given pfn<br>
+ * @iovad: - iova domain in question.<br>
+ * @pfn: - page frame number<br>
+ * This function finds and returns an iova belonging to the<br>
+ * given doamin which matches the given pfn.<br>
+ */<br>
+struct iova *find_iova(struct iova_domain *iovad, unsigned long pfn)<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned long flags;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct iova *iova;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0/* Take the lock so that no other thread is man=
ipulating the rbtree */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0spin_lock_irqsave(&amp;iovad-&gt;iova_rbtree_lo=
ck, flags);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0iova =3D private_find_iova(iovad, pfn);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0spin_unlock_irqrestore(&amp;iovad-&gt;iova_rbtr=
ee_lock, flags);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0return iova;<br>
+}<br>
=C2=A0EXPORT_SYMBOL_GPL(find_iova);<br>
<br>
=C2=A0/**<br>
@@ -344,10 +367,8 @@ __free_iova(struct iova_domain *iovad, struct iova *io=
va)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned long flags;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 spin_lock_irqsave(&amp;iovad-&gt;iova_rbtree_lo=
ck, flags);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0__cached_rbnode_delete_update(iovad, iova);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0rb_erase(&amp;iova-&gt;node, &amp;iovad-&gt;rbr=
oot);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0private_free_iova(iovad, iova);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 spin_unlock_irqrestore(&amp;iovad-&gt;iova_rbtr=
ee_lock, flags);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0free_iova_mem(iova);<br>
=C2=A0}<br>
=C2=A0EXPORT_SYMBOL_GPL(__free_iova);<br>
<br>
@@ -370,6 +391,63 @@ free_iova(struct iova_domain *iovad, unsigned long pfn=
)<br>
=C2=A0EXPORT_SYMBOL_GPL(free_iova);<br>
<br>
=C2=A0/**<br>
+ * alloc_iova_fast - allocates an iova from rcache<br>
+ * @iovad: - iova domain in question<br>
+ * @size: - size of page frames to allocate<br>
+ * @limit_pfn: - max limit address<br>
+ * This function tries to satisfy an iova allocation from the rcache,<br>
+ * and falls back to regular allocation on failure.<br>
+*/<br>
+unsigned long<br>
+alloc_iova_fast(struct iova_domain *iovad, unsigned long size,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned long limit=
_pfn)<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0bool flushed_rcache =3D false;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned long iova_pfn;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct iova *new_iova;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0iova_pfn =3D iova_rcache_get(iovad, size, limit=
_pfn);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (iova_pfn)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return iova_pfn;<br=
>
+<br>
+retry:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0new_iova =3D alloc_iova(iovad, size, limit_pfn,=
 true);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!new_iova) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned int cpu;<b=
r>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (flushed_rcache)=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0return 0;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Try replenishing=
 IOVAs by flushing rcache. */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0flushed_rcache =3D =
true;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0for_each_online_cpu=
(cpu)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0free_cpu_cached_iovas(cpu, iovad);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto retry;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0return new_iova-&gt;pfn_lo;<br>
+}<br>
+EXPORT_SYMBOL_GPL(alloc_iova_fast);<br>
+<br>
+/**<br>
+ * free_iova_fast - free iova pfn range into rcache<br>
+ * @iovad: - iova domain in question.<br>
+ * @pfn: - pfn that is allocated previously<br>
+ * @size: - # of pages in range<br>
+ * This functions frees an iova range by trying to put it into the rcache,=
<br>
+ * falling back to regular iova deallocation via free_iova() if this fails=
.<br>
+ */<br>
+void<br>
+free_iova_fast(struct iova_domain *iovad, unsigned long pfn, unsigned long=
 size)<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (iova_rcache_insert(iovad, pfn, size))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0free_iova(iovad, pfn);<br>
+}<br>
+EXPORT_SYMBOL_GPL(free_iova_fast);<br>
+<br>
+/**<br>
=C2=A0 * put_iova_domain - destroys the iova doamin<br>
=C2=A0 * @iovad: - iova domain in question.<br>
=C2=A0 * All the iova&#39;s in that domain are destroyed.<br>
@@ -379,6 +457,7 @@ void put_iova_domain(struct iova_domain *iovad)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct rb_node *node;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned long flags;<br>
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0free_iova_rcaches(iovad);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 spin_lock_irqsave(&amp;iovad-&gt;iova_rbtree_lo=
ck, flags);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 node =3D rb_first(&amp;iovad-&gt;rbroot);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 while (node) {<br>
@@ -550,5 +629,294 @@ error:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 return NULL;<br>
=C2=A0}<br>
<br>
+/*<br>
+ * Magazine caches for IOVA ranges.=C2=A0 For an introduction to magazines=
,<br>
+ * see the USENIX 2001 paper &quot;Magazines and Vmem: Extending the Slab<=
br>
+ * Allocator to Many CPUs and Arbitrary Resources&quot; by Bonwick and Ada=
ms.<br>
+ * For simplicity, we use a static magazine size and don&#39;t implement t=
he<br>
+ * dynamic size tuning described in the paper.<br>
+ */<br>
+<br>
+#define IOVA_MAG_SIZE 128<br>
+<br>
+struct iova_magazine {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned long size;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned long pfns[IOVA_MAG_SIZE];<br>
+};<br>
+<br>
+struct iova_cpu_rcache {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0spinlock_t lock;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct iova_magazine *loaded;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct iova_magazine *prev;<br>
+};<br>
+<br>
+static struct iova_magazine *iova_magazine_alloc(gfp_t flags)<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0return kzalloc(sizeof(struct iova_magazine), fl=
ags);<br>
+}<br>
+<br>
+static void iova_magazine_free(struct iova_magazine *mag)<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0kfree(mag);<br>
+}<br>
+<br>
+static void<br>
+iova_magazine_free_pfns(struct iova_magazine *mag, struct iova_domain *iov=
ad)<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned long flags;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0int i;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!mag)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0spin_lock_irqsave(&amp;iovad-&gt;iova_rbtree_lo=
ck, flags);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0for (i =3D 0 ; i &lt; mag-&gt;size; ++i) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct iova *iova =
=3D private_find_iova(iovad, mag-&gt;pfns[i]);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0BUG_ON(!iova);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0private_free_iova(i=
ovad, iova);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0spin_unlock_irqrestore(&amp;iovad-&gt;iova_rbtr=
ee_lock, flags);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0mag-&gt;size =3D 0;<br>
+}<br>
+<br>
+static bool iova_magazine_full(struct iova_magazine *mag)<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0return (mag &amp;&amp; mag-&gt;size =3D=3D IOVA=
_MAG_SIZE);<br>
+}<br>
+<br>
+static bool iova_magazine_empty(struct iova_magazine *mag)<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0return (!mag || mag-&gt;size =3D=3D 0);<br>
+}<br>
+<br>
+static unsigned long iova_magazine_pop(struct iova_magazine *mag,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned long l=
imit_pfn)<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0BUG_ON(iova_magazine_empty(mag));<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (mag-&gt;pfns[mag-&gt;size - 1] &gt;=3D limi=
t_pfn)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0return mag-&gt;pfns[--mag-&gt;size];<br>
+}<br>
+<br>
+static void iova_magazine_push(struct iova_magazine *mag, unsigned long pf=
n)<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0BUG_ON(iova_magazine_full(mag));<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0mag-&gt;pfns[mag-&gt;size++] =3D pfn;<br>
+}<br>
+<br>
+static void init_iova_rcaches(struct iova_domain *iovad)<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct iova_cpu_rcache *cpu_rcache;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct iova_rcache *rcache;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned int cpu;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0int i;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0for (i =3D 0; i &lt; IOVA_RANGE_CACHE_MAX_SIZE;=
 ++i) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rcache =3D &amp;iov=
ad-&gt;rcaches[i];<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0spin_lock_init(&amp=
;rcache-&gt;lock);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rcache-&gt;depot_si=
ze =3D 0;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rcache-&gt;cpu_rcac=
hes =3D __alloc_percpu(sizeof(*cpu_rcache), cache_line_size());<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (WARN_ON(!rcache=
-&gt;cpu_rcaches))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0continue;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0for_each_possible_c=
pu(cpu) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0cpu_rcache =3D per_cpu_ptr(rcache-&gt;cpu_rcaches, cpu);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0spin_lock_init(&amp;cpu_rcache-&gt;lock);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0cpu_rcache-&gt;loaded =3D iova_magazine_alloc(GFP_KERNEL);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0cpu_rcache-&gt;prev =3D iova_magazine_alloc(GFP_KERNEL);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+}<br>
+<br>
+/*<br>
+ * Try inserting IOVA range starting with &#39;iova_pfn&#39; into &#39;rca=
che&#39;, and<br>
+ * return true on success.=C2=A0 Can fail if rcache is full and we can&#39=
;t free<br>
+ * space, and free_iova() (our only caller) will then return the IOVA<br>
+ * range to the rbtree instead.<br>
+ */<br>
+static bool __iova_rcache_insert(struct iova_domain *iovad,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct iova_rcache *rcache,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned long iova_pfn)<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct iova_magazine *mag_to_free =3D NULL;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct iova_cpu_rcache *cpu_rcache;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0bool can_insert =3D false;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned long flags;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0cpu_rcache =3D this_cpu_ptr(rcache-&gt;cpu_rcac=
hes);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0spin_lock_irqsave(&amp;cpu_rcache-&gt;lock, fla=
gs);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!iova_magazine_full(cpu_rcache-&gt;loaded))=
 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0can_insert =3D true=
;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0} else if (!iova_magazine_full(cpu_rcache-&gt;p=
rev)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0swap(cpu_rcache-&gt=
;prev, cpu_rcache-&gt;loaded);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0can_insert =3D true=
;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0} else {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct iova_magazin=
e *new_mag =3D iova_magazine_alloc(GFP_ATOMIC);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (new_mag) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0spin_lock(&amp;rcache-&gt;lock);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0if (rcache-&gt;depot_size &lt; MAX_GLOBAL_MAGS) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rcache-&gt;depot[rcache-&gt;depot_siz=
e++] =3D<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0cpu_rcache-&gt;loaded;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0} else {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0mag_to_free =3D cpu_rcache-&gt;loaded=
;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0}<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0spin_unlock(&amp;rcache-&gt;lock);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0cpu_rcache-&gt;loaded =3D new_mag;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0can_insert =3D true;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (can_insert)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0iova_magazine_push(=
cpu_rcache-&gt;loaded, iova_pfn);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0spin_unlock_irqrestore(&amp;cpu_rcache-&gt;lock=
, flags);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (mag_to_free) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0iova_magazine_free_=
pfns(mag_to_free, iovad);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0iova_magazine_free(=
mag_to_free);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0return can_insert;<br>
+}<br>
+<br>
+static bool iova_rcache_insert(struct iova_domain *iovad, unsigned long pf=
n,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned long size)<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned int log_size =3D order_base_2(size);<b=
r>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (log_size &gt;=3D IOVA_RANGE_CACHE_MAX_SIZE)=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return false;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0return __iova_rcache_insert(iovad, &amp;iovad-&=
gt;rcaches[log_size], pfn);<br>
+}<br>
+<br>
+/*<br>
+ * Caller wants to allocate a new IOVA range from &#39;rcache&#39;.=C2=A0 =
If we can<br>
+ * satisfy the request, return a matching non-NULL range and remove<br>
+ * it from the &#39;rcache&#39;.<br>
+ */<br>
+static unsigned long __iova_rcache_get(struct iova_rcache *rcache,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned long l=
imit_pfn)<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct iova_cpu_rcache *cpu_rcache;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned long iova_pfn =3D 0;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0bool has_pfn =3D false;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned long flags;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0cpu_rcache =3D this_cpu_ptr(rcache-&gt;cpu_rcac=
hes);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0spin_lock_irqsave(&amp;cpu_rcache-&gt;lock, fla=
gs);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!iova_magazine_empty(cpu_rcache-&gt;loaded)=
) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0has_pfn =3D true;<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0} else if (!iova_magazine_empty(cpu_rcache-&gt;=
prev)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0swap(cpu_rcache-&gt=
;prev, cpu_rcache-&gt;loaded);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0has_pfn =3D true;<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0} else {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0spin_lock(&amp;rcac=
he-&gt;lock);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (rcache-&gt;depo=
t_size &gt; 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0iova_magazine_free(cpu_rcache-&gt;loaded);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0cpu_rcache-&gt;loaded =3D rcache-&gt;depot[--rcache-&gt;depot_siz=
e];<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0has_pfn =3D true;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0spin_unlock(&amp;rc=
ache-&gt;lock);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (has_pfn)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0iova_pfn =3D iova_m=
agazine_pop(cpu_rcache-&gt;loaded, limit_pfn);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0spin_unlock_irqrestore(&amp;cpu_rcache-&gt;lock=
, flags);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0return iova_pfn;<br>
+}<br>
+<br>
+/*<br>
+ * Try to satisfy IOVA allocation range from rcache.=C2=A0 Fail if request=
ed<br>
+ * size is too big or the DMA limit we are given isn&#39;t 32-bit or 64-bi=
t.<br>
+ */<br></blockquote><div><br></div><div>=C2=A0There&#39;s no code checking=
 for 32- or 64-bit masks, so I think the comment is misleading.=C2=A0 How a=
bout</div><div>&quot;or the DMA limit we are given isn&#39;t satisfied by t=
he first element of the magazine&quot;?</div><div><br></div><blockquote cla=
ss=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;=
border-left-color:rgb(204,204,204);border-left-style:solid;padding-left:1ex=
">
+static unsigned long iova_rcache_get(struct iova_domain *iovad,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned long size,<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned long limit_pf=
n)<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned int log_size =3D order_base_2(size);<b=
r>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (log_size &gt;=3D IOVA_RANGE_CACHE_MAX_SIZE)=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0return __iova_rcache_get(&amp;iovad-&gt;rcaches=
[log_size], limit_pfn);<br>
+}<br>
+<br>
+/*<br>
+ * Free a cpu&#39;s rcache.<br>
+ */<br>
+static void free_cpu_iova_rcache(unsigned int cpu, struct iova_domain *iov=
ad,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct iova_rcache *rcache)<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct iova_cpu_rcache *cpu_rcache =3D per_cpu_=
ptr(rcache-&gt;cpu_rcaches, cpu);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned long flags;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0spin_lock_irqsave(&amp;cpu_rcache-&gt;lock, fla=
gs);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0iova_magazine_free_pfns(cpu_rcache-&gt;loaded, =
iovad);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0iova_magazine_free(cpu_rcache-&gt;loaded);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0iova_magazine_free_pfns(cpu_rcache-&gt;prev, io=
vad);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0iova_magazine_free(cpu_rcache-&gt;prev);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0spin_unlock_irqrestore(&amp;cpu_rcache-&gt;lock=
, flags);<br>
+}<br>
+<br>
+/*<br>
+ * free rcache data structures.<br>
+ */<br>
+static void free_iova_rcaches(struct iova_domain *iovad)<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct iova_rcache *rcache;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned long flags;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned int cpu;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0int i, j;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0for (i =3D 0; i &lt; IOVA_RANGE_CACHE_MAX_SIZE;=
 ++i) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rcache =3D &amp;iov=
ad-&gt;rcaches[i];<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0for_each_possible_c=
pu(cpu)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0free_cpu_iova_rcache(cpu, iovad, rcache);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0spin_lock_irqsave(&=
amp;rcache-&gt;lock, flags);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0free_percpu(rcache-=
&gt;cpu_rcaches);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0for (j =3D 0; j &lt=
; rcache-&gt;depot_size; ++j) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0iova_magazine_free_pfns(rcache-&gt;depot[j], iovad);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0iova_magazine_free(rcache-&gt;depot[j]);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0spin_unlock_irqrest=
ore(&amp;rcache-&gt;lock, flags);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+}<br>
+<br>
+/*<br>
+ * free all the IOVA ranges cached by a cpu (used when cpu is unplugged)<b=
r>
+ */<br>
+void free_cpu_cached_iovas(unsigned int cpu, struct iova_domain *iovad)<br=
>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct iova_cpu_rcache *cpu_rcache;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct iova_rcache *rcache;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned long flags;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0int i;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0for (i =3D 0; i &lt; IOVA_RANGE_CACHE_MAX_SIZE;=
 ++i) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rcache =3D &amp;iov=
ad-&gt;rcaches[i];<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cpu_rcache =3D per_=
cpu_ptr(rcache-&gt;cpu_rcaches, cpu);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0spin_lock_irqsave(&=
amp;cpu_rcache-&gt;lock, flags);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0iova_magazine_free_=
pfns(cpu_rcache-&gt;loaded, iovad);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0iova_magazine_free_=
pfns(cpu_rcache-&gt;prev, iovad);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0spin_unlock_irqrest=
ore(&amp;cpu_rcache-&gt;lock, flags);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+}<br>
+<br>
=C2=A0MODULE_AUTHOR(&quot;Anil S Keshavamurthy &lt;<a href=3D"mailto:anil.s=
.keshavamurthy-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org">anil.s.keshavamurthy-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org</a>&gt;&quot;);<br=
>
=C2=A0MODULE_LICENSE(&quot;GPL&quot;);<br>
diff --git a/include/linux/iova.h b/include/linux/iova.h<br>
index 92f7177..f27bb2c 100644<br>
--- a/include/linux/iova.h<br>
+++ b/include/linux/iova.h<br>
@@ -19,8 +19,21 @@<br>
=C2=A0/* iova structure */<br>
=C2=A0struct iova {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct rb_node=C2=A0 node;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned long=C2=A0 =C2=A0pfn_hi; /* IOMMU dish=
 out addr hi */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned long=C2=A0 =C2=A0pfn_lo; /* IOMMU dish=
 out addr lo */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned long=C2=A0 =C2=A0pfn_hi; /* Highest al=
located pfn */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned long=C2=A0 =C2=A0pfn_lo; /* Lowest all=
ocated pfn */<br>
+};<br>
+<br>
+struct iova_magazine;<br>
+struct iova_cpu_rcache;<br>
+<br>
+#define IOVA_RANGE_CACHE_MAX_SIZE 6=C2=A0 =C2=A0 /* log of max cached IOVA=
 range size (in pages) */<br>
+#define MAX_GLOBAL_MAGS 32=C2=A0 =C2=A0 =C2=A0/* magazines per bin */<br>
+<br>
+struct iova_rcache {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0spinlock_t lock;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned long depot_size;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct iova_magazine *depot[MAX_GLOBAL_MAGS];<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct iova_cpu_rcache __percpu *cpu_rcaches;<b=
r>
=C2=A0};<br>
<br>
=C2=A0/* holds all the iova translations for a domain */<br>
@@ -31,6 +44,7 @@ struct iova_domain {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned long=C2=A0 =C2=A0granule;=C2=A0 =C2=A0=
 =C2=A0 =C2=A0 /* pfn granularity for this domain */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned long=C2=A0 =C2=A0start_pfn;=C2=A0 =C2=
=A0 =C2=A0 /* Lower limit for this domain */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned long=C2=A0 =C2=A0dma_32bit_pfn;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct iova_rcache rcaches[IOVA_RANGE_CACHE_MAX=
_SIZE];=C2=A0 /* IOVA range caches */<br>
=C2=A0};<br>
<br>
=C2=A0static inline unsigned long iova_size(struct iova *iova)<br>
@@ -78,6 +92,10 @@ void __free_iova(struct iova_domain *iovad, struct iova =
*iova);<br>
=C2=A0struct iova *alloc_iova(struct iova_domain *iovad, unsigned long size=
,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned long limit_pfn,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 bool size_aligned);<br>
+void free_iova_fast(struct iova_domain *iovad, unsigned long pfn,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0unsig=
ned long size);<br>
+unsigned long alloc_iova_fast(struct iova_domain *iovad, unsigned long siz=
e,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned long limit_pfn);<br>
=C2=A0struct iova *reserve_iova(struct iova_domain *iovad, unsigned long pf=
n_lo,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned long pfn_hi);<br>
=C2=A0void copy_reserved_iova(struct iova_domain *from, struct iova_domain =
*to);<br>
@@ -87,5 +105,6 @@ struct iova *find_iova(struct iova_domain *iovad, unsign=
ed long pfn);<br>
=C2=A0void put_iova_domain(struct iova_domain *iovad);<br>
=C2=A0struct iova *split_and_remove_iova(struct iova_domain *iovad,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct iova *iova, unsigned long pfn_lo, unsign=
ed long pfn_hi);<br>
+void free_cpu_cached_iovas(unsigned int cpu, struct iova_domain *iovad);<b=
r>
<br>
=C2=A0#endif<br>
<span class=3D"gmail-HOEnZb"><font color=3D"#888888">--<br>
1.9.1<br>
<br>
</font></span></blockquote></div><br></div></div>

--001a11416d4060937c0530dca29b--

--===============3344777097621181596==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3344777097621181596==--
