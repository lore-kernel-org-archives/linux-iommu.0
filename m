From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] MAINTAINERS: use the iommu list for the dma-mapping
        subsystem
Date: Fri, 1 Sep 2017 09:50:18 +0200
Message-ID: <20170901075018.GA23035@lst.de>
References: <20170826092734.12859-1-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170826092734.12859-1-hch@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>
List-Id: iommu@lists.linux-foundation.org

Any comments?  I'd like to add this to the 4.14 pull request.

On Sat, Aug 26, 2017 at 11:27:34AM +0200, Christoph Hellwig wrote:
> Maintaining a subsystem with linux-kernel as the main list is painful
> as it has way to much traffic.  On the other hand the dma-mapping
> subsystem is small enough that a list on its own would be silly.
> So use the list for the closes subsystem instead instead.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 6f7721d1634c..1df11ed346a7 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4175,7 +4175,7 @@ DMA MAPPING HELPERS
>  M:	Christoph Hellwig <hch@lst.de>
>  M:	Marek Szyprowski <m.szyprowski@samsung.com>
>  R:	Robin Murphy <robin.murphy@arm.com>
> -L:	linux-kernel@vger.kernel.org
> +L:	iommu@lists.linux-foundation.org
>  T:	git git://git.infradead.org/users/hch/dma-mapping.git
>  W:	http://git.infradead.org/users/hch/dma-mapping.git
>  S:	Supported
> -- 
> 2.11.0
> 
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
---end quoted text---
