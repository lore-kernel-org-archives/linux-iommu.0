From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH] dma-direct: Fix return value of dma_direct_supported
Date: Thu, 4 Oct 2018 12:25:47 +0100
Message-ID: <5329f992-d3aa-c16c-1218-c26d758889b8@arm.com>
References: <20181003234746.3586.42014.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20181003234746.3586.42014.stgit-bi+AKbBUZKY6gyzm1THtWbp2dZbC/Bob@public.gmane.org>
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
To: Alexander Duyck <alexander.h.duyck-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org, linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 04/10/18 00:48, Alexander Duyck wrote:
> It appears that in commit 9d7a224b463e ("dma-direct: always allow dma mask
> <= physiscal memory size") the logic of the test was changed from a "<" to
> a ">=" however I don't see any reason for that change. I am assuming that
> there was some additional change planned, specifically I suspect the logic
> was intended to be reversed and possibly used for a return. Since that is
> the case I have gone ahead and done that.

Bah, seems I got hung up on the min_mask code above it and totally 
overlooked that the condition itself got flipped. It probably also can't 
help that it's an int return type, but treated as a bool by callers 
rather than "0 for success" as int tends to imply in isolation.

Anyway, paying a bit more attention this time, I think this looks like 
the right fix - cheers Alex.

Robin.

> This addresses issues I had on my system that prevented me from booting
> with the above mentioned commit applied on an x86_64 system w/ Intel IOMMU.
> 
> Fixes: 9d7a224b463e ("dma-direct: always allow dma mask <= physiscal memory size")
> Signed-off-by: Alexander Duyck <alexander.h.duyck-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> ---
>   kernel/dma/direct.c |    4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
> index 5a0806b5351b..65872f6c2e93 100644
> --- a/kernel/dma/direct.c
> +++ b/kernel/dma/direct.c
> @@ -301,9 +301,7 @@ int dma_direct_supported(struct device *dev, u64 mask)
>   
>   	min_mask = min_t(u64, min_mask, (max_pfn - 1) << PAGE_SHIFT);
>   
> -	if (mask >= phys_to_dma(dev, min_mask))
> -		return 0;
> -	return 1;
> +	return mask >= phys_to_dma(dev, min_mask);
>   }
>   
>   int dma_direct_mapping_error(struct device *dev, dma_addr_t dma_addr)
> 
> _______________________________________________
> iommu mailing list
> iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
> 
