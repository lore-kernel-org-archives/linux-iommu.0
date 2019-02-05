From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] dma-direct: Export dma_direct_alloc() and
 dma_direct_free()
Date: Tue, 5 Feb 2019 17:10:36 +0100
Message-ID: <20190205161036.GA782@lst.de>
References: <20190205110602.27717-1-thierry.reding@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190205110602.27717-1-thierry.reding@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>, Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On Tue, Feb 05, 2019 at 12:06:02PM +0100, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
> 
> Drivers that are built as modules may want to use these functions, so
> make them available like the rest of the functions.
> 
> Signed-off-by: Thierry Reding <treding@nvidia.com>

How do they want to use these functions?  The proper way is to
call dma_alloc_coherent / dma_alloc_free and let the DMA API
handle the rest.
