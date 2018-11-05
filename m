From: Guo Ren <ren_guo@c-sky.com>
Subject: Re: [PATCH 7/9] csky: don't select DMA_NONCOHERENT_OPS
Date: Mon, 5 Nov 2018 23:47:22 +0800
Message-ID: <20181105154721.GA25126@guoren-Inspiron-7460>
References: <20181105121931.13481-1-hch@lst.de>
 <20181105121931.13481-8-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181105121931.13481-8-hch@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: iommu@lists.linux-foundation.org, Robin Murphy <robin.murphy@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Laura Abbott <labbott@redhat.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On Mon, Nov 05, 2018 at 01:19:29PM +0100, Christoph Hellwig wrote:
> This option is gone past Linux 4.19.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  arch/csky/Kconfig | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/csky/Kconfig b/arch/csky/Kconfig
> index 8a30e006a845..c0cf8e948821 100644
> --- a/arch/csky/Kconfig
> +++ b/arch/csky/Kconfig
> @@ -8,7 +8,6 @@ config CSKY
>  	select CLKSRC_MMIO
>  	select CLKSRC_OF
>  	select DMA_DIRECT_OPS
> -	select DMA_NONCOHERENT_OPS
>  	select DMA_REMAP
>  	select IRQ_DOMAIN
>  	select HANDLE_DOMAIN_IRQ
> -- 
> 2.19.1

Acked-by: Guo Ren <ren_guo@c-sky.com>
