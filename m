From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH] lib/dma-debug.c: fix memory leakage
Date: Thu, 22 Feb 2018 14:04:17 +0000
Message-ID: <6df7e9bd-2203-0692-97e4-8c6434304b0f@arm.com>
References: <1519298540-3071-1-git-send-email-miles.chen@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1519298540-3071-1-git-send-email-miles.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Content-Language: en-GB
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: miles.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>, Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, wsd_upstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 22/02/18 11:22, miles.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org wrote:
> From: Miles Chen <miles.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
> 
> Marty reported a memory leakage introduced by commit 3aaabbf1c39e
> ("lib/dma-debug.c: fix incorrect pfn calculation"). Fix it
> by checking the virtual address before allocating the entry.

Oops, seems I failed to look closely enough at the surrounding diff 
context when I reviewed the original patch... :(

> This patch also use virt_addr_valid() instead of virt_to_page()
> to check if a virtual address is linear.

That's an area I happen to have been looking at lately and now 
understand a lot better, so fully agreed there as well.

Acked-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>

Maybe also worth having a proper Fixes: tag instead of just naming the 
commit in prose?

Thanks,
Robin.

> Reported-by: Marty Faltesek <mfaltesek-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
> Signed-off-by: Miles Chen <miles.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
> ---
>   lib/dma-debug.c | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/lib/dma-debug.c b/lib/dma-debug.c
> index 1b34d210452c..7f5cdc1e6b29 100644
> --- a/lib/dma-debug.c
> +++ b/lib/dma-debug.c
> @@ -1491,12 +1491,12 @@ void debug_dma_alloc_coherent(struct device *dev, size_t size,
>   	if (unlikely(virt == NULL))
>   		return;
>   
> -	entry = dma_entry_alloc();
> -	if (!entry)
> +	/* handle vmalloc and linear addresses */
> +	if (!is_vmalloc_addr(virt) && !virt_addr_valid(virt))
>   		return;
>   
> -	/* handle vmalloc and linear addresses */
> -	if (!is_vmalloc_addr(virt) && !virt_to_page(virt))
> +	entry = dma_entry_alloc();
> +	if (!entry)
>   		return;
>   
>   	entry->type      = dma_debug_coherent;
> @@ -1528,7 +1528,7 @@ void debug_dma_free_coherent(struct device *dev, size_t size,
>   	};
>   
>   	/* handle vmalloc and linear addresses */
> -	if (!is_vmalloc_addr(virt) && !virt_to_page(virt))
> +	if (!is_vmalloc_addr(virt) && !virt_addr_valid(virt))
>   		return;
>   
>   	if (is_vmalloc_addr(virt))
> 
