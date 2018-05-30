From: Finn Thain <fthain-PnMVE5gNl/W9dxLkCovUHLpzq4S04n8Q@public.gmane.org>
Subject: Re: [PATCH] dma-direct: don't crash on device without dma_mask
Date: Wed, 30 May 2018 12:16:12 +1000 (AEST)
Message-ID: <alpine.LNX.2.21.1805301213580.11@nippy.intranet>
References: <20180529141512.28546-1-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20180529141512.28546-1-hch-jcswGhMUV9g@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Tue, 29 May 2018, Christoph Hellwig wrote:

> Print a useful warning instead.
> 
> Reported-by: Finn Thain <fthain-PnMVE5gNl/W9dxLkCovUHLpzq4S04n8Q@public.gmane.org>
> Signed-off-by: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>

Tested-by: Finn Thain <fthain-PnMVE5gNl/W9dxLkCovUHLpzq4S04n8Q@public.gmane.org>

Thanks.

-- 

> ---
>  lib/dma-direct.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/lib/dma-direct.c b/lib/dma-direct.c
> index a48f94eff62e..8be8106270c2 100644
> --- a/lib/dma-direct.c
> +++ b/lib/dma-direct.c
> @@ -34,6 +34,13 @@ check_addr(struct device *dev, dma_addr_t dma_addr, size_t size,
>  		const char *caller)
>  {
>  	if (unlikely(dev && !dma_capable(dev, dma_addr, size))) {
> +		if (!dev->dma_mask) {
> +			dev_err(dev,
> +				"%s: call on device without dma_mask\n",
> +				caller);
> +			return false;
> +		}
> +
>  		if (*dev->dma_mask >= DMA_BIT_MASK(32)) {
>  			dev_err(dev,
>  				"%s: overflow %pad+%zu of device mask %llx\n",
> 
