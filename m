From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: Re: [PATCH 1/1] swiotlb: dump used and total slots when swiotlb
 buffer is full
Date: Thu, 11 Apr 2019 15:55:28 -0400
Message-ID: <20190411195528.GB6033@char.us.oracle.com>
References: <1554426925-2431-1-git-send-email-dongli.zhang@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1554426925-2431-1-git-send-email-dongli.zhang@oracle.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dongli Zhang <dongli.zhang@oracle.com>
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, hch@lst.de, m.szyprowski@samsung.com, robin.murphy@arm.com, joe.jin@oracle.com, srinivas.eeda@oracle.com
List-Id: iommu@lists.linux-foundation.org

On Fri, Apr 05, 2019 at 09:15:25AM +0800, Dongli Zhang wrote:
> So far the kernel only prints the requested size if swiotlb buffer if full.
> It is not possible to know whether it is simply an out of buffer, or it is
> because swiotlb cannot allocate buffer with the requested size due to
> fragmentation.
> 
> As 'io_tlb_used' is available since commit 71602fe6d4e9 ("swiotlb: add
> debugfs to track swiotlb buffer usage"), both 'io_tlb_used' and
> 'io_tlb_nslabs' are printed when swiotlb buffer is full.
> 
> Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>

Applied. Will send git pull shortly.
> ---
>  kernel/dma/swiotlb.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> index 53012db..3f43b37 100644
> --- a/kernel/dma/swiotlb.c
> +++ b/kernel/dma/swiotlb.c
> @@ -540,7 +540,8 @@ phys_addr_t swiotlb_tbl_map_single(struct device *hwdev,
>  not_found:
>  	spin_unlock_irqrestore(&io_tlb_lock, flags);
>  	if (!(attrs & DMA_ATTR_NO_WARN) && printk_ratelimit())
> -		dev_warn(hwdev, "swiotlb buffer is full (sz: %zd bytes)\n", size);
> +		dev_warn(hwdev, "swiotlb buffer is full (sz: %zd bytes), total %lu, used %lu\n",
> +			 size, io_tlb_nslabs, io_tlb_used);
>  	return DMA_MAPPING_ERROR;
>  found:
>  	io_tlb_used += nslots;
> -- 
> 2.7.4
> 
