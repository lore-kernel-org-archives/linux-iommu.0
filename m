From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: Re: [PATCH 1/6] swiotlb: remove a pointless comment
Date: Fri, 18 May 2018 16:22:04 -0400
Message-ID: <20180518202203.GI23713@char.us.oracle.com>
References: <20180515180523.3038-1-hch@lst.de>
 <20180515180523.3038-2-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180515180523.3038-2-hch@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On Tue, May 15, 2018 at 08:05:18PM +0200, Christoph Hellwig wrote:
> This comments describes an aspect of the map_sg interface that isn't
> even exploited by swiotlb.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Applied.
> ---
>  lib/swiotlb.c | 6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/lib/swiotlb.c b/lib/swiotlb.c
> index 16ace0e25d52..721f93677eee 100644
> --- a/lib/swiotlb.c
> +++ b/lib/swiotlb.c
> @@ -927,12 +927,6 @@ swiotlb_sync_single_for_device(struct device *hwdev, dma_addr_t dev_addr,
>   * appropriate dma address and length.  They are obtained via
>   * sg_dma_{address,length}(SG).
>   *
> - * NOTE: An implementation may be able to use a smaller number of
> - *       DMA address/length pairs than there are SG table elements.
> - *       (for example via virtual mapping capabilities)
> - *       The routine returns the number of addr/length pairs actually
> - *       used, at most nents.
> - *
>   * Device ownership issues as mentioned above for swiotlb_map_page are the
>   * same here.
>   */
> -- 
> 2.17.0
> 
