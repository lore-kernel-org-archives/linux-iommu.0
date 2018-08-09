From: Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>
Subject: Re: [PATCH 10/20] powerpc/dma-noncoherent: don't disable irqs over
	kmap_atomic
Date: Thu, 09 Aug 2018 10:27:46 +1000
Message-ID: <bfa22816fee0759cfee28705b427be3586c7d2e3.camel@kernel.crashing.org>
References: <20180730163824.10064-1-hch@lst.de>
	<20180730163824.10064-11-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20180730163824.10064-11-hch-jcswGhMUV9g@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>, Paul Mackerras <paulus-eUNUBHrolfbYtjvyW6yDsg@public.gmane.org>, Michael Ellerman <mpe-Gsx/Oe8HsFggBc27wqDAHg@public.gmane.org>, Tony Luck <tony.luck-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Fenghua Yu <fenghua.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-ia64-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, Konrad Rzeszutek Wilk <konrad.wilk-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Mon, 2018-07-30 at 18:38 +0200, Christoph Hellwig wrote:
> The requirement to disable local irqs over kmap_atomic is long gone,
> so remove those calls.

Really ? I'm trying to verify that and getting lost in a mess of macros
from hell in the per-cpu stuff but if you look at our implementation
of kmap_atomic_prot(), all it does is a preempt_disable(), and then
it uses kmap_atomic_idx_push():

	int idx = __this_cpu_inc_return(__kmap_atomic_idx) - 1;

Note the use of __this_cpu_inc_return(), not this_cpu_inc_return(),
ie this is the non-interrupt safe version...

Ben.

> Signed-off-by: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
> ---
>  arch/powerpc/mm/dma-noncoherent.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/arch/powerpc/mm/dma-noncoherent.c b/arch/powerpc/mm/dma-noncoherent.c
> index 382528475433..d1c16456abac 100644
> --- a/arch/powerpc/mm/dma-noncoherent.c
> +++ b/arch/powerpc/mm/dma-noncoherent.c
> @@ -357,12 +357,10 @@ static inline void __dma_sync_page_highmem(struct page *page,
>  {
>  	size_t seg_size = min((size_t)(PAGE_SIZE - offset), size);
>  	size_t cur_size = seg_size;
> -	unsigned long flags, start, seg_offset = offset;
> +	unsigned long start, seg_offset = offset;
>  	int nr_segs = 1 + ((size - seg_size) + PAGE_SIZE - 1)/PAGE_SIZE;
>  	int seg_nr = 0;
>  
> -	local_irq_save(flags);
> -
>  	do {
>  		start = (unsigned long)kmap_atomic(page + seg_nr) + seg_offset;
>  
> @@ -378,8 +376,6 @@ static inline void __dma_sync_page_highmem(struct page *page,
>  		cur_size += seg_size;
>  		seg_offset = 0;
>  	} while (seg_nr < nr_segs);
> -
> -	local_irq_restore(flags);
>  }
>  #endif /* CONFIG_HIGHMEM */
>  
