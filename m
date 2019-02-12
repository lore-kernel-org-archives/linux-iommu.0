From: Konrad Rzeszutek Wilk <konrad@darnok.org>
Subject: Re: [PATCH v3 1/3] swiotlb: fix comment on swiotlb_bounce()
Date: Tue, 12 Feb 2019 13:47:13 -0500
Message-ID: <20190212184708.GA19497@localhost.localdomain>
References: <1547795428-10595-1-git-send-email-dongli.zhang@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1547795428-10595-1-git-send-email-dongli.zhang@oracle.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dongli Zhang <dongli.zhang@oracle.com>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, konrad.wilk@oracle.com, hch@lst.de, m.szyprowski@samsung.com, robin.murphy@arm.com, joe.jin@oracle.com
List-Id: iommu@lists.linux-foundation.org

On Fri, Jan 18, 2019 at 03:10:26PM +0800, Dongli Zhang wrote:
> Fix the comment as swiotlb_bounce() is used to copy from original dma
> location to swiotlb buffer during swiotlb_tbl_map_single(), while to
> copy from swiotlb buffer to original dma location during
> swiotlb_tbl_unmap_single().

I queued up your patches in https://git.kernel.org/pub/scm/linux/kernel/git/konrad/swiotlb.git
> 
> Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
> ---
>  kernel/dma/swiotlb.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> index 1fb6fd6..1d8b377 100644
> --- a/kernel/dma/swiotlb.c
> +++ b/kernel/dma/swiotlb.c
> @@ -385,7 +385,7 @@ void __init swiotlb_exit(void)
>  }
>  
>  /*
> - * Bounce: copy the swiotlb buffer back to the original dma location
> + * Bounce: copy the swiotlb buffer from or back to the original dma location
>   */
>  static void swiotlb_bounce(phys_addr_t orig_addr, phys_addr_t tlb_addr,
>  			   size_t size, enum dma_data_direction dir)
> -- 
> 2.7.4
> 
