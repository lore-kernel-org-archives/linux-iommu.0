From: Guo Ren <ren_guo@c-sky.com>
Subject: Re: [PATCH 8/9] csky: don't use GFP_DMA in atomic_pool_init
Date: Mon, 5 Nov 2018 23:47:50 +0800
Message-ID: <20181105154750.GB25126@guoren-Inspiron-7460>
References: <20181105121931.13481-1-hch@lst.de>
 <20181105121931.13481-9-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181105121931.13481-9-hch@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: iommu@lists.linux-foundation.org, Robin Murphy <robin.murphy@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Laura Abbott <labbott@redhat.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On Mon, Nov 05, 2018 at 01:19:30PM +0100, Christoph Hellwig wrote:
> csky does not implement ZONE_DMA, which means passing GFP_DMA is a no-op.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  arch/csky/mm/dma-mapping.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/csky/mm/dma-mapping.c b/arch/csky/mm/dma-mapping.c
> index 85437b21e045..ad4046939713 100644
> --- a/arch/csky/mm/dma-mapping.c
> +++ b/arch/csky/mm/dma-mapping.c
> @@ -35,7 +35,7 @@ static int __init atomic_pool_init(void)
>  	if (!atomic_pool)
>  		BUG();
>  
> -	page = alloc_pages(GFP_KERNEL | GFP_DMA, get_order(size));
> +	page = alloc_pages(GFP_KERNEL, get_order(size));
>  	if (!page)
>  		BUG();
>  
> -- 
> 2.19.1

Acked-by: Guo Ren <ren_guo@c-sky.com>
