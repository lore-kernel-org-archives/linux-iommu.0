From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 2/2] swiotlb: Skip cache maintenance on map error
Date: Tue, 20 Nov 2018 17:07:53 +0100
Message-ID: <20181120160753.GB2492@lst.de>
References: <cover.1542722463.git.robin.murphy@arm.com> <a77c838eb070fb46c51802aa22c28bd8e1f9741c.1542722463.git.robin.murphy@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <a77c838eb070fb46c51802aa22c28bd8e1f9741c.1542722463.git.robin.murphy@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Robin Murphy <robin.murphy@arm.com>
Cc: hch@lst.de, konrad.wilk@oracle.com, m.szyprowski@samsung.com, john.stultz@linaro.org, iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On Tue, Nov 20, 2018 at 02:09:53PM +0000, Robin Murphy wrote:
> If swiotlb_bounce_page() failed, calling arch_sync_dma_for_device() may
> lead to such delights as performing cache maintenance on whatever
> address phys_to_virt(SWIOTLB_MAP_ERROR) looks like, which is typically
> outside the kernel memory map and goes about as well as expected.
> 
> Don't do that.
> 
> Fixes: a4a4330db46a ("swiotlb: add support for non-coherent DMA")
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
