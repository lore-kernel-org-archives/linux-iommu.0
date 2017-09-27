From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 3/3] iommu/iova: Try harder to allocate from rcache
	magazine
Date: Wed, 27 Sep 2017 16:00:51 +0200
Message-ID: <20170927140051.GO8398@8bytes.org>
References: <cover.1505827369.git.robin.murphy@arm.com>
	<8127fabc219811d8169189e9d7177d42bc74bcbf.1505827369.git.robin.murphy@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <8127fabc219811d8169189e9d7177d42bc74bcbf.1505827369.git.robin.murphy-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Tue, Sep 19, 2017 at 02:48:41PM +0100, Robin Murphy wrote:
> When devices with different DMA masks are using the same domain, or for
> PCI devices where we usually try a speculative 32-bit allocation first,
> there is a fair possibility that the top PFN of the rcache stack at any
> given time may be unsuitable for the lower limit, prompting a fallback
> to allocating anew from the rbtree. Consequently, we may end up
> artifically increasing pressure on the 32-bit IOVA space as unused IOVAs
> accumulate lower down in the rcache stacks, while callers with 32-bit
> masks also impose unnecessary rbtree overhead.
> 
> In such cases, let's try a bit harder to satisfy the allocation locally
> first - scanning the whole stack should still be relatively inexpensive,
> and even rotating an entry up from the very bottom probably has less
> overall impact than going to the rbtree.
> 
> Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
> ---
>  drivers/iommu/iova.c | 19 ++++++++++++++++---
>  1 file changed, 16 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
> index 8f8b436afd81..a7af8273fa98 100644
> --- a/drivers/iommu/iova.c
> +++ b/drivers/iommu/iova.c
> @@ -826,12 +826,25 @@ static bool iova_magazine_empty(struct iova_magazine *mag)
>  static unsigned long iova_magazine_pop(struct iova_magazine *mag,
>  				       unsigned long limit_pfn)
>  {
> +	int i;
> +	unsigned long pfn;
> +
>  	BUG_ON(iova_magazine_empty(mag));
>  
> -	if (mag->pfns[mag->size - 1] > limit_pfn)
> -		return 0;
> +	/*
> +	 * If we can pull a suitable pfn from anywhere in the stack, that's
> +	 * still probably preferable to falling back to the rbtree.
> +	 */
> +	for (i = mag->size - 1; mag->pfns[i] > limit_pfn; i--)
> +		if (i == 0)
> +			return 0;
>  
> -	return mag->pfns[--mag->size];
> +	pfn = mag->pfns[i];
> +	mag->size--;
> +	for (; i < mag->size; i++)
> +		mag->pfns[i] = mag->pfns[i + 1];

Do we need to preserve the order of the elements on the stack or would
it also suffice to just copy the top-element to the position we are
removing?


	Joerg
