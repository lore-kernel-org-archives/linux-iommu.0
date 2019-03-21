From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH v2 RFC/RFT] dma-contiguous: Get normal pages for
 single-page allocations
Date: Thu, 21 Mar 2019 16:32:49 -0700
Message-ID: <20190321233248.GA6941@Asurada-Nvidia>
References: <20190305183202.16216-1-nicoleotsuka@gmail.com>
 <20190319144301.GG59586@arrakis.emea.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190319144301.GG59586@arrakis.emea.arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: hch@lst.de, robin.murphy@arm.com, vdumpa@nvidia.com, will.deacon@arm.com, chris@zankel.net, jcmvbkbc@gmail.com, joro@8bytes.org, dwmw2@infradead.org, m.szyprowski@samsung.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-xtensa@linux-xtensa.org, iommu@lists.linux-foundation.org, jonathanh@nvidia.com
List-Id: iommu@lists.linux-foundation.org

Hi Catalin,

Thank you for the review. And I realized that the free() path
is missing too.

On Tue, Mar 19, 2019 at 02:43:01PM +0000, Catalin Marinas wrote:
> On Tue, Mar 05, 2019 at 10:32:02AM -0800, Nicolin Chen wrote:
> > The addresses within a single page are always contiguous, so it's
> > not so necessary to always allocate one single page from CMA area.
> > Since the CMA area has a limited predefined size of space, it may
> > run out of space in heavy use cases, where there might be quite a
> > lot CMA pages being allocated for single pages.
> > 
> > However, there is also a concern that a device might care where a
> > page comes from -- it might expect the page from CMA area and act
> > differently if the page doesn't.
> > 
> > This patch tries to get normal pages for single-page allocations
> > unless the device has its own CMA area. This would save resources
> > from the CMA area for more CMA allocations. And it'd also reduce
> > CMA fragmentations resulted from trivial allocations.
> 
> This is not sufficient. Some architectures/platforms declare limits on
> the CMA range so that DMA is possible with all expected devices. For
> example, on arm64 we keep the CMA in the lower 4GB of the address range,
> though with this patch you only covered the iommu ops allocation.

I will follow the way of v1 by adding alloc_page()/free_page()
function to those callers who don't have fallback allocations.
In this way, archs may use different callbacks to alloc pages.

> Do you have any numbers to back this up? You don't seem to address
> dma_direct_alloc() either but, as I said above, it's not trivial since
> some platforms expect certain physical range for DMA allocations.

What's the dma_direct_alloc() here about? Mind elaborating?
