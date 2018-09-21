From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] dma-debug: Check for drivers mapping vmalloc addresses
Date: Fri, 21 Sep 2018 07:25:37 +0200
Message-ID: <20180921052537.GB12825@lst.de>
References: <20180920223559.136915-1-swboyd@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180920223559.136915-1-swboyd@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Stephen Boyd <swboyd@chromium.org>
Cc: Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>
List-Id: iommu@lists.linux-foundation.org

On Thu, Sep 20, 2018 at 03:35:59PM -0700, Stephen Boyd wrote:
> I recently debugged a DMA mapping oops where a driver was trying to map
> a buffer returned from request_firmware() with dma_map_single(). Memory
> returned from request_firmware() is mapped into the vmalloc region and
> this isn't a valid region to map with dma_map_single() per the DMA
> documentation's "What memory is DMA'able?" section.
> 
> Unfortunately, we don't really check that in the DMA debugging code, so
> enabling DMA debugging doesn't help catch this problem. Let's add a new
> DMA debug function to check for a vmalloc address and print a warning if
> this happens. This makes it a little easier to debug these sorts of
> problems, instead of seeing odd behavior or crashes when drivers attempt
> to map the vmalloc space for DMA.

This looks sensible to me.  I wonder if we shouldn't just throw in
an unconditional

	WARN_ON_ONCE(is_vmalloc_addr(ptr)));

into dma_map_single_attrs, though.
