From: Konrad Rzeszutek Wilk <konrad@darnok.org>
Subject: Re: [PATCH v2 2/2] swiotlb: checking whether swiotlb buffer is full
 with io_tlb_used
Date: Thu, 17 Jan 2019 10:25:23 -0500
Message-ID: <20190117152520.GA24900@localhost.localdomain>
References: <1544402278-8175-1-git-send-email-dongli.zhang@oracle.com>
 <1544402278-8175-2-git-send-email-dongli.zhang@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1544402278-8175-2-git-send-email-dongli.zhang@oracle.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dongli Zhang <dongli.zhang@oracle.com>
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, konrad.wilk@oracle.com, hch@lst.de, m.szyprowski@samsung.com, robin.murphy@arm.com, joe.jin@oracle.com
List-Id: iommu@lists.linux-foundation.org

On Mon, Dec 10, 2018 at 08:37:58AM +0800, Dongli Zhang wrote:
> This patch uses io_tlb_used to help check whether swiotlb buffer is full.
> io_tlb_used is no longer used for only debugfs. It is also used to help
> optimize swiotlb_tbl_map_single().

Please split this up.

That is have the 'if (unlikely(nslots > io_tlb_nslabs - io_tlb_used))'
as a seperate patch.

And the #ifdef folding in the previous patch.

Also rebase on top of latest Linus please.

> 
> Suggested-by: Joe Jin <joe.jin@oracle.com>
> Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
> ---
>  kernel/dma/swiotlb.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
> 
> diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> index 3979c2c..9300341 100644
> --- a/kernel/dma/swiotlb.c
> +++ b/kernel/dma/swiotlb.c
> @@ -76,12 +76,10 @@ static phys_addr_t io_tlb_start, io_tlb_end;
>   */
>  static unsigned long io_tlb_nslabs;
>  
> -#ifdef CONFIG_DEBUG_FS
>  /*
>   * The number of used IO TLB block
>   */
>  static unsigned long io_tlb_used;
> -#endif
>  
>  /*
>   * This is a free list describing the number of free entries available from
> @@ -489,6 +487,10 @@ phys_addr_t swiotlb_tbl_map_single(struct device *hwdev,
>  	 * request and allocate a buffer from that IO TLB pool.
>  	 */
>  	spin_lock_irqsave(&io_tlb_lock, flags);
> +
> +	if (unlikely(nslots > io_tlb_nslabs - io_tlb_used))
> +		goto not_found;
> +
>  	index = ALIGN(io_tlb_index, stride);
>  	if (index >= io_tlb_nslabs)
>  		index = 0;
> @@ -538,9 +540,7 @@ phys_addr_t swiotlb_tbl_map_single(struct device *hwdev,
>  		dev_warn(hwdev, "swiotlb buffer is full (sz: %zd bytes)\n", size);
>  	return SWIOTLB_MAP_ERROR;
>  found:
> -#ifdef CONFIG_DEBUG_FS
>  	io_tlb_used += nslots;
> -#endif
>  	spin_unlock_irqrestore(&io_tlb_lock, flags);
>  
>  	/*
> @@ -602,9 +602,7 @@ void swiotlb_tbl_unmap_single(struct device *hwdev, phys_addr_t tlb_addr,
>  		for (i = index - 1; (OFFSET(i, IO_TLB_SEGSIZE) != IO_TLB_SEGSIZE -1) && io_tlb_list[i]; i--)
>  			io_tlb_list[i] = ++count;
>  
> -#ifdef CONFIG_DEBUG_FS
>  		io_tlb_used -= nslots;
> -#endif
>  	}
>  	spin_unlock_irqrestore(&io_tlb_lock, flags);
>  }
> -- 
> 2.7.4
> 
