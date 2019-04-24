From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2 RFC/RFT 1/5] ARM: dma-mapping: Add fallback normal
 page allocations
Date: Wed, 24 Apr 2019 17:06:38 +0200
Message-ID: <20190424150638.GA22191@lst.de>
References: <20190326230131.16275-1-nicoleotsuka@gmail.com> <20190326230131.16275-2-nicoleotsuka@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190326230131.16275-2-nicoleotsuka@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nicolin Chen <nicoleotsuka@gmail.com>
Cc: hch@lst.de, robin.murphy@arm.com, vdumpa@nvidia.com, linux@armlinux.org.uk, catalin.marinas@arm.com, will.deacon@arm.com, joro@8bytes.org, m.szyprowski@samsung.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, tony@atomide.com
List-Id: iommu@lists.linux-foundation.org

On Tue, Mar 26, 2019 at 04:01:27PM -0700, Nicolin Chen wrote:
>  	page = dma_alloc_from_contiguous(dev, count, order, gfp & __GFP_NOWARN);
> +	if (!page)
> +		page = alloc_pages(gfp, order);

We have this fallback in most callers already.  And with me adding
it to the dma-iommu code in one series, and you to arm here I think
we really need to take a step back and think of a better way
to handle this, and the general mess that dma_alloc_from_contiguous.

So what about:

 (1) change the dma_alloc_from_contiguous prototype to be:

struct page *dma_alloc_contiguous(struct device *dev, size_t size, gfp_t gfp);

     that is: calculate order and count internally, pass the full gfp_t
     and mask it internally, and drop the pointless from in the name.
     I'd also use the oppurtunity to forbid a NULL dev argument and
     opencode those uses.
 
 (2) handle the alloc_pages fallback internally.  Note that we should
     use alloc_pages_node as we do in dma-direct.

> +			if (!dma_release_from_contiguous(dev, page, count))
> +				__free_pages(page, get_order(size));

Same for dma_release_from_contiguous - drop the _from, pass the
actual size, and handle the free_pages fallback.
