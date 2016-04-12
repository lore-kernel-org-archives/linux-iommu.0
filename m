From: Adam Morrison <mad-FrESSTt7Abv7r6psnUbsSmZHpeb/A1Y/@public.gmane.org>
Subject: Re: [PATCH 4/7] iommu: only unmap mapped entries
Date: Tue, 12 Apr 2016 18:08:29 +0300
Message-ID: <CAHMfzJmVpNun72V0Zv07N00EA6zL_5rMBbV-Q4sj65BiB=y=XA@mail.gmail.com>
References: <20151228161647.GA27885@cs.technion.ac.il>
	<CAN+hb0W1MQHD5+rmRS6v4x2q9RrnmsXSad=YDxUaOPDUYO4M8w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <CAN+hb0W1MQHD5+rmRS6v4x2q9RrnmsXSad=YDxUaOPDUYO4M8w-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Benjamin Serebrin <serebrin-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
Cc: David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Dan Tsafrir <dan-FrESSTt7Abv7r6psnUbsSmZHpeb/A1Y/@public.gmane.org>, Omer Peleg <omer-FrESSTt7Abv7r6psnUbsSmZHpeb/A1Y/@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Mon, Apr 11, 2016 at 11:15 PM, Benjamin Serebrin via iommu
<iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org> wrote:

> @@ -3542,6 +3543,7 @@ static void flush_unmaps(struct
> deferred_flush_data *flush_data)
>   struct deferred_flush_entry *entry =
>   &flush_table->entries[j];
>   struct iova *iova = entry->iova;
> + unsigned long nrpages = entry->nrpages;
>
> Is this always correct, if dev_addr isn't page aligned? If dev_addr is
> page aligned and size = 4096?  I think there's a deeper bug in the
> aligned_nrpages() function that we should address outside this patch.

I think it's correct.  aligned_nrpages() masks off the PFN and then
aligns up to the MM page size, and this works for both these examples.

> @@ -3644,7 +3649,16 @@ static void intel_unmap_sg(struct device *dev,
> struct scatterlist *sglist,
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
>
> Does this need math to adjust if startaddr isn't page aligned?

Don't think so.  It just reverses the intel_map_sg() flow.
