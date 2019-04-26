From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH v2 RFC/RFT 1/5] ARM: dma-mapping: Add fallback normal
 page allocations
Date: Fri, 26 Apr 2019 13:21:12 -0700
Message-ID: <20190426202110.GA11129@Asurada-Nvidia.nvidia.com>
References: <20190326230131.16275-1-nicoleotsuka@gmail.com>
 <20190326230131.16275-2-nicoleotsuka@gmail.com>
 <20190424150638.GA22191@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190424150638.GA22191@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: robin.murphy@arm.com, vdumpa@nvidia.com, linux@armlinux.org.uk, catalin.marinas@arm.com, will.deacon@arm.com, joro@8bytes.org, m.szyprowski@samsung.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, tony@atomide.com
List-Id: iommu@lists.linux-foundation.org

On Wed, Apr 24, 2019 at 05:06:38PM +0200, Christoph Hellwig wrote:
> > +			if (!dma_release_from_contiguous(dev, page, count))
> > +				__free_pages(page, get_order(size));
> 
> Same for dma_release_from_contiguous - drop the _from, pass the
> actual size, and handle the free_pages fallback.

What do you think of dma_free_contiguous() instead? I feel "free"
is a bit more commonly used (in dma-mapping.h) and it's shorter.

Thanks
