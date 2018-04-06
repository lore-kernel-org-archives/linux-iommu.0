From: Dominik Brodowski <linux-X3ehHDuj6sIIGcDfoQAp7OTW4wlIGRCZ@public.gmane.org>
Subject: Re: x86/dma conversion for v4.17-rc1 breaks sound / sst-acpi (commit
	6e4bf5867783)
Date: Fri, 6 Apr 2018 16:52:39 +0200
Message-ID: <20180406145239.GA1845@light.dominikbrodowski.net>
References: <20180405205657.GA1788@light.dominikbrodowski.net>
	<20180406141452.GA29724@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20180406141452.GA29724-jcswGhMUV9g@public.gmane.org>
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
Cc: thomas.lendacky-5C7GfCeVMHo@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, konrad.wilk-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org, peterz-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, tiwai-IBi9RG/b67k@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, mulix-BzGcCpaT2IbYtjvyW6yDsg@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, perex-/Fr2/VpizcU@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, mingo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Fri, Apr 06, 2018 at 04:14:52PM +0200, Christoph Hellwig wrote:
> Hi Dominik,
> 
> can you try current Linus' master with the following hack applied and
> see if that works?
> 
> diff --git a/lib/swiotlb.c b/lib/swiotlb.c
> index 47aeb04c1997..32aacd0d56a8 100644
> --- a/lib/swiotlb.c
> +++ b/lib/swiotlb.c
> @@ -1087,6 +1087,6 @@ const struct dma_map_ops swiotlb_dma_ops = {
>  	.unmap_sg		= swiotlb_unmap_sg_attrs,
>  	.map_page		= swiotlb_map_page,
>  	.unmap_page		= swiotlb_unmap_page,
> -	.dma_supported		= swiotlb_dma_supported,
> +	.dma_supported		= dma_direct_supported,
>  };
>  #endif /* CONFIG_DMA_DIRECT_OPS */

Yes, it solves the issue.

Thanks,
	Dominik
