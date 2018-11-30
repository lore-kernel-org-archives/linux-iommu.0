From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] dma-debug: hns_enet_drv could use more DMA entries
Date: Fri, 30 Nov 2018 09:42:03 +0100
Message-ID: <20181130084203.GA19812@lst.de>
References: <20181130035456.1586-1-cai@gmx.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181130035456.1586-1-cai@gmx.us>
Sender: linux-kernel-owner@vger.kernel.org
To: Qian Cai <cai@gmx.us>
Cc: hch@lst.de, m.szyprowski@samsung.com, robin.murphy@arm.com, yisen.zhuang@huawei.com, salil.mehta@huawei.com, iommu@lists.linux-foundation.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On Thu, Nov 29, 2018 at 10:54:56PM -0500, Qian Cai wrote:
>  /* allow architectures to override this if absolutely required */
>  #ifndef PREALLOC_DMA_DEBUG_ENTRIES
> +/* amount of DMA mappings on this driver is huge. */
> +#ifdef	HNS_ENET
> +#define PREALLOC_DMA_DEBUG_ENTRIES (1 << 17)
> +#else
>  #define PREALLOC_DMA_DEBUG_ENTRIES (1 << 16)
>  #endif
> +#endif

How would this be defined in a header that leaks into this file?

I think we need to turn PREALLOC_DMA_DEBUG_ENTRIES into a user
selectable config options, as I really don't want to collect hacks like
this.
