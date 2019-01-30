From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH v2] iommu/vt-d: Implement dma_[un]map_resource()
Date: Wed, 30 Jan 2019 17:23:39 +0100
Message-ID: <20190130162339.d7uiqikoo7plthfs@8bytes.org>
References: <20190122213045.5667-1-logang@deltatee.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190122213045.5667-1-logang@deltatee.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Logan Gunthorpe <logang@deltatee.com>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, Christoph Hellwig <hch@lst.de>, David Woodhouse <dwmw2@infradead.org>
List-Id: iommu@lists.linux-foundation.org

On Tue, Jan 22, 2019 at 02:30:45PM -0700, Logan Gunthorpe wrote:
> Currently the Intel IOMMU uses the default dma_[un]map_resource()
> implementations does nothing and simply returns the physical address
> unmodified.
> 
> However, this doesn't create the IOVA entries necessary for addresses
> mapped this way to work when the IOMMU is enabled. Thus, when the
> IOMMU is enabled, drivers relying on dma_map_resource() will trigger
> DMAR errors. We see this when running ntb_transport with the IOMMU
> enabled, DMA, and switchtec hardware.
> 
> The implementation for intel_map_resource() is nearly identical to
> intel_map_page(), we just have to re-create __intel_map_single().
> dma_unmap_resource() uses intel_unmap_page() directly as the
> functions are identical.
> 
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> Cc: David Woodhouse <dwmw2@infradead.org>
> Cc: Joerg Roedel <joro@8bytes.org>

Applied, thanks.
