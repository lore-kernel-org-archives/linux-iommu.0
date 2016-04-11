From: Benjamin Serebrin via iommu <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Subject: Re: [PATCH 4/7] iommu: only unmap mapped entries
Date: Mon, 11 Apr 2016 13:15:25 -0700
Message-ID: <CAN+hb0W1MQHD5+rmRS6v4x2q9RrnmsXSad=YDxUaOPDUYO4M8w@mail.gmail.com>
References: <20151228161647.GA27885@cs.technion.ac.il>
Reply-To: Benjamin Serebrin <serebrin-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20151228161647.GA27885-FrESSTt7Abv7r6psnUbsSmZHpeb/A1Y/@public.gmane.org>
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

(From Adam's slightly newer patchset sent via email)

@@ -3542,6 +3543,7 @@ static void flush_unmaps(struct
deferred_flush_data *flush_data)
  struct deferred_flush_entry *entry =
  &flush_table->entries[j];
  struct iova *iova = entry->iova;
+ unsigned long nrpages = entry->nrpages;

Is this always correct, if dev_addr isn't page aligned? If dev_addr is
page aligned and size = 4096?  I think there's a deeper bug in the
aligned_nrpages() function that we should address outside this patch.


@@ -3644,7 +3649,16 @@ static void intel_unmap_sg(struct device *dev,
struct scatterlist *sglist,
                           int nelems, enum dma_data_direction dir,
                           struct dma_attrs *attrs)
 {
-       intel_unmap(dev, sglist[0].dma_address);
+       unsigned long nrpages = 0;
+       dma_addr_t startaddr = sglist[0].dma_address - sglist[0].offset;
+       struct scatterlist *sg;
+       int i;
+
+       for_each_sg(sglist, sg, nelems, i) {
+               nrpages += aligned_nrpages(sg->offset, sg->length);
+       }
+
+       intel_unmap(dev, startaddr, nrpages << VTD_PAGE_SHIFT);

Does this need math to adjust if startaddr isn't page aligned?

On Mon, Dec 28, 2015 at 8:16 AM, Adam Morrison <mad-FrESSTt7Abv7r6psnUbsSmZHpeb/A1Y/@public.gmane.org> wrote:
> From: Omer Peleg <omer-FrESSTt7Abv7r6psnUbsSmZHpeb/A1Y/@public.gmane.org>
>
> Current unmap implementation unmaps the entire area covered by the IOVA range,
> which is a power-of-2 aligned region. The corresponding map, however, only maps
> those pages originally mapped by the user. This discrepancy can lead to
> unmapping of already unmapped entries, which is unneeded work.
>
> With this patch, only mapped pages are unmapped. This is also a baseline for a
> map/unmap implementation based on IOVAs and not iova structures, which will
> allow caching.
>
> Signed-off-by: Omer Peleg <omer-FrESSTt7Abv7r6psnUbsSmZHpeb/A1Y/@public.gmane.org>
> [mad-FrESSTt7Abv7r6psnUbsSmZHpeb/A1Y/@public.gmane.org: rebased and reworded the commit message]
> Signed-off-by: Adam Morrison <mad-FrESSTt7Abv7r6psnUbsSmZHpeb/A1Y/@public.gmane.org>
> ---
>  drivers/iommu/intel-iommu.c | 36 +++++++++++++++++++++++++-----------
>  1 file changed, 25 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
> index 6d6229e..e4d023b 100644
> --- a/drivers/iommu/intel-iommu.c
> +++ b/drivers/iommu/intel-iommu.c
> @@ -455,6 +455,7 @@ static void flush_unmaps_timeout(unsigned long data);
>
>  struct deferred_flush_entry {
>         struct iova *iova;
> +       unsigned long nrpages;
>         struct dmar_domain *domain;
>         struct page *freelist;
>  };
> @@ -3457,6 +3458,7 @@ static void flush_unmaps(struct deferred_flush_data *flush_data)
>                         struct deferred_flush_entry *entry =
>                                                 &flush_table->entries[j];
>                         struct iova *iova = entry->iova;
> +                       unsigned long nrpages = entry->nrpages;
>                         struct dmar_domain *domain = entry->domain;
>                         struct page *freelist = entry->freelist;
>
> @@ -3464,10 +3466,9 @@ static void flush_unmaps(struct deferred_flush_data *flush_data)
>                         if (cap_caching_mode(iommu->cap))
>                                 iommu_flush_iotlb_psi(iommu, domain,
>                                         mm_to_dma_pfn(iova->pfn_lo),
> -                                       mm_to_dma_pfn(iova_size(iova)),
> -                                       !freelist, 0);
> +                                       nrpages, !freelist, 0);
>                         else {
> -                               mask = ilog2(mm_to_dma_pfn(iova_size(iova)));
> +                               mask = ilog2(nrpages);
>                                 iommu_flush_dev_iotlb(domain,
>                                                 (uint64_t)iova->pfn_lo << PAGE_SHIFT, mask);
>                         }
> @@ -3491,7 +3492,8 @@ static void flush_unmaps_timeout(unsigned long cpuid)
>         spin_unlock_irqrestore(&flush_data->lock, flags);
>  }
>
> -static void add_unmap(struct dmar_domain *dom, struct iova *iova, struct page *freelist)
> +static void add_unmap(struct dmar_domain *dom, struct iova *iova,
> +                     unsigned long nrpages, struct page *freelist)
>  {
>         unsigned long flags;
>         int entry_id, iommu_id;
> @@ -3516,6 +3518,7 @@ static void add_unmap(struct dmar_domain *dom, struct iova *iova, struct page *f
>         entry = &flush_data->tables[iommu_id].entries[entry_id];
>         entry->domain = dom;
>         entry->iova = iova;
> +       entry->nrpages = nrpages;
>         entry->freelist = freelist;
>
>         if (!flush_data->timer_on) {
> @@ -3528,10 +3531,11 @@ static void add_unmap(struct dmar_domain *dom, struct iova *iova, struct page *f
>         put_cpu();
>  }
>
> -static void intel_unmap(struct device *dev, dma_addr_t dev_addr)
> +static void intel_unmap(struct device *dev, dma_addr_t dev_addr, size_t size)
>  {
>         struct dmar_domain *domain;
>         unsigned long start_pfn, last_pfn;
> +       unsigned long nrpages;
>         struct iova *iova;
>         struct intel_iommu *iommu;
>         struct page *freelist;
> @@ -3549,8 +3553,9 @@ static void intel_unmap(struct device *dev, dma_addr_t dev_addr)
>                       (unsigned long long)dev_addr))
>                 return;
>
> +       nrpages = aligned_nrpages(dev_addr, size);
>         start_pfn = mm_to_dma_pfn(iova->pfn_lo);
> -       last_pfn = mm_to_dma_pfn(iova->pfn_hi + 1) - 1;
> +       last_pfn = start_pfn + nrpages - 1;
>
>         pr_debug("Device %s unmapping: pfn %lx-%lx\n",
>                  dev_name(dev), start_pfn, last_pfn);
> @@ -3559,12 +3564,12 @@ static void intel_unmap(struct device *dev, dma_addr_t dev_addr)
>
>         if (intel_iommu_strict) {
>                 iommu_flush_iotlb_psi(iommu, domain, start_pfn,
> -                                     last_pfn - start_pfn + 1, !freelist, 0);
> +                                     nrpages, !freelist, 0);
>                 /* free iova */
>                 __free_iova(&domain->iovad, iova);
>                 dma_free_pagelist(freelist);
>         } else {
> -               add_unmap(domain, iova, freelist);
> +               add_unmap(domain, iova, nrpages, freelist);
>                 /*
>                  * queue up the release of the unmap to save the 1/6th of the
>                  * cpu used up by the iotlb flush operation...
> @@ -3576,7 +3581,7 @@ static void intel_unmap_page(struct device *dev, dma_addr_t dev_addr,
>                              size_t size, enum dma_data_direction dir,
>                              struct dma_attrs *attrs)
>  {
> -       intel_unmap(dev, dev_addr);
> +       intel_unmap(dev, dev_addr, size);
>  }
>
>  static void *intel_alloc_coherent(struct device *dev, size_t size,
> @@ -3635,7 +3640,7 @@ static void intel_free_coherent(struct device *dev, size_t size, void *vaddr,
>         size = PAGE_ALIGN(size);
>         order = get_order(size);
>
> -       intel_unmap(dev, dma_handle);
> +       intel_unmap(dev, dma_handle, size);
>         if (!dma_release_from_contiguous(dev, page, size >> PAGE_SHIFT))
>                 __free_pages(page, order);
>  }
> @@ -3644,7 +3649,16 @@ static void intel_unmap_sg(struct device *dev, struct scatterlist *sglist,
>                            int nelems, enum dma_data_direction dir,
>                            struct dma_attrs *attrs)
>  {
> -       intel_unmap(dev, sglist[0].dma_address);
> +       unsigned long nrpages = 0;
> +       dma_addr_t startaddr = sglist[0].dma_address - sglist[0].offset;
> +       struct scatterlist *sg;
> +       int i;
> +
> +       for_each_sg(sglist, sg, nelems, i) {
> +               nrpages += aligned_nrpages(sg->offset, sg->length);
> +       }
> +
> +       intel_unmap(dev, startaddr, nrpages << VTD_PAGE_SHIFT);
>  }
>
>  static int intel_nontranslate_map_sg(struct device *hddev,
> --
> 1.9.1
>
