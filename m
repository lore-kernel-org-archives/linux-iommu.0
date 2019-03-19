From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH v2 RFC/RFT] dma-contiguous: Get normal pages for
 single-page allocations
Date: Tue, 19 Mar 2019 14:43:01 +0000
Message-ID: <20190319144301.GG59586@arrakis.emea.arm.com>
References: <20190305183202.16216-1-nicoleotsuka@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190305183202.16216-1-nicoleotsuka@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nicolin Chen <nicoleotsuka@gmail.com>
Cc: hch@lst.de, robin.murphy@arm.com, vdumpa@nvidia.com, will.deacon@arm.com, chris@zankel.net, jcmvbkbc@gmail.com, joro@8bytes.org, dwmw2@infradead.org, m.szyprowski@samsung.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-xtensa@linux-xtensa.org, iommu@lists.linux-foundation.org, jonathanh@nvidia.com
List-Id: iommu@lists.linux-foundation.org

On Tue, Mar 05, 2019 at 10:32:02AM -0800, Nicolin Chen wrote:
> The addresses within a single page are always contiguous, so it's
> not so necessary to always allocate one single page from CMA area.
> Since the CMA area has a limited predefined size of space, it may
> run out of space in heavy use cases, where there might be quite a
> lot CMA pages being allocated for single pages.
> 
> However, there is also a concern that a device might care where a
> page comes from -- it might expect the page from CMA area and act
> differently if the page doesn't.
> 
> This patch tries to get normal pages for single-page allocations
> unless the device has its own CMA area. This would save resources
> from the CMA area for more CMA allocations. And it'd also reduce
> CMA fragmentations resulted from trivial allocations.

This is not sufficient. Some architectures/platforms declare limits on
the CMA range so that DMA is possible with all expected devices. For
example, on arm64 we keep the CMA in the lower 4GB of the address range,
though with this patch you only covered the iommu ops allocation.

Do you have any numbers to back this up? You don't seem to address
dma_direct_alloc() either but, as I said above, it's not trivial since
some platforms expect certain physical range for DMA allocations.

-- 
Catalin
